import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
import { AppErrors } from '../errors/app-errors';
import { BusinessException } from '../errors/app-exception';
import { API_HEADERS } from './api-headers';
import {
  getOrCreateTraceId,
  getSingleHeader,
  RequestWithContext,
} from './request-context';

@Injectable()
export class RequestContextGuard implements CanActivate {
  canActivate(context: ExecutionContext): boolean {
    const request = context.switchToHttp().getRequest<RequestWithContext>();
    const requestDateTime = getSingleHeader(
      request.headers,
      API_HEADERS.requestDateTime,
    );

    request.requestContext = {
      traceId: getOrCreateTraceId(request.headers),
      requestDateTime,
    };

    if (!requestDateTime) {
      throw new BusinessException(AppErrors.MissingRequestDateTime);
    }

    return true;
  }
}
