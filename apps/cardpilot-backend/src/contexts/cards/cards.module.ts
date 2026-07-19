import { Module } from '@nestjs/common';
import { ListCardsUseCase } from './application/use-cases/list-cards.use-case';
import { CARD_REPOSITORY } from './domain/repositories/card.repository';
import { InMemoryCardRepository } from './infrastructure/persistence/in-memory-card.repository';
import { CardsController } from './presentation/http/cards.controller';

@Module({
  controllers: [CardsController],
  providers: [
    ListCardsUseCase,
    InMemoryCardRepository,
    {
      provide: CARD_REPOSITORY,
      useExisting: InMemoryCardRepository,
    },
  ],
})
export class CardsModule {}
