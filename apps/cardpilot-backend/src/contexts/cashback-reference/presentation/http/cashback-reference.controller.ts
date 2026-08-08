import { Controller, Get, Param, ParseUUIDPipe, Query } from '@nestjs/common';
import { CashbackReferenceService } from '../../application/cashback-reference.service';

@Controller()
export class CashbackReferenceController {
  constructor(private readonly service: CashbackReferenceService) {}

  @Get('merchant-category-codes')
  listMccs() {
    return this.service.listMccs();
  }

  @Get('credit-cards/:creditCardId/reward-rules')
  listRewardRules(@Param('creditCardId', ParseUUIDPipe) creditCardId: string) {
    return this.service.listRewardRules(creditCardId);
  }

  @Get('merchants/mcc-suggestions')
  suggestMerchantMccs(@Query('query') query = '') {
    return this.service.suggestMerchantMccs(query);
  }

  @Get('merchants')
  listMerchants() {
    return this.service.listMerchants();
  }
}
