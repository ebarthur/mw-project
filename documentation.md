# API Documentation

All services in this project expose Swagger in the same pattern through the gateway.

Production base domain:

- https://gateway-production-d879.up.railway.app

Service docs pattern:

- Swagger UI template: `https://gateway-production-d879.up.railway.app/api/<service>/ui`
- OpenAPI JSON template: `https://gateway-production-d879.up.railway.app/api/<service>/doc`

Replace `<service>` with one of:

- `auth`
- `incident`
- `dispatch`
- `analytics`

Direct Swagger UI links:

- https://gateway-production-d879.up.railway.app/api/auth/ui
- https://gateway-production-d879.up.railway.app/api/incident/ui
- https://gateway-production-d879.up.railway.app/api/dispatch/ui
- https://gateway-production-d879.up.railway.app/api/analytics/ui

Each service also exposes its raw OpenAPI JSON:

- https://gateway-production-d879.up.railway.app/api/auth/doc
- https://gateway-production-d879.up.railway.app/api/incident/doc
- https://gateway-production-d879.up.railway.app/api/dispatch/doc
- https://gateway-production-d879.up.railway.app/api/analytics/doc

## How Swagger Is Added

Each backend service mounts two documentation routes:

1. `/doc` returns the OpenAPI document object (`openApiDoc`).
2. `/ui` serves Swagger UI using `@hono/swagger-ui` and points to its own `/doc` endpoint.

This is implemented in each service:

- Auth: [auth/src/index.ts](auth/src/index.ts#L33)
- Incident: [incident/src/index.ts](incident/src/index.ts#L47)
- Dispatch: [dispatch/src/index.ts](dispatch/src/index.ts#L59)
- Analytics: [analytics/src/index.ts](analytics/src/index.ts#L38)

The OpenAPI schema itself lives in each service's swagger module:

- [auth/src/lib/swagger.ts](auth/src/lib/swagger.ts)
- [incident/src/lib/swagger.ts](incident/src/lib/swagger.ts)
- [dispatch/src/lib/swagger.ts](dispatch/src/lib/swagger.ts)
- [analytics/src/lib/swagger.ts](analytics/src/lib/swagger.ts)

## Why Docs Are Freely Reachable Through Gateway

Gateway proxy rules intentionally allow docs endpoints before auth middleware:

- `/api/*/doc` is proxied directly.
- `/api/*/ui` is proxied directly.
- Auth middleware is then applied for protected API routes.

Reference:

- [gateway/src/index.ts](gateway/src/index.ts#L30)

This gives public discoverability for docs while keeping business endpoints secured.

## Authorization Flow For Trying Protected Endpoints

You can open Swagger pages without logging in, but many operations require a Bearer token.

Recommended flow:

1. Open Auth docs: `/api/auth/ui`.
2. Create an account via register endpoint.
3. Login to obtain access token.
4. In Swagger UI, click Authorize and paste token as `Bearer <token>`.
5. Open other service docs (`incident`, `dispatch`, `analytics`) and authorize using the same token.

Most non-auth service operations are designed to be called behind the gateway with authentication.

## Frontend Uses Generated OpenAPI Types

Frontend does not manually duplicate API types. Instead it consumes generated OpenAPI typings.

Generated files are present per service:

- [client/app/lib/types/auth/api.d.ts](client/app/lib/types/auth/api.d.ts)
- [client/app/lib/types/incident/api.d.ts](client/app/lib/types/incident/api.d.ts)
- [client/app/lib/types/dispatch/api.d.ts](client/app/lib/types/dispatch/api.d.ts)
- [client/app/lib/types/analytics/api.d.ts](client/app/lib/types/analytics/api.d.ts)

These are re-mapped into app-facing model aliases:

- [client/app/lib/types/auth/model.ts](client/app/lib/types/auth/model.ts)
- [client/app/lib/types/incident/model.ts](client/app/lib/types/incident/model.ts)
- [client/app/lib/types/dispatch/model.ts](client/app/lib/types/dispatch/model.ts)
- [client/app/lib/types/analytics/model.ts](client/app/lib/types/analytics/model.ts)

Dependencies are already included in client package:

- `openapi-typescript`
- `swagger-typescript-api`

Reference:

- [client/package.json](client/package.json#L50)

Result: backend OpenAPI remains the source of truth, and frontend stays type-safe without duplicating request/response contracts.
