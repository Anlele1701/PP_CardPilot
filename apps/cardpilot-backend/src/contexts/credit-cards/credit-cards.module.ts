import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ListBankCreditCardsUseCase } from './application/use-cases/list-bank-credit-cards.use-case';
import { CREDIT_CARD_REPOSITORY } from './domain/repositories/credit-card.repository';
import { CreditCardOrmEntity } from './infrastructure/persistence/typeorm/credit-card.orm-entity';
import { TypeOrmCreditCardRepository } from './infrastructure/persistence/typeorm/typeorm-credit-card.repository';
import { BankCreditCardsController } from './presentation/http/bank-credit-cards.controller';

@Module({
  imports: [TypeOrmModule.forFeature([CreditCardOrmEntity])],
  controllers: [BankCreditCardsController],
  providers: [
    ListBankCreditCardsUseCase,
    TypeOrmCreditCardRepository,
    {
      provide: CREDIT_CARD_REPOSITORY,
      useExisting: TypeOrmCreditCardRepository,
    },
  ],
})
export class CreditCardsModule {}
