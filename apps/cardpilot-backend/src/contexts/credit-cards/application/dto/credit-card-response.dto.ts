export interface CreditCardResponseDto {
  id: string;
  bankId: string;
  name: string;
  network: string | null;
  cardType: string;
  annualFee: string | null;
  sourceUrl: string | null;
  lastVerifiedAt: Date | null;
}
