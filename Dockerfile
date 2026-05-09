# syntax=docker/dockerfile:1

FROM node:22-alpine AS builder

WORKDIR /repo

# Enable pnpm via Corepack
RUN corepack enable && corepack prepare pnpm@10.28.0 --activate

# Copy only what's needed to install dependencies first (better layer caching)
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml nx.json tsconfig.base.json .prettierrc .prettierignore ./
COPY apps ./apps

RUN pnpm install --frozen-lockfile

# Build the NestJS app (outputs to dist/apps/cardpilot-backend)
RUN pnpm nx build cardpilot-backend


FROM node:22-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production

RUN corepack enable && corepack prepare pnpm@10.28.0 --activate

# Install only production dependencies for the built app
COPY --from=builder /repo/dist/apps/cardpilot-backend/package.json ./package.json
COPY --from=builder /repo/dist/apps/cardpilot-backend/pnpm-lock.yaml ./pnpm-lock.yaml
RUN pnpm install --prod --frozen-lockfile

# App bundle
COPY --from=builder /repo/dist/apps/cardpilot-backend/main.js ./main.js
COPY --from=builder /repo/dist/apps/cardpilot-backend/main.js.map ./main.js.map

EXPOSE 3000

# Render sets $PORT, Nest uses process.env.PORT || 3000
CMD ["node", "main.js"]

