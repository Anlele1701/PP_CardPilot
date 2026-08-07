export interface UseCase<TResult, TArguments extends unknown[] = []> {
  execute(...args: TArguments): Promise<TResult> | TResult;
}
