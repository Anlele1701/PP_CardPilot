import { Entity } from '../../../../core/domain/entity';
import { CardId } from '../value-objects/card-id.value-object';
import { CardName } from '../value-objects/card-name.value-object';

export class Card extends Entity<string> {
  private constructor(
    private readonly cardId: CardId,
    private readonly name: CardName,
    private readonly createdAt: Date,
  ) {
    super(cardId.value);
  }

  static create(params: { id: string; name: string; createdAt?: Date }): Card {
    return new Card(
      CardId.create(params.id),
      CardName.create(params.name),
      params.createdAt ?? new Date(),
    );
  }

  toPrimitives() {
    return {
      id: this.cardId.value,
      name: this.name.value,
      createdAt: this.createdAt.toISOString(),
    };
  }
}
