import { Card } from '../entities/card.entity';

export const CARD_REPOSITORY = Symbol('CARD_REPOSITORY');

export interface CardRepository {
  findAll(): Promise<Card[]>;
}
