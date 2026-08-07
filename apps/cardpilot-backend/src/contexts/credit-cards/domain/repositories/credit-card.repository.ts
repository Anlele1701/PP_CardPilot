import { CreditCard } from '../entities/credit-card.entity';

export const CREDIT_CARD_REPOSITORY = Symbol('CREDIT_CARD_REPOSITORY');

export interface CreditCardRepository {
  findActiveByBankId(bankId: string): Promise<CreditCard[]>;
}
