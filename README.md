# MW Backend Monorepo

This repository contains the Emergency/Medical Workflow platform:

- Web client
- API gateway
- Auth service
- Incident service
- Dispatch service
- Analytics service

## Start Here (Presentation Flow)

Use this order when presenting the project end to end:

1. Project overview deck: [presentation.pptx](presentation.pptx)
2. API docs and auth flow: [documentation.md](documentation.md)
3. Hosting and rollout steps: [deployment.md](deployment.md)

This sequence aligns the story as:

- what the system is
- how it is consumed
- how it is deployed

## Core Service Layout

- Client: [client](client)
- Gateway: [gateway](gateway)
- Auth: [auth](auth)
- Incident: [incident](incident)
- Dispatch: [dispatch](dispatch)
- Analytics: [analytics](analytics)
- Shared package: [common](common)

## Documentation Index

- Main API documentation and Swagger usage: [documentation.md](documentation.md)
- Deployment guide (Railway-friendly process): [deployment.md](deployment.md)

Service-specific readmes:

- [auth/README.md](auth/README.md)
- [incident/README.md](incident/README.md)
- [dispatch/README.md](dispatch/README.md)
- [analytics/README.md](analytics/README.md)
- [gateway/README.md](gateway/README.md)
- [client/README.md](client/README.md)

## Quick Local Dev Commands

From repository root:

```bash
pnpm install
pnpm dev
```

Useful targeted dev commands:

```bash
pnpm dev:gateway
pnpm dev:auth
pnpm dev:incident
pnpm dev:dispatch
pnpm dev:analytics
pnpm dev:client
```

Database helpers:

```bash
pnpm db:generate
pnpm db:migrate
pnpm db:migrate:deploy
```

## Deployment Summary

Each deployable app (except common) has its own `.env.copy` file.

Per service deployment pattern:

1. Set host project root to the service folder.
2. Copy service environment variables from `.env.copy`.
3. Install dependencies.
4. Build the service.
5. Start the service.

See the complete runbook in [deployment.md](deployment.md).

## API Docs Summary

Production gateway base domain:

- https://gateway-production-d879.up.railway.app

Swagger UI pattern:

- `https://gateway-production-d879.up.railway.app/api/<service>/ui`

OpenAPI JSON pattern:

- `https://gateway-production-d879.up.railway.app/api/<service>/doc`

Where `<service>` is one of: `auth`, `incident`, `dispatch`, `analytics`.

See full details in [documentation.md](documentation.md).
