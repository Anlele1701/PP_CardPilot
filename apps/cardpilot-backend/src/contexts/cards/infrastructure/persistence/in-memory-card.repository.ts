import { Injectable } from '@nestjs/common';
import { Card } from '../../domain/entities/card.entity';
import { CardRepository } from '../../domain/repositories/card.repository';

@Injectable()
export class InMemoryCardRepository implements CardRepository {
  private readonly cards: Card[] = [
    Card.create({
      id: 'card_1',
      name: 'Pilot Starter Deck',
      createdAt: new Date('2026-01-10T10:00:00.000Z'),
    }),
    Card.create({
      id: 'card_2',
      name: 'Control Ledger',
      createdAt: new Date('2026-02-14T08:30:00.000Z'),
    }),
  ];

  async findAll(): Promise<Card[]> {
    return this.cards;
  }
}
