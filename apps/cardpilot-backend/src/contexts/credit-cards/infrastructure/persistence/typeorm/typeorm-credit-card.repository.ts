import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CreditCard } from '../../../domain/entities/credit-card.entity';
import { CreditCardRepository } from '../../../domain/repositories/credit-card.repository';
import { CreditCardOrmEntity } from './credit-card.orm-entity';

@Injectable()
export class TypeOrmCreditCardRepository implements CreditCardRepository {
  constructor(
    @InjectRepository(CreditCardOrmEntity)
    private readonly repository: Repository<CreditCardOrmEntity>,
  ) {}

  async findActiveByBankId(bankId: string): Promise<CreditCard[]> {
    const creditCards = await this.repository.find({
      where: {
        bankId,
        isActive: true,
      },
      order: {
        name: 'ASC',
      },
    });

    return creditCards.map((creditCard) =>
      CreditCard.rehydrate({
        id: creditCard.id,
        bankId: creditCard.bankId,
        name: creditCard.name,
        network: creditCard.network,
        cardType: creditCard.cardType,
        annualFee: creditCard.annualFee,
        sourceUrl: creditCard.sourceUrl,
        lastVerifiedAt: creditCard.lastVerifiedAt,
      }),
    );
  }
}
