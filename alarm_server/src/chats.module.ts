import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ChatsGateway } from './chats.gateway';
import { Message } from './dto/message.entity';
import { Player } from './dto/player.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Message, Player])],
  providers: [ChatsGateway],
  exports: [],
})
export class ChatsModule {}
