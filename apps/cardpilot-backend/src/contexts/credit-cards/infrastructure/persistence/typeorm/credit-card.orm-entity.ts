import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity({ name: 'credit_cards' })
export class CreditCardOrmEntity {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ name: 'bank_id', type: 'uuid' })
  bankId!: string;

  @Column({ type: 'varchar' })
  name!: string;

  @Column({ type: 'varchar', nullable: true })
  network!: string | null;

  @Column({ name: 'card_type', type: 'varchar', default: 'credit' })
  cardType!: string;

  @Column({
    name: 'annual_fee',
    type: 'numeric',
    precision: 14,
    scale: 2,
    nullable: true,
  })
  annualFee!: string | null;

  @Column({ name: 'source_url', type: 'text', nullable: true })
  sourceUrl!: string | null;

  @Column({ name: 'last_verified_at', type: 'timestamptz', nullable: true })
  lastVerifiedAt!: Date | null;

  @Column({ name: 'is_active', type: 'boolean', default: true })
  isActive!: boolean;

  @Column({ name: 'created_at', type: 'timestamptz', nullable: true })
  createdAt!: Date | null;

  @Column({ name: 'updated_at', type: 'timestamptz', nullable: true })
  updatedAt!: Date | null;
}
