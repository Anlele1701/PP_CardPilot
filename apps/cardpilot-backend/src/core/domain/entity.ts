export abstract class Entity<TId> {
  protected constructor(public readonly id: TId) {}

  equals(other?: Entity<TId>): boolean {
    if (!other) {
      return false;
    }

    return this.id === other.id;
  }
}
