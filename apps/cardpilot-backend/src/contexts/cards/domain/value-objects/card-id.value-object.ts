import { ValueObject } from '../../../../core/domain/value-object';

interface CardIdProps {
  value: string;
}

export class CardId extends ValueObject<CardIdProps> {
  private constructor(props: CardIdProps) {
    super(props);
  }

  static create(value: string): CardId {
    const normalizedValue = value.trim();

    if (!normalizedValue) {
      throw new Error('Card ID cannot be empty.');
    }

    return new CardId({ value: normalizedValue });
  }

  get value(): string {
    return this.props.value;
  }
}
