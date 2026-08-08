import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { APP_FILTER, APP_GUARD, APP_INTERCEPTOR } from '@nestjs/core';
import { TypeOrmModule } from '@nestjs/typeorm';
import { BanksModule } from '../contexts/banks/banks.module';
import { CashbackReferenceModule } from '../contexts/cashback-reference/cashback-reference.module';
import { CreditCardsModule } from '../contexts/credit-cards/credit-cards.module';
import { SystemModule } from '../contexts/system/system.module';
import { ApiExceptionFilter } from '../core/http/api-exception.filter';
import { ApiResponseInterceptor } from '../core/http/api-response.interceptor';
import { RequestContextGuard } from '../core/http/request-context.guard';
import { RequestLoggingInterceptor } from '../core/http/request-logging.interceptor';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    TypeOrmModule.forRootAsync({
      inject: [ConfigService],
      useFactory: (configService: ConfigService) => ({
        type: 'postgres',
        url: configService.getOrThrow<string>('DATABASE_URL'),
        autoLoadEntities: true,
        synchronize: false,
        migrationsRun: false,
      }),
    }),
    SystemModule,
    BanksModule,
    CreditCardsModule,
    CashbackReferenceModule,
  ],
  providers: [
    {
      provide: APP_GUARD,
      useClass: RequestContextGuard,
    },
    {
      provide: APP_INTERCEPTOR,
      useClass: RequestLoggingInterceptor,
    },
    {
      provide: APP_INTERCEPTOR,
      useClass: ApiResponseInterceptor,
    },
    {
      provide: APP_FILTER,
      useClass: ApiExceptionFilter,
    },
  ],
})
export class AppModule {}
