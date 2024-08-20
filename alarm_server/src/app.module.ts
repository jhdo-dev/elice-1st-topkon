import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { config } from 'dotenv';
import { SnakeNamingStrategy } from 'typeorm-naming-strategies';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ChatsModule } from './chats.module';
import { Message } from './dto/message.entity';
import { Player } from './dto/player.entity';
import { Room } from './dto/room.entity';
import { Topic } from './dto/topic.entity';
import { PlayerRepository } from './repository/player.repository';
import { RoomRepository } from './repository/room.repository';
import { TopicRepository } from './repository/topic.repository';

config();
@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: '.env',
    }),
    ChatsModule,
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: (configService: ConfigService) => ({
        type: 'mysql',
        host: configService.get('DB_HOST'),
        port: configService.get<number>('DB_PORT'),
        username: configService.get<string>('DB_USERNAME'),
        password: configService.get<string>('DB_PASSWORD'),
        database: configService.get<string>('DB_DATABASE'),
        entities: [Room, Topic, Player, Message],
        synchronize: true,
        namingStrategy: new SnakeNamingStrategy(),
        timezone: '+09:00',
      }),
      inject: [ConfigService],
    }),
  ],
  controllers: [AppController],
  providers: [AppService, RoomRepository, TopicRepository, PlayerRepository],
})
export class AppModule {}
