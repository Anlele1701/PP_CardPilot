import { Column, Entity, PrimaryColumn, PrimaryGeneratedColumn } from 'typeorm';

@Entity({ name: 'merchant_category_codes' })
export class MerchantCategoryCodeOrmEntity {
  @PrimaryColumn({ type: 'varchar', name: 'code', length: 4 })
  code!: string;

  @Column({ type: 'text' })
  description!: string;

  @Column({ type: 'varchar', nullable: true })
  category!: string | null;

  @Column({ name: 'valid_payment', type: 'varchar', nullable: true })
  validPayment!: string | null;

  @Column({ name: 'is_active', type: 'boolean', default: true })
  isActive!: boolean;

  @Column({ name: 'updated_at', type: 'timestamptz', nullable: true })
  updatedAt!: Date | null;
}

@Entity({ name: 'reward_rules' })
export class RewardRuleOrmEntity {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ name: 'credit_card_id', type: 'uuid' })
  creditCardId!: string;

  @Column({ type: 'varchar' })
  name!: string;

  @Column({ name: 'reward_type', type: 'varchar' })
  rewardType!: string;

  @Column({ name: 'cashback_rate', type: 'numeric', nullable: true })
  cashbackRate!: string | null;

  @Column({ name: 'points_rate', type: 'numeric', nullable: true })
  pointsRate!: string | null;

  @Column({ name: 'monthly_cap_amount', type: 'numeric', nullable: true })
  monthlyCapAmount!: string | null;

  @Column({
    name: 'minimum_transaction_amount',
    type: 'numeric',
    nullable: true,
  })
  minimumTransactionAmount!: string | null;

  @Column({ name: 'minimum_monthly_spend', type: 'numeric', nullable: true })
  minimumMonthlySpend!: string | null;

  @Column({ name: 'eligible_channel', type: 'varchar', default: 'any' })
  eligibleChannel!: string;

  @Column({ name: 'conditions_text', type: 'text', nullable: true })
  conditionsText!: string | null;

  @Column({ name: 'effective_from', type: 'date', nullable: true })
  effectiveFrom!: string | null;

  @Column({ name: 'effective_to', type: 'date', nullable: true })
  effectiveTo!: string | null;

  @Column({ name: 'source_url', type: 'text', nullable: true })
  sourceUrl!: string | null;

  @Column({ type: 'numeric', nullable: true })
  confidence!: string | null;

  @Column({ name: 'last_verified_at', type: 'timestamptz', nullable: true })
  lastVerifiedAt!: Date | null;

  @Column({ name: 'is_active', type: 'boolean', default: true })
  isActive!: boolean;

  @Column({ name: 'updated_at', type: 'timestamptz', nullable: true })
  updatedAt!: Date | null;
}

@Entity({ name: 'reward_rule_mccs' })
export class RewardRuleMccOrmEntity {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ name: 'reward_rule_id', type: 'uuid' })
  rewardRuleId!: string;

  @Column({ name: 'mcc_code', type: 'varchar', length: 4 })
  mccCode!: string;

  @Column({ name: 'match_type', type: 'varchar' })
  matchType!: string;
}

@Entity({ name: 'merchants' })
export class MerchantOrmEntity {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ name: 'name_raw', type: 'text' })
  nameRaw!: string;

  @Column({ name: 'name_normalized', type: 'text' })
  nameNormalized!: string;

  @Column({ name: 'location_text', type: 'text', nullable: true })
  locationText!: string | null;
}

@Entity({ name: 'merchant_mcc_candidates' })
export class MerchantMccCandidateOrmEntity {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ name: 'merchant_id', type: 'uuid' })
  merchantId!: string;

  @Column({ name: 'mcc_code', type: 'varchar', length: 4 })
  mccCode!: string;

  @Column({ type: 'varchar' })
  source!: string;

  @Column({ name: 'payment_type', type: 'varchar', default: 'unknown' })
  paymentType!: string;

  @Column({ name: 'confidence_score', type: 'numeric', nullable: true })
  confidenceScore!: string | null;

  @Column({ type: 'varchar', default: 'suggested' })
  status!: string;
}
