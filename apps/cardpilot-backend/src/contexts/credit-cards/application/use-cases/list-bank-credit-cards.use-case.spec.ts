import { Test } from '@nestjs/testing';
import { CreditCard } from '../../domain/entities/credit-card.entity';
import {
  CREDIT_CARD_REPOSITORY,
  CreditCardRepository,
} from '../../domain/repositories/credit-card.repository';
import { ListBankCreditCardsUseCase } from './list-bank-credit-cards.use-case';

describe('ListBankCreditCardsUseCase', () => {
  it('should return credit cards belonging to the selected bank', async () => {
    const bankId = '2334d773-ca10-5450-ba68-5007791948be';
    const repository: CreditCardRepository = {
      findActiveByBankId: jest.fn().mockResolvedValue([
        CreditCard.rehydrate({
          id: 'ce95ccb3-acbb-469d-b074-866eb629cb31',
          bankId,
          name: 'ACB Visa Platinum',
          network: 'Visa',
          cardType: 'credit',
          annualFee: '1299000.00',
          sourceUrl: null,
          lastVerifiedAt: null,
        }),
      ]),
    };

    const moduleRef = await Test.createTestingModule({
      providers: [
        ListBankCreditCardsUseCase,
        {
          provide: CREDIT_CARD_REPOSITORY,
          useValue: repository,
        },
      ],
    }).compile();
    const useCase = moduleRef.get(ListBankCreditCardsUseCase);

    await expect(useCase.execute(bankId)).resolves.toEqual([
      {
        id: 'ce95ccb3-acbb-469d-b074-866eb629cb31',
        bankId,
        name: 'ACB Visa Platinum',
        network: 'Visa',
        cardType: 'credit',
        annualFee: '1299000.00',
        sourceUrl: null,
        lastVerifiedAt: null,
      },
    ]);
    expect(repository.findActiveByBankId).toHaveBeenCalledWith(bankId);
  });
});
