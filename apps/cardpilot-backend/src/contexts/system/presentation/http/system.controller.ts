import { Controller, Get } from '@nestjs/common';
import { GetApiInfoUseCase } from '../../application/use-cases/get-api-info.use-case';

@Controller()
export class SystemController {
  constructor(private readonly getApiInfoUseCase: GetApiInfoUseCase) {}

  @Get()
  getApiInfo() {
    return this.getApiInfoUseCase.execute();
  }
}
