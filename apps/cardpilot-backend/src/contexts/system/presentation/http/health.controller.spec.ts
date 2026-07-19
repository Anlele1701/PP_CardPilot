import { HealthCheckService, TypeOrmHealthIndicator } from '@nestjs/terminus';
import { HealthController } from './health.controller';

describe('HealthController', () => {
  it('checks the database connection', async () => {
    const databaseResult = { database: { status: 'up' as const } };
    const database = {
      pingCheck: jest.fn().mockResolvedValue(databaseResult),
    };
    const health = {
      check: jest.fn(
        async (indicators: Array<() => Promise<typeof databaseResult>>) =>
          indicators[0](),
      ),
    };
    const controller = new HealthController(
      health as unknown as HealthCheckService,
      database as unknown as TypeOrmHealthIndicator,
    );

    await expect(controller.check()).resolves.toEqual(databaseResult);
    expect(database.pingCheck).toHaveBeenCalledWith('database', {
      timeout: 3000,
    });
  });
});
