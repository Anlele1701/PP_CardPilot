import { Inject, Injectable } from '@nestjs/common';
import { UseCase } from '../../../../core/application/use-case';
import {
  BANK_REPOSITORY,
  BankRepository,
} from '../../domain/repositories/bank.repository';
import { BankResponseDto } from '../dto/bank-response.dto';

@Injectable()
export class ListBanksUseCase implements UseCase<Promise<BankResponseDto[]>> {
  constructor(
    @Inject(BANK_REPOSITORY)
    private readonly bankRepository: BankRepository,
  ) {}

  async execute(): Promise<BankResponseDto[]> {
    const banks = await this.bankRepository.findAll();

    return banks.map((bank) => bank.toPrimitives());
  }
}
