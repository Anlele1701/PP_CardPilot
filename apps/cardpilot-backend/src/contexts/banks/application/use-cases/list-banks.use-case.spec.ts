import { Test } from '@nestjs/testing';
import { Bank } from '../../domain/entities/bank.entity';
import {
  BANK_REPOSITORY,
  BankRepository,
} from '../../domain/repositories/bank.repository';
import { ListBanksUseCase } from './list-banks.use-case';

describe('ListBanksUseCase', () => {
  it('should map domain entities into response DTOs', async () => {
    const repository: BankRepository = {
      findAll: jest.fn().mockResolvedValue([
        Bank.rehydrate({
          id: '2334d773-ca10-5450-ba68-5007791948be',
          swiftCode: 'ASCBVNVX',
          name: 'Ngân hàng Á Châu',
          shortName: 'ACB',
        }),
      ]),
    };

    const moduleRef = await Test.createTestingModule({
      providers: [
        ListBanksUseCase,
        {
          provide: BANK_REPOSITORY,
          useValue: repository,
        },
      ],
    }).compile();

    const useCase = moduleRef.get(ListBanksUseCase);

    await expect(useCase.execute()).resolves.toEqual([
      {
        id: '2334d773-ca10-5450-ba68-5007791948be',
        swiftCode: 'ASCBVNVX',
        name: 'Ngân hàng Á Châu',
        shortName: 'ACB',
      },
    ]);
  });
});
