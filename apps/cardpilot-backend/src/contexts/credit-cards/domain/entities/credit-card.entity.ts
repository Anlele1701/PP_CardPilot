import { Entity } from '../../../../core/domain/entity';

export interface CreditCardPrimitives {
  id: string;
  bankId: string;
  name: string;
  network: string | null;
  cardType: string;
  annualFee: string | null;
  sourceUrl: string | null;
  lastVerifiedAt: Date | null;
}

export class CreditCard extends Entity<string, CreditCardPrimitives> {
  private constructor(
    id: string,
    private readonly bankId: string,
    private readonly name: string,
    private readonly network: string | null,
    private readonly cardType: string,
    private readonly annualFee: string | null,
    private readonly sourceUrl: string | null,
    private readonly lastVerifiedAt: Date | null,
  ) {
    super(id);
  }

  static rehydrate(params: CreditCardPrimitives): CreditCard {
    return new CreditCard(
      params.id,
      params.bankId,
      params.name,
      params.network,
      params.cardType,
      params.annualFee,
      params.sourceUrl,
      params.lastVerifiedAt,
    );
  }

  toPrimitives(): CreditCardPrimitives {
    return {
      id: this.id,
      bankId: this.bankId,
      name: this.name,
      network: this.network,
      cardType: this.cardType,
      annualFee: this.annualFee,
      sourceUrl: this.sourceUrl,
      lastVerifiedAt: this.lastVerifiedAt,
    };
  }
}
