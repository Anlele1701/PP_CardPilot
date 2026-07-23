import axios from 'axios';

describe('CardPilot API', () => {
  const requestConfig = {
    headers: {
      'x-request-datetime': '2026-07-23T12:48:30+07:00',
    },
  };

  it('should expose an unversioned health check without API headers', async () => {
    const res = await axios.get('/api/health');

    expect(res.status).toBe(200);
    expect(res.data.responseData).toMatchObject({
      status: 'ok',
      info: {
        database: {
          status: 'up',
        },
      },
    });
  });

  it('should return API metadata', async () => {
    const res = await axios.get('/api/v1', requestConfig);

    expect(res.status).toBe(200);
    expect(res.data).toEqual({
      responseStatus: {
        code: 'SUCCESS',
        message: 'Success',
      },
      responseData: {
        name: 'CardPilot Backend',
        description:
          'Backend API organized around clean architecture and DDD boundaries.',
        version: '1.0.0',
        architecture: 'clean-architecture-ddd',
      },
    });
  });

  it('should return cards through the application boundary', async () => {
    const res = await axios.get('/api/v1/cards', requestConfig);

    expect(res.status).toBe(200);
    expect(res.data).toEqual({
      responseStatus: {
        code: 'SUCCESS',
        message: 'Success',
      },
      responseData: [
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
      ],
    });
  });
});
