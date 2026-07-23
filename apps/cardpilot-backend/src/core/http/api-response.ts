export interface ApiResponseStatus {
  code: string;
  message: string;
}

export interface ApiResponse<TData> {
  responseStatus: ApiResponseStatus;
  responseData: TData;
}
