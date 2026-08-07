import { Controller, Get, Param, ParseUUIDPipe } from '@nestjs/common';
import { CreditCardResponseDto } from '../../application/dto/credit-card-response.dto';
import { ListBankCreditCardsUseCase } from '../../application/use-cases/list-bank-credit-cards.use-case';

@Controller('banks/:bankId/credit-cards')
export class BankCreditCardsController {
  constructor(
    private readonly listBankCreditCardsUseCase: ListBankCreditCardsUseCase,
  ) {}

  @Get()
  async listBankCreditCards(
    @Param('bankId', ParseUUIDPipe) bankId: string,
  ): Promise<CreditCardResponseDto[]> {
    return this.listBankCreditCardsUseCase.execute(bankId);
  }
}
