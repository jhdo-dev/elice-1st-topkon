import { Injectable } from '@nestjs/common';
import { Player } from './dto/player.entity';
import { Room } from './dto/room.entity';
import { Topic } from './dto/topic.entity';
import { PlayerRepository } from './repository/player.repository';
import { RoomRepository } from './repository/room.repository';
import { TopicRepository } from './repository/topic.repository';

@Injectable()
export class AppService {
  constructor(
    private roomRepository: RoomRepository,
    private topicRepository: TopicRepository,
    private playerRepository: PlayerRepository,
  ) {}

  async getOrCratePlayer(userModel: any): Promise<Player> {
    const uuid: string = userModel.uuid;

    let player = await this.playerRepository.getPlayerByUuid(uuid);

    if (!player) {
      player = await this.playerRepository.createPlayer(userModel);
    }

    return player;
  }

  async updatePlayerDisplayName(
    uuid: string,
    displayName: string,
  ): Promise<Player> {
    return await this.playerRepository.updatePlayerDisplayName(
      uuid,
      displayName,
    );
  }

  async getTopicList(): Promise<any> {
    return await this.topicRepository.getTopicList();
  }

  async getRoomCountByTopic(): Promise<any> {
    return await this.topicRepository.getTopicListWithCount();
  }

  async createTopic(topicName: string): Promise<Topic> {
    return await this.topicRepository.createTopic(topicName);
  }

  async deleteTopic(topicId: number): Promise<void> {
    await this.topicRepository.deleteTopic(topicId);
  }

  async getRoomListByIds(ids: number[]): Promise<Room[]> {
    return await this.roomRepository.getRoomsByIds(ids);
  }

  async getRoomList(
    topicId: number | undefined,
    offset: number,
    limit: number,
  ): Promise<any> {
    const res: Room[] | undefined = await this.roomRepository.getRooms(
      topicId,
      offset,
      limit,
    );

    return {
      rooms: res,
      offset: offset + limit,
    };
  }

  async createRoom(
    topicId: number,
    roomName: string,
    playerId: number,
    startTime: Date,
    endTime: Date,
  ): Promise<Room> {
    const room = new Room();
    room.topicId = topicId;
    room.name = roomName;
    room.playerId = playerId;
    room.startTime = startTime;
    room.endTime = endTime;
    return await this.roomRepository.createRoom(room);
  }
}
