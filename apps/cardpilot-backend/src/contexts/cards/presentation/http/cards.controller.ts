import { Controller, Get } from '@nestjs/common';
import { ListCardsUseCase } from '../../application/use-cases/list-cards.use-case';

@Controller('cards')
export class CardsController {
  constructor(private readonly listCardsUseCase: ListCardsUseCase) {}

  @Get()
  async listCards() {
    return this.listCardsUseCase.execute();
  }
}
