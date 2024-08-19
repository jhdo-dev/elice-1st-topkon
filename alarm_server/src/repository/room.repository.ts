import { Injectable } from '@nestjs/common';
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
    return await this.query(
      `SELECT room.*, topic.name AS topic_name 
       FROM room 
       JOIN topic ON room.topic_id = topic.id 
       WHERE room.id IN (${ids.join(',')}) 
       AND room.end_time > NOW()`,
    );
  }

  async getRooms(
    topicId: number | undefined,
    offset: number,
    limit: number,
  ): Promise<any> {
    let query = `
      SELECT room.*, topic.name as topic_name 
      FROM room 
      JOIN topic ON room.topic_id = topic.id
      WHERE room.end_time > NOW()
    `;

    if (topicId) {
      query += ` AND room.topic_id = ${topicId}`;
    }

    query += ` ORDER BY room.created_at DESC LIMIT ${limit} OFFSET ${offset}`;

    return await this.query(query);
  }
}
