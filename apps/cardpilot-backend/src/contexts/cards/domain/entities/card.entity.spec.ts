import { Card } from './card.entity';

describe('Card', () => {
  it('should enforce invariants and expose primitives', () => {
    const card = Card.create({
      id: 'card_123',
      name: 'Operations Board',
      createdAt: new Date('2026-03-01T00:00:00.000Z'),
    });

    expect(card.toPrimitives()).toEqual({
      id: 'card_123',
      name: 'Operations Board',
      createdAt: '2026-03-01T00:00:00.000Z',
    });
  });

  it('should reject an empty card name', () => {
    expect(() => Card.create({ id: 'card_123', name: '   ' })).toThrow(
      'Card name cannot be empty.',
    );
  });
});
