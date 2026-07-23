import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ListBanksUseCase } from './application/use-cases/list-banks.use-case';
import { BANK_REPOSITORY } from './domain/repositories/bank.repository';
import { BankOrmEntity } from './infrastructure/persistence/typeorm/bank.orm-entity';
import { TypeOrmBankRepository } from './infrastructure/persistence/typeorm/typeorm-bank.repository';
import { BanksController } from './presentation/http/banks.controller';

@Module({
  imports: [TypeOrmModule.forFeature([BankOrmEntity])],
  controllers: [BanksController],
  providers: [
    ListBanksUseCase,
    TypeOrmBankRepository,
    {
      provide: BANK_REPOSITORY,
      useExisting: TypeOrmBankRepository,
    },
  ],
})
export class BanksModule {}
