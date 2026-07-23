import { SetMetadata } from '@nestjs/common';

export const ALLOW_MISSING_REQUEST_DATETIME_KEY =
  'allowMissingRequestDateTime';

export const AllowMissingRequestDateTime = () =>
  SetMetadata(ALLOW_MISSING_REQUEST_DATETIME_KEY, true);
