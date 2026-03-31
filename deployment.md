# Deployment Guide

This repo is a monorepo. Each deployable app has its own `.env.copy` template (everything except `common`).

Deployable apps:
- `client`
- `gateway`
- `auth`
- `incident`
- `dispatch`
- `analytics`

The backend services are already configured so `start` runs Prisma deploy migrations first.

## 1) Prerequisites

- Node.js `22` recommended (repo root also declares Node 22)
- A package manager available in your hosting runtime:
	- `pnpm` (recommended, repo uses `pnpm@10.16.1`)
	- or `npm`/`yarn` if your platform uses those
- Managed Postgres for the services that require `DATABASE_URL`
- Managed Redis for services that require `REDIS_URL`

## 2) Standard Deployment Pattern (applies to every app)

For each app you host, do this in your platform:

1. Set project root to that app folder (for example `auth` or `client`).
2. Copy values from `<app>/.env.copy` into your platform environment variables.
3. Install dependencies.
4. Run build command.
5. Run start command.

Generic commands (inside the app root):

```bash
# install (choose one based on your runtime)
pnpm install
# or
npm install

# build
pnpm run build
# or
npm run build

# start
pnpm run start
# or
npm run start
```

## 3) Environment Variables Per App

### Client (`client/.env.copy`)

- `VITE_MAPBOX_TOKEN`
- `VITE_MAPBOX_DARK_STYLE`
- `VITE_GOOGLE_MAPS_API_KEY`
- `JWT_PUBLIC_KEY`
- `GATEWAY_BASE`

### Gateway (`gateway/.env.copy`)

- `JWT_PUBLIC_KEY`
- `AUTH_SERVICE_URL`
- `INCIDENTS_SERVICE_URL`
- `DISPATCH_SERVICE_URL`
- `ANALYTICS_SERVICE_URL`
- `PORT`

### Auth (`auth/.env.copy`)

- `PORT`
- `DATABASE_URL`
- `JWT_PRIVATE_KEY`

### Incident (`incident/.env.copy`)

- `DATABASE_URL`
- `REDIS_URL`
- `PORT`

### Dispatch (`dispatch/.env.copy`)

- `PORT`
- `DATABASE_URL`
- `REDIS_URL`
- `INCIDENT_SERVICE_URL`
- `SIMULATION_ENABLED`
- `SIM_INTERVAL_MS`
- `SIM_DEBUG`

### Analytics (`analytics/.env.copy`)

- `PORT`
- `DATABASE_URL`
- `REDIS_URL`

## 4) Build and Start Commands Per App

Use these when your host asks for explicit commands.

### Client

- Build: `pnpm run build` (or `npm run build`)
- Start: `pnpm run start` (or `npm run start`)

### Gateway

- Build: `pnpm run build` (or `npm run build`)
- Start: `pnpm run start` (or `npm run start`)

### Auth

- Build: `pnpm run build` (or `npm run build`)
- Start: `pnpm run start` (or `npm run start`)
- `start` runs: `db:migrate:deploy` then `node dist/index.js`

### Incident

- Build: `pnpm run build` (or `npm run build`)
- Start: `pnpm run start` (or `npm run start`)
- `start` runs: `db:migrate:deploy` then `node dist/index.js`

### Dispatch

- Build: `pnpm run build` (or `npm run build`)
- Start: `pnpm run start` (or `npm run start`)
- `start` runs: `db:migrate:deploy` then `node dist/index.js`

### Analytics

- Build: `pnpm run build` (or `npm run build`)
- Start: `pnpm run start` (or `npm run start`)
- `start` runs: `db:migrate:deploy` then `node dist/index.js`

## 5) Suggested Rollout Order

1. Deploy `auth`, `incident`, `dispatch`, `analytics` first (so service URLs are live).
2. Deploy `gateway` with those service URLs.
3. Deploy `client` with `GATEWAY_BASE` pointing to the gateway URL.

## 6) Quick Host Checklist

For each app:

1. Root directory set correctly.
2. Env vars copied from `.env.copy` and filled with production values.
3. Build command configured.
4. Start command configured.
5. `PORT` exposed or mapped according to your platform.

If your platform supports separate install/build/start fields, use:

- Install: `pnpm install --frozen-lockfile` (or `npm ci`)
- Build: `pnpm run build`
- Start: `pnpm run start`
