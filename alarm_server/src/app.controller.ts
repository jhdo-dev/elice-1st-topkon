import { Body, Controller, Delete, Get, Patch, Post } from '@nestjs/common';
import { AppService } from './app.service';
import { Player } from './dto/player.entity';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get('/topic/list')
  async getTopicList(): Promise<any> {
    return await this.appService.getTopicList();
  }

  @Get('/topic/room-count')
  async getRoomCountByTopic(): Promise<any> {
    return await this.appService.getRoomCountByTopic();
  }

  @Post('/topic/create')
  async createTopic(@Body() body): Promise<any> {
    const topicName: string = body.topicName;

    try {
      const topic = await this.appService.createTopic(topicName);
      return {
        success: true,
        topic,
      };
    } catch (e) {
      return {
        success: false,
        error: e,
      };
    }
  }
  //! topicName(string)

  @Delete('/topic/delete')
  async deleteTopic(@Body() body): Promise<any> {
    const topicId: number = body.topicId;

    try {
      await this.appService.deleteTopic(topicId);
      return {
        success: true,
      };
    } catch (e) {
      return {
        success: false,
        error: e.message,
      };
    }
  }
  //! topicId(int)

  @Post('/player')
  async getOrCreatePlayer(@Body() body): Promise<Player> {
    return await this.appService.getOrCratePlayer(body);
  }

  @Patch('/player/update')
  async updatePlayer(@Body() body): Promise<Player> {
    const { uuid, displayName, email } = body;
    return await this.appService.updatePlayer(uuid, displayName, email);
  }

  @Patch('/player/update-fcm-token')
  async updatePlayerFcmToken(@Body() body): Promise<any> {
    const { uuid, fcmToken } = body;
    try {
      const player = await this.appService.updatePlayerFcmToken(uuid, fcmToken);
      return {
        success: true,
        player,
      };
    } catch (e) {
      return {
        success: false,
        error: e.message,
      };
    }
  }

  //! uuid (string)

  @Post('/room/list')
  async getRoomList(@Body() body): Promise<any> {
    const limit: number = body.limit;
    const offset: number = body.offset || 0;
    const topicId: number | undefined = body.topicId;

    return await this.appService.getRoomList(topicId, offset, limit);
  }
  //! limit(int), cursorId(string), topicId(int)

  @Post('/room/create')
  async createRoom(@Body() body): Promise<any> {
    const topicId: number = body.topicId;
    const roomName: string = body.roomName;
    const playerId: number = body.playerId;
    const startTime: Date = new Date(body.startTime);
    const endTime: Date = new Date(body.endTime);

    try {
      await this.appService.createRoom(
        topicId,
        roomName,
        playerId,
        startTime,
        endTime,
      );
      return {
        success: true,
      };
    } catch (e) {
      return {
        success: false,
        error: e,
      };
    }
  }
  //! topicId(int), roomName(string), playerId(int), startTime(datetime), endTime(datetime)

  @Post('/room/ids')
  async getRooms(@Body() body): Promise<any> {
    const roomIds = body.roomIds;
    return await this.appService.getRoomListByIds(roomIds);
  }
  //! roomIds(int)
}
