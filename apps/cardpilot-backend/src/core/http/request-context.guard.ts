import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { AppErrors, BusinessException } from '../errors';
import { API_HEADERS } from './api-headers';
import { ALLOW_MISSING_REQUEST_DATETIME_KEY } from './request-context.decorator';
import {
  getOrCreateTraceId,
  getSingleHeader,
  RequestWithContext,
} from './request-context';

@Injectable()
export class RequestContextGuard implements CanActivate {
  constructor(private readonly reflector: Reflector) {}

  canActivate(context: ExecutionContext): boolean {
    const allowMissingRequestDateTime =
      this.reflector.getAllAndOverride<boolean>(
        ALLOW_MISSING_REQUEST_DATETIME_KEY,
        [context.getHandler(), context.getClass()],
      ) ?? false;
    const request = context.switchToHttp().getRequest<RequestWithContext>();
    const requestDateTime = getSingleHeader(
      request.headers,
      API_HEADERS.requestDateTime,
    );

    request.requestContext = {
      traceId: getOrCreateTraceId(request.headers),
      requestDateTime,
    };

    if (!requestDateTime && !allowMissingRequestDateTime) {
      throw new BusinessException(AppErrors.MissingRequestDateTime);
    }

    return true;
  }
}
