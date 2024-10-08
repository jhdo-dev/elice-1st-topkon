import { Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import {
  OnGatewayConnection,
  OnGatewayDisconnect,
  OnGatewayInit,
  SubscribeMessage,
  WebSocketGateway,
  WebSocketServer,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { Repository } from 'typeorm';
import { Message } from './dto/message.entity';
import { Player } from './dto/player.entity';
import { FirebaseService } from './firebase/firebase.service';

@WebSocketGateway(3001, {
  namespace: 'chat',
  cors: { origin: '*' },
})
export class ChatsGateway
  implements OnGatewayInit, OnGatewayConnection, OnGatewayDisconnect
{
  connectedClients: { [socketId: string]: boolean } = {};
  clientPlayerId: { [socketId: string]: string } = {};
  roomPlayerIds: { [key: string]: string[] } = {};

  constructor(
    @InjectRepository(Message)
    private readonly messageRepository: Repository<Message>,
    @InjectRepository(Player)
    private readonly playerRepository: Repository<Player>,
    private readonly firebaseService: FirebaseService,
  ) {}

  @WebSocketServer() server: Server;
  private logger: Logger = new Logger('ChatsGateway');

  getPlayerIds(roomId: string): string[] | undefined {
    return this.roomPlayerIds[roomId];
  }

  afterInit(server: Server) {
    this.logger.log('웹소켓 서버 초기화');
  }

  handleDisconnect(client: Socket) {
    this.logger.log(`Client Disconnected : ${client.id}`);

    if (this.connectedClients[client.id]) {
      delete this.connectedClients[client.id];
    }
  }

  handleConnection(client: Socket) {
    this.logger.log(`Client Connected : ${client.id}`);

    if (this.connectedClients[client.id]) {
      client.disconnect(true);
      return;
    }

    this.connectedClients[client.id] = true;
  }

  @SubscribeMessage('join')
  async handleJoin(
    client: Socket,
    data: { roomId: string; playerId: string },
  ): Promise<void> {
    const room = data.roomId;
    const playerId = data.playerId;

    this.clientPlayerId[client.id] = playerId;

    // 이미 접속한 방인지 확인
    if (client.rooms.has(room)) {
      return;
    }

    client.join(room);

    if (!this.roomPlayerIds[room]) {
      this.roomPlayerIds[room] = [];
    }

    // 방에 유저 추가
    this.roomPlayerIds[room].push(playerId);

    // 이전 메시지 기록 불러오기
    const previousMessages = await this.messageRepository.find({
      where: { roomId: room },
      order: { createdAt: 'DESC' }, // 메시지 생성 순서대로 정렬
    });

    // 클라이언트에게 이전 메시지 기록 전송
    client.emit('previousMessages', previousMessages);
  }

  @SubscribeMessage('exit')
  handleExit(client: Socket, data: { roomId: string }): void {
    const room = data.roomId;
    const playerId = this.clientPlayerId[client.id];
    // 방에 접속되어 있지 않은 경우는 무시
    if (!client.rooms.has(room)) {
      return;
    }

    client.leave(room);

    if (this.roomPlayerIds[room]) {
      // 방에서 유저 제거
      this.roomPlayerIds[room] = this.roomPlayerIds[room].filter(
        (id) => id !== playerId,
      );
    }
  }

  @SubscribeMessage('getUserList')
  async handleGetUserList(client: Socket, room: string): Promise<void> {
    console.log('Received getUserList request for room:', room);

    // 방에 있는 유저들의 displayName을 전송
    await this.sendUserList(room);
  }

  async sendUserList(room: string): Promise<void> {
    const playerIds = this.roomPlayerIds[room] || [];
    const displayNames: string[] = [];

    // 각 playerId에 대해 displayName을 조회
    for (const playerId of playerIds) {
      const player = await this.playerRepository.findOne({
        where: { uuid: playerId },
      });
      if (player) {
        displayNames.push(player.displayName);
      }
    }

    // 유저의 displayName 리스트를 전송
    this.server.to(room).emit('userList', { room, userList: displayNames });
  }

  @SubscribeMessage('msg')
  async handleChatMessage(
    client: Socket,
    data: {
      roomId: string;
      msg: string;
      playerId: string;
      myTurn: boolean;
      msgDate: string;
      msgTime: string;
      isDateChanged: boolean;
    },
  ): Promise<void> {
    const player = await this.playerRepository.findOne({
      where: { uuid: data.playerId },
    });

    if (!player) {
      this.logger.error(`Player with ID ${data.playerId} not found`);
      return;
    }

    const displayName = player.displayName;

    // 메시지를 DB에 저장
    const newMessage = this.messageRepository.create({
      roomId: data.roomId,
      playerId: data.playerId,
      displayName: displayName,
      msg: data.msg,
      myTurn: data.myTurn,
      msgDate: data.msgDate,
      msgTime: data.msgTime,
      isDateChanged: data.isDateChanged,
    });

    await this.messageRepository.save(newMessage);

    // 방에 있는 모든 클라이언트에게 메시지 전송
    this.server.to(data.roomId).emit('msg', {
      playerId: data.playerId,
      displayName: displayName,
      msg: data.msg,
      roomId: data.roomId,
      myTurn: data.myTurn,
      msgDate: data.msgDate,
      msgTime: data.msgTime,
      isDateChanged: data.isDateChanged,
    });

    // 현재 방에 있는 사용자들을 확인
    const playerIdsInRoom = this.getPlayerIds(data.roomId) || [];

    // DB에서 모든 플레이어 조회
    const allPlayers = await this.playerRepository.find();

    // 현재 방에 없는 사용자에게만 FCM 알림 발송
    for (const roomPlayer of allPlayers) {
      if (!playerIdsInRoom.includes(roomPlayer.uuid) && roomPlayer.fcmToken) {
        // 방에 없는 사용자에게만 알림을 보냄
        await this.firebaseService.sendNotification(
          roomPlayer.fcmToken,
          `${displayName}`,
          `${data.msg}`,
        );
      }
    }
  }

  private async getFcmTokenForPlayer(playerId: string): Promise<string | null> {
    // 여기에서 플레이어 ID로 FCM 토큰을 가져오는 로직을 구현하세요.
    // 예시: 데이터베이스에서 해당 플레이어의 FCM 토큰을 조회
    const player = await this.playerRepository.findOne({
      where: { uuid: playerId },
    });

    return player ? player.fcmToken : null;
  }
}
