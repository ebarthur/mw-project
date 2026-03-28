FROM node:22-alpine AS prepare

WORKDIR /app
COPY . .
RUN rm -rf dispatch gateway incident auth
RUN corepack enable
RUN pnpm install
RUN pnpm --filter client build

FROM node:22-alpine

WORKDIR /app
COPY --from=prepare ./app .
RUN corepack enable

WORKDIR /app/client

ENV PORT=3002

EXPOSE 3002

CMD ["sh", "-c", "pnpm migrate && pnpm start"]
