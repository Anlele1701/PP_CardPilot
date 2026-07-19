import { Test } from '@nestjs/testing';
import { SystemController } from './system.controller';
import { GetApiInfoUseCase } from '../../application/use-cases/get-api-info.use-case';

describe('SystemController', () => {
  it('should return API metadata', async () => {
    const moduleRef = await Test.createTestingModule({
      controllers: [SystemController],
      providers: [GetApiInfoUseCase],
    }).compile();

    const controller = moduleRef.get(SystemController);

    expect(controller.getApiInfo()).toEqual({
      name: 'CardPilot Backend',
      description: 'Backend API organized around clean architecture and DDD boundaries.',
      version: '1.0.0',
      architecture: 'clean-architecture-ddd',
    });
  });
});
