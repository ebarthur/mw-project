FROM node:22-alpine AS prepare

WORKDIR /app
COPY . .
RUN rm -rf client dispatch gateway incident
RUN npm install -g pnpm@10.16.1
RUN pnpm install --frozen-lockfile
RUN cd auth && pnpm build

FROM node:22-alpine

WORKDIR /app
COPY --from=prepare /app .

RUN npm install -g pnpm@10.16.1

WORKDIR /app/auth

EXPOSE 3000

CMD ["pnpm", "start"]