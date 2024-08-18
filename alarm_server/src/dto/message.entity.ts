import {
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
} from 'typeorm';

@Entity('messages')
export class Message {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  roomId: string;

  @Column()
  playerId: string;

  @Column()
  displayName: string;

  @Column()
  msg: string;

  @Column({ default: false })
  myTurn: boolean;

  @CreateDateColumn({ type: 'timestamp' })
  createdAt: Date;
}
