import { Injectable } from '@nestjs/common';
import moment from 'moment-timezone';
import { DataSource, Repository } from 'typeorm';
import { Room } from '../dto/room.entity';

@Injectable()
export class RoomRepository extends Repository<Room> {
  constructor(datasource: DataSource) {
    super(Room, datasource.createEntityManager());
  }

  async createRoom(room: Room): Promise<Room> {
    return await this.save(room);
  }

  async getRoomsByIds(ids: number[]): Promise<any[]> {
    if (ids.length === 0) {
      return [];
    }

    return await this.query(
      `SELECT room.*, topic.name AS topic_name, player.photo_url as player_photoUrl
       FROM room 
       JOIN topic ON room.topic_id = topic.id 
       JOIN player ON room.player_id = player.id
       WHERE room.id IN (${ids.map(() => '?').join(',')}) 
       AND room.end_time > NOW()`,
      ids,
    );
  }

  async getRooms(
    topicId: number | undefined,
    offset: number,
    limit: number,
  ): Promise<any> {
    let query = `
    SELECT room.*, topic.name as topic_name, player.photo_url as player_photoUrl
    FROM room 
    LEFT JOIN topic ON room.topic_id = topic.id
    LEFT JOIN player ON room.player_id = player.id
    WHERE room.end_time > NOW()
  `;

    if (topicId) {
      query += ` AND room.topic_id = ${topicId}`;
    }

    query += ` ORDER BY room.created_at DESC LIMIT ${limit} OFFSET ${offset}`;

    const results = await this.query(query);

    console.log(`results ------>  ${results}`);

    // 결과의 시간을 Asia/Seoul로 변환
    results.forEach((result) => {
      result.start_time = moment(result.start_time).tz('Asia/Seoul').format();
      result.end_time = moment(result.end_time).tz('Asia/Seoul').format();
    });

    return results;
  }
}
