import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Bank } from '../../../domain/entities/bank.entity';
import { BankRepository } from '../../../domain/repositories/bank.repository';
import { BankOrmEntity } from './bank.orm-entity';

@Injectable()
export class TypeOrmBankRepository implements BankRepository {
  constructor(
    @InjectRepository(BankOrmEntity)
    private readonly repository: Repository<BankOrmEntity>,
  ) {}

  async findAll(): Promise<Bank[]> {
    const banks = await this.repository.find({
      order: {
        name: 'ASC',
      },
    });

    return banks.map((bank) =>
      Bank.rehydrate({
        id: bank.id,
        swiftCode: bank.swiftCode,
        name: bank.name,
        shortName: bank.shortName
      }),
    );
  }
}
