import { Injectable } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { Topic } from '../dto/topic.entity';

@Injectable()
export class TopicRepository extends Repository<Topic> {
  constructor(datasource: DataSource) {
    super(Topic, datasource.createEntityManager());
  }

  async getTopicList(): Promise<any> {
    return await this.query(`
        SELECT 
    t.id,
    t.name,
    t.created_at,
    t.updated_at,
    COALESCE(a.room_count, 0) AS room_count
FROM 
    topic t
LEFT JOIN 
    (
        SELECT 
            r.topic_id,
            COUNT(r.id) AS room_count
        FROM 
            room r
        LEFT JOIN 
            player p ON r.player_id = p.id
        WHERE 
            r.end_time > NOW() AND p.id IS NOT NULL
        GROUP BY 
            r.topic_id
    ) a ON t.id = a.topic_id
ORDER BY 
    room_count DESC
    `);
  }

  async getTopicListWithCount(): Promise<any> {
    return await this.query(`
        SELECT t.id,
               COALESCE(a.room_count, 0) AS room_count
        FROM topic t
                 LEFT JOIN (SELECT topic_id,
                                   COUNT(id) AS room_count
                            FROM room
                            WHERE end_time > NOW()
                            GROUP BY topic_id) a ON t.id = a.topic_id
        ORDER BY room_count DESC
    `);
  }

  async createTopic(topicName: string): Promise<any> {
    const topic = new Topic();
    topic.name = topicName;
    const savedTopic = await this.save(topic);

    const roomCountResult = await this.query(
      `
      SELECT COALESCE(COUNT(id), 0) AS room_count
      FROM room
      WHERE topic_id = ?
        AND end_time > NOW()
    `,
      [savedTopic.id],
    );

    const roomCount = roomCountResult[0]?.room_count || 0;

    return {
      ...savedTopic,
      room_count: roomCount,
    };
  }

  async deleteTopic(topicId: number): Promise<void> {
    await this.delete({ id: topicId });
  }
}
