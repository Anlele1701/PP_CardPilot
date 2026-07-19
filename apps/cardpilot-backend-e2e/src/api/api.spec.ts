import axios from 'axios';

describe('CardPilot API', () => {
  it('should return API metadata', async () => {
    const res = await axios.get('/api');

    expect(res.status).toBe(200);
    expect(res.data).toEqual({
      name: 'CardPilot Backend',
      description: 'Backend API organized around clean architecture and DDD boundaries.',
      version: '1.0.0',
      architecture: 'clean-architecture-ddd',
    });
  });

  it('should return cards through the application boundary', async () => {
    const res = await axios.get('/api/cards');

    expect(res.status).toBe(200);
    expect(res.data).toEqual([
      {
        id: 'card_1',
        name: 'Pilot Starter Deck',
        createdAt: '2026-01-10T10:00:00.000Z',
      },
      {
        id: 'card_2',
        name: 'Control Ledger',
        createdAt: '2026-02-14T08:30:00.000Z',
      },
    ]);
  });
});
