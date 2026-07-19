import 'dotenv/config';
import { resolve } from 'node:path';
import { DataSource } from 'typeorm';

const databaseUrl =
  process.env.DIRECT_DATABASE_URL ?? process.env.DATABASE_URL;

if (!databaseUrl) {
  throw new Error(
    'Set DIRECT_DATABASE_URL or DATABASE_URL before running migrations.',
  );
}

export default new DataSource({
  type: 'postgres',
  url: databaseUrl,
  synchronize: false,
  migrationsRun: false,
  migrationsTransactionMode: 'all',
  migrations: [
    resolve(
      process.cwd(),
      'apps/cardpilot-backend/src/database/migrations/*{.ts,.js}',
    ),
  ],
});
