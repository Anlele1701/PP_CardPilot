import { Module } from '@nestjs/common';
import { TerminusModule } from '@nestjs/terminus';
import { GetApiInfoUseCase } from './application/use-cases/get-api-info.use-case';
import { HealthController } from './presentation/http/health.controller';
import { SystemController } from './presentation/http/system.controller';

@Module({
  imports: [TerminusModule],
  controllers: [SystemController, HealthController],
  providers: [GetApiInfoUseCase],
})
export class SystemModule {}
