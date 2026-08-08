import { MigrationInterface, QueryRunner } from 'typeorm';

export class AddUserCardCreditLimit1786150000000 implements MigrationInterface {
  name = 'AddUserCardCreditLimit1786150000000';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
      ALTER TABLE "user_cards"
      ADD COLUMN "credit_limit" numeric(14, 2) NOT NULL DEFAULT 0,
      ADD CONSTRAINT "ck_user_cards_credit_limit_non_negative"
        CHECK ("credit_limit" >= 0)
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
      ALTER TABLE "user_cards"
      DROP CONSTRAINT "ck_user_cards_credit_limit_non_negative",
      DROP COLUMN "credit_limit"
    `);
  }
}
