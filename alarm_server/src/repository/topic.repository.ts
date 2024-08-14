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
        SELECT t.id,
               t.name,
               t.created_at,
               t.updated_at,
               COALESCE(a.room_count, 0) AS room_count
        FROM topic t
                 LEFT JOIN (
                   SELECT topic_id,
                          COUNT(id) AS room_count
                   FROM room
                   WHERE end_time > NOW()
                   GROUP BY topic_id
                 ) a ON t.id = a.topic_id
        ORDER BY room_count DESC
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

  async createTopic(topicName: string): Promise<Topic> {
    const topic = new Topic();
    topic.name = topicName;
    return await this.save(topic);
  }

  async deleteTopic(topicId: number): Promise<void> {
    await this.delete({ id: topicId });
  }
}
