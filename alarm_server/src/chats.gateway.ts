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
    // 방에 접속되어 있지 않은 경우는 무시
    if (!client.rooms.has(room)) {
      return;
    }

    client.leave(room);
  }

  @SubscribeMessage('getUserList')
  handleGetUserList(client: Socket, room: string): void {
    this.server
      .to(room)
      .emit('userList', { room, userList: this.roomPlayerIds[room] });
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
    },
  ): Promise<void> {
    // playerId를 통해 Player 엔터티에서 displayName을 조회
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
      displayName: displayName, // Player의 displayName 사용
      msg: data.msg,
      myTurn: data.myTurn,
      msgDate: data.msgDate,
      msgTime: data.msgTime,
    });

    await this.messageRepository.save(newMessage);

    // 방에 있는 모든 클라이언트에게 메시지 전송
    this.server.to(data.roomId).emit('msg', {
      playerId: data.playerId,
      displayName: displayName, // Player의 displayName 전송
      msg: data.msg,
      roomId: data.roomId,
      myTurn: data.myTurn,
      msgDate: data.msgDate,
      msgTime: data.msgTime,
    });
  }
}
