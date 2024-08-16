import { Injectable } from '@nestjs/common';
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

    return await this.save(player);
  }
}
