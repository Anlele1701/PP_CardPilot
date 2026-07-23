import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity({ name: 'banks' })
export class BankOrmEntity {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ name: 'swift_code', type: 'varchar', length: 20, nullable: true })
  swiftCode!: string | null;

  @Column({ type: 'varchar', length: 50 })
  name!: string;

  @Column({ name: 'short_name', type: 'varchar', length: 50, nullable: true })
  shortName!: string | null;

  @Column({ name: 'created_at', type: 'timestamptz', nullable: true })
  createdAt!: Date | null;

  @Column({ name: 'updated_at', type: 'timestamptz', nullable: true })
  updatedAt!: Date | null;
}
