import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Not, Repository } from 'typeorm';
import {
  MerchantCategoryCodeOrmEntity,
  MerchantMccCandidateOrmEntity,
  MerchantOrmEntity,
  RewardRuleMccOrmEntity,
  RewardRuleOrmEntity,
} from '../infrastructure/typeorm/cashback-reference.orm-entities';

@Injectable()
export class CashbackReferenceService {
  constructor(
    @InjectRepository(MerchantCategoryCodeOrmEntity)
    private readonly mccRepository: Repository<MerchantCategoryCodeOrmEntity>,
    @InjectRepository(RewardRuleOrmEntity)
    private readonly ruleRepository: Repository<RewardRuleOrmEntity>,
    @InjectRepository(RewardRuleMccOrmEntity)
    private readonly ruleMccRepository: Repository<RewardRuleMccOrmEntity>,
    @InjectRepository(MerchantOrmEntity)
    private readonly merchantRepository: Repository<MerchantOrmEntity>,
    @InjectRepository(MerchantMccCandidateOrmEntity)
    private readonly candidateRepository: Repository<MerchantMccCandidateOrmEntity>,
  ) {}

  async listMccs() {
    const rows = await this.mccRepository.find({
      where: { isActive: true },
      order: { code: 'ASC' },
    });
    return rows.map((row) => ({
      code: row.code,
      description: row.description,
      category: row.category,
      validPayment: row.validPayment,
      updatedAt: row.updatedAt,
    }));
  }

  async listRewardRules(creditCardId: string) {
    const rules = await this.ruleRepository.find({
      where: { creditCardId, isActive: true },
      order: { name: 'ASC' },
    });
    const mappings = rules.length
      ? await this.ruleMccRepository.find({
          where: { rewardRuleId: In(rules.map((rule) => rule.id)) },
          order: { mccCode: 'ASC' },
        })
      : [];

    return rules.map((rule) => ({
      id: rule.id,
      creditCardId: rule.creditCardId,
      name: rule.name,
      rewardType: rule.rewardType,
      cashbackRate: rule.cashbackRate,
      pointsRate: rule.pointsRate,
      monthlyCapAmount: rule.monthlyCapAmount,
      minimumTransactionAmount: rule.minimumTransactionAmount,
      minimumMonthlySpend: rule.minimumMonthlySpend,
      eligibleChannel: rule.eligibleChannel,
      conditionsText: rule.conditionsText,
      effectiveFrom: rule.effectiveFrom,
      effectiveTo: rule.effectiveTo,
      sourceUrl: rule.sourceUrl,
      confidence: rule.confidence,
      lastVerifiedAt: rule.lastVerifiedAt,
      updatedAt: rule.updatedAt,
      mccs: mappings
        .filter((mapping) => mapping.rewardRuleId === rule.id)
        .map((mapping) => ({
          id: mapping.id,
          mccCode: mapping.mccCode,
          matchType: mapping.matchType,
        })),
    }));
  }

  async suggestMerchantMccs(query: string) {
    const normalized = query.trim().toLocaleLowerCase('vi-VN');
    if (normalized.length < 2) return [];

    const merchants = await this.merchantRepository
      .createQueryBuilder('merchant')
      .where('merchant.name_normalized ILIKE :query', {
        query: `%${normalized}%`,
      })
      .orderBy(
        'CASE WHEN merchant.name_normalized = :exact THEN 0 ELSE 1 END',
        'ASC',
      )
      .addOrderBy('merchant.name_raw', 'ASC')
      .setParameter('exact', normalized)
      .take(20)
      .getMany();
    if (merchants.length === 0) return [];

    const candidates = await this.candidateRepository.find({
      where: {
        merchantId: In(merchants.map((merchant) => merchant.id)),
        status: Not('rejected'),
      },
    });
    candidates.sort((left, right) => {
      const statusDifference =
        this.statusPriority(left.status) - this.statusPriority(right.status);
      if (statusDifference !== 0) return statusDifference;
      return (
        Number(right.confidenceScore ?? 0) - Number(left.confidenceScore ?? 0)
      );
    });
    const mccCodes = [...new Set(candidates.map((item) => item.mccCode))];
    const mccs = mccCodes.length
      ? await this.mccRepository.findBy({ code: In(mccCodes) })
      : [];

    return candidates.map((candidate) => {
      const merchant = merchants.find(
        (item) => item.id === candidate.merchantId,
      )!;
      const mcc = mccs.find((item) => item.code === candidate.mccCode);
      return {
        candidateId: candidate.id,
        merchantId: merchant.id,
        merchantName: merchant.nameRaw,
        locationText: merchant.locationText,
        mccCode: candidate.mccCode,
        mccDescription: mcc?.description ?? null,
        paymentType: candidate.paymentType,
        source: candidate.source,
        confidence: candidate.confidenceScore,
        status: candidate.status,
      };
    });
  }

  async listMerchants() {
    const merchants = await this.merchantRepository.find({
      order: { nameNormalized: 'ASC', nameRaw: 'ASC', locationText: 'ASC' },
    });
    if (merchants.length === 0) return [];

    const candidates = await this.candidateRepository.find({
      where: {
        merchantId: In(merchants.map((merchant) => merchant.id)),
        status: Not('rejected'),
      },
    });
    candidates.sort((left, right) => {
      const merchantDifference = left.merchantId.localeCompare(
        right.merchantId,
      );
      if (merchantDifference !== 0) return merchantDifference;
      const paymentDifference = left.paymentType.localeCompare(
        right.paymentType,
      );
      if (paymentDifference !== 0) return paymentDifference;
      const statusDifference =
        this.statusPriority(left.status) - this.statusPriority(right.status);
      if (statusDifference !== 0) return statusDifference;
      return (
        Number(right.confidenceScore ?? 0) - Number(left.confidenceScore ?? 0)
      );
    });

    const mccCodes = [...new Set(candidates.map((item) => item.mccCode))];
    const mccs = mccCodes.length
      ? await this.mccRepository.findBy({ code: In(mccCodes) })
      : [];
    const descriptions = new Map(
      mccs.map((mcc) => [mcc.code, mcc.description]),
    );

    return merchants.map((merchant) => ({
      id: merchant.id,
      name: merchant.nameRaw,
      nameNormalized: merchant.nameNormalized,
      locationText: merchant.locationText,
      candidates: candidates
        .filter((candidate) => candidate.merchantId === merchant.id)
        .map((candidate) => ({
          id: candidate.id,
          mccCode: candidate.mccCode,
          mccDescription: descriptions.get(candidate.mccCode) ?? null,
          paymentType: candidate.paymentType,
          source: candidate.source,
          confidence: candidate.confidenceScore,
          status: candidate.status,
        })),
    }));
  }

  private statusPriority(status: string): number {
    if (status === 'verified') return 0;
    if (status === 'suggested') return 1;
    return 2;
  }
}
