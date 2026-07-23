import {
  CallHandler,
  ExecutionContext,
  Injectable,
  Logger,
  NestInterceptor,
} from '@nestjs/common';
import { Observable } from 'rxjs';
import { RequestWithContext } from './request-context';

interface RequestWithLoggingContext extends RequestWithContext {
  method?: string;
  url?: string;
  ip?: string;
}

@Injectable()
export class RequestLoggingInterceptor implements NestInterceptor {
  private readonly logger = new Logger(RequestLoggingInterceptor.name);

  intercept(context: ExecutionContext, next: CallHandler): Observable<unknown> {
    const request = context
      .switchToHttp()
      .getRequest<RequestWithLoggingContext>();
    const traceId = request.requestContext?.traceId ?? 'unknown';
    const requestDateTime =
      request.requestContext?.requestDateTime ?? 'unknown';
    const method = request.method ?? 'UNKNOWN_METHOD';
    const url = request.url ?? 'UNKNOWN_URL';
    const ip = request.ip ?? 'unknown';

    this.logger.log(
      `Incoming request method=${method} url=${url} traceId=${traceId} requestDateTime=${requestDateTime} ip=${ip}`,
    );

    return next.handle();
  }
}
