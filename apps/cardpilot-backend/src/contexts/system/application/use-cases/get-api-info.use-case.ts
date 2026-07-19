import { Injectable } from '@nestjs/common';
import { UseCase } from '../../../../core/application/use-case';

export interface ApiInfoResponse {
  name: string;
  description: string;
  version: string;
  architecture: string;
}

@Injectable()
export class GetApiInfoUseCase implements UseCase<ApiInfoResponse> {
  execute(): ApiInfoResponse {
    return {
      name: 'CardPilot Backend',
      description: 'Backend API organized around clean architecture and DDD boundaries.',
      version: '1.0.0',
      architecture: 'clean-architecture-ddd',
    };
  }
}
