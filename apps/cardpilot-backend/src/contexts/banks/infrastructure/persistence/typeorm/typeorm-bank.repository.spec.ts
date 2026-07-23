import { Repository } from 'typeorm';
import { BankOrmEntity } from './bank.orm-entity';
import { TypeOrmBankRepository } from './typeorm-bank.repository';

describe('TypeOrmBankRepository', () => {
  it('should load banks ordered by name and map them to domain entities', async () => {
    const persistenceBank: BankOrmEntity = {
      id: '2334d773-ca10-5450-ba68-5007791948be',
      swiftCode: 'ASCBVNVX',
      name: 'Ngân hàng Á Châu',
      shortName: 'ACB',
      createdAt: new Date('2026-06-10T14:29:07.000Z'),
      updatedAt: new Date('2026-06-10T14:29:07.000Z'),
    };
    const typeOrmRepository = {
      find: jest.fn().mockResolvedValue([persistenceBank]),
    } as unknown as Repository<BankOrmEntity>;
    const repository = new TypeOrmBankRepository(typeOrmRepository);

    const banks = await repository.findAll();

    expect(typeOrmRepository.find).toHaveBeenCalledWith({
      order: {
        name: 'ASC',
      },
    });
    expect(banks.map((bank) => bank.toPrimitives())).toEqual([
      {
        id: persistenceBank.id,
        swiftCode: persistenceBank.swiftCode,
        name: persistenceBank.name,
        shortName: persistenceBank.shortName,
      },
    ]);
  });
});
