import { Inject, Injectable } from '@nestjs/common';
import { UseCase } from '../../../../core/application/use-case';
import {
  CREDIT_CARD_REPOSITORY,
  CreditCardRepository,
} from '../../domain/repositories/credit-card.repository';
import { CreditCardResponseDto } from '../dto/credit-card-response.dto';

@Injectable()
export class ListBankCreditCardsUseCase
  implements UseCase<Promise<CreditCardResponseDto[]>, [bankId: string]>
{
  constructor(
    @Inject(CREDIT_CARD_REPOSITORY)
    private readonly creditCardRepository: CreditCardRepository,
  ) {}

  async execute(bankId: string): Promise<CreditCardResponseDto[]> {
    const creditCards =
      await this.creditCardRepository.findActiveByBankId(bankId);

    return creditCards.map((creditCard) => creditCard.toPrimitives());
  }
}
