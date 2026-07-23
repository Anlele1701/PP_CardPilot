import { HttpException } from '@nestjs/common';
import { AppError, AppErrors } from './app-errors';

export interface AppExceptionResponse {
  code: AppError['code'];
  message: string;
}

export class AppException extends HttpException {
  constructor(error: AppError, message = error.message) {
    super(
      {
        code: error.code,
        message,
      } satisfies AppExceptionResponse,
      error.httpStatus,
    );
  }
}

export class BusinessException extends AppException {
  constructor(error: AppError, message = error.message) {
    super(error, message);
  }
}

export class SystemException extends AppException {
  constructor(
    error: AppError = AppErrors.InternalServerError,
    message = error.message,
  ) {
    super(error, message);
  }
}
