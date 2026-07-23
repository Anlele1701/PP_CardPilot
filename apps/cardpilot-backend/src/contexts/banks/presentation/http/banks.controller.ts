import { Controller, Get } from '@nestjs/common';
import { BankResponseDto } from '../../application/dto/bank-response.dto';
import { ListBanksUseCase } from '../../application/use-cases/list-banks.use-case';

@Controller('banks')
export class BanksController {
  constructor(private readonly listBanksUseCase: ListBanksUseCase) {}

  @Get()
  async listBanks(): Promise<BankResponseDto[]> {
    return this.listBanksUseCase.execute();
  }
}
