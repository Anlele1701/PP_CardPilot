import { Bank } from '../entities/bank.entity';

export const BANK_REPOSITORY = Symbol('BANK_REPOSITORY');

export interface BankRepository {
  findAll(): Promise<Bank[]>;
}
