import { Inject, Injectable } from '@nestjs/common';
import { UseCase } from '../../../../core/application/use-case';
import {
  CARD_REPOSITORY,
  CardRepository,
} from '../../domain/repositories/card.repository';
import { CardResponseDto } from '../dto/card-response.dto';

@Injectable()
export class ListCardsUseCase implements UseCase<Promise<CardResponseDto[]>> {
  constructor(
    @Inject(CARD_REPOSITORY)
    private readonly cardRepository: CardRepository,
  ) {}

  async execute(): Promise<CardResponseDto[]> {
    const cards = await this.cardRepository.findAll();

    return cards.map((card) => card.toPrimitives());
  }
}
