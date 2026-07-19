import { Test } from '@nestjs/testing';
import { Card } from '../../domain/entities/card.entity';
import {
  CARD_REPOSITORY,
  CardRepository,
} from '../../domain/repositories/card.repository';
import { ListCardsUseCase } from './list-cards.use-case';

describe('ListCardsUseCase', () => {
  it('should map domain entities into DTOs', async () => {
    const repository: CardRepository = {
      findAll: jest.fn().mockResolvedValue([
        Card.create({
          id: 'card_1',
          name: 'Pilot Starter Deck',
          createdAt: new Date('2026-01-10T10:00:00.000Z'),
        }),
      ]),
    };

    const moduleRef = await Test.createTestingModule({
      providers: [
        ListCardsUseCase,
        {
          provide: CARD_REPOSITORY,
          useValue: repository,
        },
      ],
    }).compile();

    const useCase = moduleRef.get(ListCardsUseCase);

    await expect(useCase.execute()).resolves.toEqual([
      {
        id: 'card_1',
        name: 'Pilot Starter Deck',
        createdAt: '2026-01-10T10:00:00.000Z',
      },
    ]);
  });
});
