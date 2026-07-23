import { HttpStatus } from '@nestjs/common';

export const AppErrors = {
  MissingRequestDateTime: {
    code: 'MISSING_REQUEST_DATETIME',
    message: 'Request datetime header is required',
    httpStatus: HttpStatus.BAD_REQUEST,
  },
  ValidationError: {
    code: 'VALIDATION_ERROR',
    message: 'Validation error',
    httpStatus: HttpStatus.BAD_REQUEST,
  },
  Unauthorized: {
    code: 'UNAUTHORIZED',
    message: 'Unauthorized',
    httpStatus: HttpStatus.UNAUTHORIZED,
  },
  Forbidden: {
    code: 'FORBIDDEN',
    message: 'Forbidden',
    httpStatus: HttpStatus.FORBIDDEN,
  },
  NotFound: {
    code: 'NOT_FOUND',
    message: 'Resource not found',
    httpStatus: HttpStatus.NOT_FOUND,
  },
  InternalServerError: {
    code: 'INTERNAL_SERVER_ERROR',
    message: 'Internal server error',
    httpStatus: HttpStatus.INTERNAL_SERVER_ERROR,
  },
  ServiceUnavailable: {
    code: 'SERVICE_UNAVAILABLE',
    message: 'Service unavailable',
    httpStatus: HttpStatus.SERVICE_UNAVAILABLE,
  },
} as const;

export type AppError = (typeof AppErrors)[keyof typeof AppErrors];
export type AppErrorCode = AppError['code'];
