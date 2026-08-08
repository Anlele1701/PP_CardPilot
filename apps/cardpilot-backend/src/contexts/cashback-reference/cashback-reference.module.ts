import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CashbackReferenceService } from './application/cashback-reference.service';
import {
  MerchantCategoryCodeOrmEntity,
  MerchantMccCandidateOrmEntity,
  MerchantOrmEntity,
  RewardRuleMccOrmEntity,
  RewardRuleOrmEntity,
} from './infrastructure/typeorm/cashback-reference.orm-entities';
import { CashbackReferenceController } from './presentation/http/cashback-reference.controller';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      MerchantCategoryCodeOrmEntity,
      RewardRuleOrmEntity,
      RewardRuleMccOrmEntity,
      MerchantOrmEntity,
      MerchantMccCandidateOrmEntity,
    ]),
  ],
  controllers: [CashbackReferenceController],
  providers: [CashbackReferenceService],
})
export class CashbackReferenceModule {}
