import { ValueObject } from '../../../../core/domain/value-object';

interface CardNameProps {
  value: string;
}

export class CardName extends ValueObject<CardNameProps> {
  private constructor(props: CardNameProps) {
    super(props);
  }

  static create(value: string): CardName {
    const normalizedValue = value.trim();

    if (!normalizedValue) {
      throw new Error('Card name cannot be empty.');
    }

    if (normalizedValue.length > 80) {
      throw new Error('Card name cannot exceed 80 characters.');
    }

    return new CardName({ value: normalizedValue });
  }

  get value(): string {
    return this.props.value;
  }
}
