# Integration tests

This repo’s default RSpec suite uses WebMock and stubs requests.

For end-to-end verification against a real Wikibase instance, run the integration suite.

## Prereqs

- Docker + Docker Compose (v2)
- A running Wikibase instance exposing the REST API at `.../w/rest.php/wikibase`
  - You can use the provided `integration/docker-compose.yml` (core-only; no WDQS/SPARQL)
- `WIKIBASE_REST_ENDPOINT` set to that base URL (defaults to `http://localhost:8080/w/rest.php/wikibase`)
- If your Wikibase requires authentication for writes, set `WIKIBASE_BEARER_TOKEN`

## Running

### Bring up local Wikibase (recommended)

```bash
cp integration/.env.example integration/.env
./script/integration-up
```

If `wikibase` fails to start with `METADATA_CALLBACK not configured`, make sure
`METADATA_CALLBACK=false` is present in `integration/.env`.

If the MediaWiki installer rejects `MW_ADMIN_PASS`, pick a less common password
of at least 10 characters in `integration/.env`.

### Run integration specs

```bash
INTEGRATION=1 \
WIKIBASE_REST_ENDPOINT=http://localhost:8080/w/rest.php/wikibase \
WIKIBASE_BEARER_TOKEN=... \
bundle exec rspec --tag integration
```

Or:

```bash
./script/integration-test
```

### Tear down

```bash
./script/integration-down
```

## Notes

- The integration tests currently seed data via `POST /v1/entities/items` and then validate read-only endpoints.
- If you prefer seeding without write access, we can switch to a container-side import step instead.

## Performance

This stack omits WDQS/SPARQL and traefik to start faster.
