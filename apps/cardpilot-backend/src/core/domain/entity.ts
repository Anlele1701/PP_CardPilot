export abstract class Entity<TId, TPrimitives> {
  protected constructor(public readonly id: TId) {}

  equals(other?: Entity<TId, TPrimitives>): boolean {
    if (!other) {
      return false;
    }

    return this.id === other.id;
  }

  abstract toPrimitives(): TPrimitives;
}
