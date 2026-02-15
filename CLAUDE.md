# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

WikidataAdaptor is a Ruby gem that wraps the Wikibase REST API. It extends `ApiAdaptor::Base` and uses a modular mixin pattern — each API resource (Items, Labels, Statements, etc.) is a separate module included into `WikidataAdaptor::RestApi`. Corresponding test helper modules in `lib/wikidata_adaptor/test_helpers/` provide WebMock stubs for consumers of the gem.

## Commands

```bash
# Run all checks (specs + rubocop)
bundle exec rake

# Unit tests only (integration tests excluded by default)
bundle exec rspec

# Single test file
bundle exec rspec spec/wikidata_adaptor/rest_api/items_spec.rb

# Single test by line
bundle exec rspec spec/wikidata_adaptor/rest_api/items_spec.rb:42

# Lint
bundle exec rubocop

# Integration tests (requires running Wikibase instance)
./script/integration-up      # start Docker Compose stack
./script/integration-test    # run integration specs
./script/integration-down    # tear down
```

## Architecture

- **`lib/wikidata_adaptor/rest_api.rb`** — Main client class, inherits `ApiAdaptor::Base`, includes all resource modules
- **`lib/wikidata_adaptor/rest_api/`** — One module per API resource (items, labels, descriptions, aliases, statements, sitelinks, properties, search_item, search_property, property_data_types, open_api_document)
- **`lib/wikidata_adaptor/test_helpers/`** — Mirrors `rest_api/` structure, providing `stub_*` methods for WebMock-based testing
- **`spec/wikidata_adaptor/rest_api/`** — Unit tests using WebMock stubs
- **`spec/integration/`** — Integration tests against a real Wikibase instance via Docker Compose

## Testing Conventions

- Unit tests use `include WikidataAdaptor::TestHelpers::RestApi` for stubbing
- Integration tests use `include WikidataAdaptor::Integration::Helpers` and are tagged `:integration`
- Integration tests use `before(:context)` with instance variables (not `let`) to seed data once per group
- Integration tests are excluded by default; enabled with `INTEGRATION=1`

## Environment Variables

- `WIKIBASE_REST_ENDPOINT` — API base URL (default: `https://www.wikidata.org/w/rest.php/wikibase`)
- `WIKIBASE_BEARER_TOKEN` — Optional OAuth token for write operations
- `INTEGRATION` — Set to `1` to include integration tests

## Git Standards

Never commit to main branch,
Always create a new branch with a sensible descriptive name and expect a Pull Request process.

You'll need to provide a good PR description that sums up any collected change.

## Commit Standards

Follows [GDS Git conventions](https://gds-way.digital.cabinet-office.gov.uk/standards/source-code/working-with-git.html#commits), informed by [chris.beams.io/posts/git-commit](https://chris.beams.io/posts/git-commit), [thoughtbot](https://thoughtbot.com/blog/5-useful-tips-for-a-better-commit-message), [mislav.net](https://mislav.net/2014/02/hidden-documentation/), and [Joel Chippindale's "Telling Stories Through Your Commits"](https://blog.mocoso.co.uk/posts/talks/telling-stories-through-your-commits/).

### Formatting

- **[Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)** — subject line format: `<type>[optional scope]: <description>`
- **Types**: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`
- **Scope** — optional parenthetical context, e.g. `feat(labels):` or `fix(integration):`
- **Breaking changes** — indicated with `!` before the colon, e.g. `feat!:`, or a `BREAKING CHANGE:` footer
- **Subject line** — max 50 characters, no trailing period, imperative mood ("Add feature" not "Added feature")
- **Body** — separated from subject by a blank line, wrapped at 72 characters
- **Links supplement, not replace** — issue/PR links may go stale, so the message must stand on its own

### Content

- **Answer three questions**: Why is this change necessary? How does it address the issue? What side effects does it have?
- **Explain the "why"** — the code shows _how_; the commit message must capture _why_. Rationale and context are hard to reconstruct later
- **Note alternatives considered** — if you chose approach A over B, say so and why

### Structure

- **Atomic commits** — each commit is a self-contained, logical unit of work; avoid needing "and" in your subject line
- **Tell a story** — commits should be logically ordered so the history reads as a coherent narrative, not a jumbled log
- **Clean up before sharing** — revise commit history on feature branches before opening a PR

## Development Workflow (TDD)

When adding new API endpoints, follow this test-driven approach.
You are expected to pause and commit between each step, once we are ready for PR you may soft reset and re-commit if the audit history does not properly represent the above rules.

A good flow might look like:

1. **Write unit tests (red)** — Add `describe` blocks to the relevant spec file calling `stub_*` and API methods that don't exist yet. Verify `bundle exec rubocop` passes and `bundle exec rspec` fails. Then commit and push.
2. **Add test helpers + implementation (green)** — Add `stub_*` helpers and implement the API methods. Verify `bundle exec rake` passes (rspec + rubocop). Then commit and push.
3. **Add integration tests** — Add tests to `spec/integration/` that exercise the real API. Then commit and push.
4. **Update TODO** — Move endpoints from "Uncovered" to "Covered" in `TODO.md` and update counts. Then commit and push.

## Style

- Double quotes for strings
- Ruby >= 3.2
