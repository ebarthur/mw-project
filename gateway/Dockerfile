FROM node:22-alpine AS prepare

WORKDIR /app
COPY . .
RUN rm -rf client auth dispatch incident
RUN npm install -g pnpm@10.16.1
RUN pnpm install --frozen-lockfile
RUN cd gateway && pnpm build

FROM node:22-alpine

WORKDIR /app
COPY --from=prepare /app .

RUN npm install -g pnpm@10.16.1

WORKDIR /app/gateway

EXPOSE 4000

CMD ["node", "dist/index.js"]