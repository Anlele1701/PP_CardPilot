import { Logger, VersioningType } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import {
  FastifyAdapter,
  NestFastifyApplication,
} from '@nestjs/platform-fastify';
import { AppModule } from './app/app.module';

async function bootstrap() {
  const app = await NestFactory.create<NestFastifyApplication>(
    AppModule,
    new FastifyAdapter(),
  );
  app.enableShutdownHooks();

  const globalPrefix = 'api';
  const defaultApiVersion = '1';
  app.setGlobalPrefix(globalPrefix);
  app.enableVersioning({
    type: VersioningType.URI,
    defaultVersion: defaultApiVersion,
  });

  const port = Number(process.env.PORT ?? 3000);
  const host = '0.0.0.0';

  await app.listen(port, host);
  Logger.log(
    `Application is running on http://${host}:${port}/${globalPrefix}/v${defaultApiVersion}`,
  );
}

void bootstrap();
