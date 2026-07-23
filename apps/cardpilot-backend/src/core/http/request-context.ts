import { randomUUID } from 'node:crypto';
import { API_HEADERS } from './api-headers';

export interface RequestContext {
  traceId: string;
  requestDateTime?: string;
}

export interface RequestWithContext {
  headers: Record<string, string | string[] | undefined>;
  requestContext?: RequestContext;
}

const TRACE_ID_PATTERN = /^[A-Za-z0-9._:-]{1,128}$/;

export function getSingleHeader(
  headers: Record<string, string | string[] | undefined>,
  name: string,
): string | undefined {
  const value = headers[name];

  if (Array.isArray(value)) {
    return value[0];
  }

  return value;
}

export function isValidTraceId(traceId: string | undefined): traceId is string {
  return Boolean(traceId && TRACE_ID_PATTERN.test(traceId));
}

export function getOrCreateTraceId(
  headers: Record<string, string | string[] | undefined>,
): string {
  const requestTraceId = getSingleHeader(headers, API_HEADERS.requestTraceId);

  if (isValidTraceId(requestTraceId)) {
    return requestTraceId;
  }

  return randomUUID();
}
