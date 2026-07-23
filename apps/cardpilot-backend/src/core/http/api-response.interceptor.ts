import {
  CallHandler,
  ExecutionContext,
  Injectable,
  NestInterceptor,
} from '@nestjs/common';
import { map, Observable } from 'rxjs';
import { API_HEADERS } from './api-headers';
import { ApiResponse } from './api-response';
import { RequestWithContext } from './request-context';

interface ResponseWithHeader {
  header(name: string, value: string): void;
}

@Injectable()
export class ApiResponseInterceptor implements NestInterceptor {
  intercept(context: ExecutionContext, next: CallHandler): Observable<unknown> {
    const http = context.switchToHttp();
    const request = http.getRequest<RequestWithContext>();
    const response = http.getResponse<ResponseWithHeader>();
    const traceId = request.requestContext?.traceId;

    if (traceId) {
      response.header(API_HEADERS.requestTraceId, traceId);
      response.header(API_HEADERS.responseTraceId, traceId);
    }

    return next.handle().pipe(
      map((data: unknown): ApiResponse<unknown> => {
        return {
          responseStatus: {
            code: 'SUCCESS',
            message: 'Success',
          },
          responseData: data,
        };
      }),
    );
  }
}
