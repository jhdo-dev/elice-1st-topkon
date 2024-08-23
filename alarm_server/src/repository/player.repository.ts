import { Injectable, NotFoundException } from '@nestjs/common';
import { DataSource, Repository } from 'typeorm';
import { Player } from '../dto/player.entity';

@Injectable()
export class PlayerRepository extends Repository<Player> {
  constructor(datasource: DataSource) {
    super(Player, datasource.createEntityManager());
  }

  async getPlayerByUuid(uuid: string): Promise<Player | undefined> {
    return await this.findOneBy({ uuid });
  }

  async createPlayer(userModel: any): Promise<Player> {
    const player = new Player();
    player.uuid = userModel.uuid;
    player.displayName = userModel.displayName;
    player.email = userModel.email;
    player.photoUrl = userModel.photoUrl;
    player.loginType = userModel.loginType;
    player.fcmToken = userModel.fcmToken;

    return await this.save(player);
  }

  async updatePlayerDetails(
    uuid: string,
    displayName: string | null,
    email: string | null,
  ): Promise<Player> {
    const player = await this.getPlayerByUuid(uuid);
    if (!player) {
      throw new NotFoundException('Player not found');
    }

    if (displayName != null && displayName.trim() !== '') {
      player.displayName = displayName;
    }

    if (email != null && email.trim() !== '') {
      player.email = email;
    }

    return await this.save(player);
  }
}
