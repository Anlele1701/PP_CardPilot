import { Entity } from '../../../../core/domain/entity';

export interface BankPrimitives {
  id: string;
  swiftCode: string | null;
  name: string;
  shortName: string | null;
}

export class Bank extends Entity<string, BankPrimitives> {
  private constructor(
    id: string,
    private readonly swiftCode: string | null,
    private readonly name: string,
    private readonly shortName: string | null,
  ) {
    super(id);
  }

  static rehydrate(params: {
    id: string;
    swiftCode: string | null;
    name: string;
    shortName: string | null;
  }): Bank {
    return new Bank(
      params.id,
      params.swiftCode,
      params.name,
      params.shortName,
    );
  }

  toPrimitives(): BankPrimitives {
    return {
      id: this.id,
      swiftCode: this.swiftCode,
      name: this.name,
      shortName: this.shortName,
    };
  }
}
