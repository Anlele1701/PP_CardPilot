import {
  ArgumentsHost,
  Catch,
  ExceptionFilter,
  HttpException,
  HttpStatus,
  Logger,
} from '@nestjs/common';
import { AppErrors } from '../errors/app-errors';
import { AppExceptionResponse } from '../errors/app-exception';
import { API_HEADERS } from './api-headers';
import { ApiResponse } from './api-response';
import { getOrCreateTraceId, RequestWithContext } from './request-context';

interface ResponseWithHeaderAndStatus {
  header(name: string, value: string): void;
  status(statusCode: number): { send(body: unknown): void };
}

interface RequestWithErrorLoggingContext extends RequestWithContext {
  method?: string;
  url?: string;
}

@Catch()
export class ApiExceptionFilter implements ExceptionFilter {
  private readonly logger = new Logger(ApiExceptionFilter.name);

  catch(exception: unknown, host: ArgumentsHost): void {
    const http = host.switchToHttp();
    const request = http.getRequest<RequestWithErrorLoggingContext>();
    const response = http.getResponse<ResponseWithHeaderAndStatus>();
    const traceId =
      request.requestContext?.traceId ?? getOrCreateTraceId(request.headers);
    const statusCode =
      exception instanceof HttpException
        ? exception.getStatus()
        : HttpStatus.INTERNAL_SERVER_ERROR;
    const body = this.createErrorBody(exception, statusCode);

    if (statusCode >= HttpStatus.INTERNAL_SERVER_ERROR) {
      this.logServerError(exception, request, traceId, statusCode);
    }

    response.header(API_HEADERS.requestTraceId, traceId);
    response.header(API_HEADERS.responseTraceId, traceId);
    response.status(statusCode).send(body);
  }

  private createErrorBody(
    exception: unknown,
    statusCode: number,
  ): ApiResponse<null> {
    return {
      responseStatus: {
        code: this.getErrorCode(exception, statusCode),
        message: this.getErrorMessage(exception, statusCode),
      },
      responseData: null,
    };
  }

  private getErrorCode(exception: unknown, statusCode: number): string {
    const appExceptionResponse = this.getAppExceptionResponse(exception);

    if (appExceptionResponse?.code) {
      return appExceptionResponse.code;
    }

    if (exception instanceof HttpException) {
      return this.getDefaultHttpErrorCode(statusCode);
    }

    return AppErrors.InternalServerError.code;
  }

  private getErrorMessage(exception: unknown, statusCode: number): string {
    if (!(exception instanceof HttpException)) {
      return AppErrors.InternalServerError.message;
    }

    const appExceptionResponse = this.getAppExceptionResponse(exception);

    if (appExceptionResponse?.message) {
      return appExceptionResponse.message;
    }

    const response = exception.getResponse();

    if (typeof response === 'string') {
      return response;
    }

    if (
      typeof response === 'object' &&
      response !== null &&
      'message' in response
    ) {
      const message = response.message;

      if (Array.isArray(message)) {
        return message.join(', ');
      }

      if (typeof message === 'string') {
        return message;
      }
    }

    return `HTTP ${statusCode}`;
  }

  private getAppExceptionResponse(
    exception: unknown,
  ): AppExceptionResponse | undefined {
    if (!(exception instanceof HttpException)) {
      return undefined;
    }

    const response = exception.getResponse();

    if (
      typeof response === 'object' &&
      response !== null &&
      'code' in response &&
      'message' in response &&
      typeof response.code === 'string' &&
      typeof response.message === 'string'
    ) {
      return response as AppExceptionResponse;
    }

    return undefined;
  }

  private getDefaultHttpErrorCode(statusCode: number): string {
    switch (statusCode) {
      case HttpStatus.BAD_REQUEST:
        return AppErrors.ValidationError.code;
      case HttpStatus.UNAUTHORIZED:
        return AppErrors.Unauthorized.code;
      case HttpStatus.FORBIDDEN:
        return AppErrors.Forbidden.code;
      case HttpStatus.NOT_FOUND:
        return AppErrors.NotFound.code;
      case HttpStatus.SERVICE_UNAVAILABLE:
        return AppErrors.ServiceUnavailable.code;
      default:
        return `HTTP_${statusCode}`;
    }
  }

  private logServerError(
    exception: unknown,
    request: RequestWithErrorLoggingContext,
    traceId: string,
    statusCode: number,
  ): void {
    const method = request.method ?? 'UNKNOWN_METHOD';
    const url = request.url ?? 'UNKNOWN_URL';
    const message =
      exception instanceof Error ? exception.message : 'Unknown server error';
    const stack = exception instanceof Error ? exception.stack : undefined;

    this.logger.error(
      `Server error statusCode=${statusCode} method=${method} url=${url} traceId=${traceId} message=${message}`,
      stack,
    );
  }
}
