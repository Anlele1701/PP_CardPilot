import { Repository } from 'typeorm';
import { CreditCardOrmEntity } from './credit-card.orm-entity';
import { TypeOrmCreditCardRepository } from './typeorm-credit-card.repository';

describe('TypeOrmCreditCardRepository', () => {
  it('should load active credit cards for a bank ordered by name', async () => {
    const bankId = '2334d773-ca10-5450-ba68-5007791948be';
    const persistenceCreditCard: CreditCardOrmEntity = {
      id: 'ce95ccb3-acbb-469d-b074-866eb629cb31',
      bankId,
      name: 'ACB Visa Platinum',
      network: 'Visa',
      cardType: 'credit',
      annualFee: '1299000.00',
      sourceUrl: null,
      lastVerifiedAt: null,
      isActive: true,
      createdAt: new Date('2026-08-06T00:00:00.000Z'),
      updatedAt: new Date('2026-08-06T00:00:00.000Z'),
    };
    const typeOrmRepository = {
      find: jest.fn().mockResolvedValue([persistenceCreditCard]),
    } as unknown as Repository<CreditCardOrmEntity>;
    const repository = new TypeOrmCreditCardRepository(typeOrmRepository);

    const creditCards = await repository.findActiveByBankId(bankId);

    expect(typeOrmRepository.find).toHaveBeenCalledWith({
      where: { bankId, isActive: true },
      order: { name: 'ASC' },
    });
    expect(creditCards.map((creditCard) => creditCard.toPrimitives())).toEqual([
      {
        id: persistenceCreditCard.id,
        bankId,
        name: persistenceCreditCard.name,
        network: persistenceCreditCard.network,
        cardType: persistenceCreditCard.cardType,
        annualFee: persistenceCreditCard.annualFee,
        sourceUrl: persistenceCreditCard.sourceUrl,
        lastVerifiedAt: persistenceCreditCard.lastVerifiedAt,
      },
    ]);
  });
});
