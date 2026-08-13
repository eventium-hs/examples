# Eventium Examples

Example applications for [Eventium](https://github.com/eventium-hs/eventium), the
Haskell event sourcing library:

- **`bank`** — account aggregates, command handlers, a process manager, and a
  Transfer read model (persistent, SQLite-backed).
- **`cafe`** — a café tab aggregate with an interactive terminal UI.
- **`counter-cli`** — a minimal counter aggregate over the in-memory store.

## Development

Prerequisites: Nix (with flakes) + direnv. Entering the directory auto-loads the
dev shell via `.envrc`; the shell runs `hpack` to generate the `.cabal` files.

This repo builds against a **sibling checkout** of the library, matching the
`eventium-hs` layout:

```
eventium-hs/
├── eventium/    # the library
└── examples/    # this repo
```

```
just build-local   # build against ../eventium (local dev)
just test          # run example tests against ../eventium
just format        # ormolu --mode inplace
just lint          # hlint
```

## Project files

- **`cabal.project.dev`** — local development against `../eventium` (used by
  `just build-local` / `just test`). Works today.
- **`cabal.project`** — self-contained build that pulls the library from git
  (`source-repository-package`). This becomes usable once the `eventium-hs/eventium`
  repo exists **and** commits its generated `.cabal` files (cabal does not run
  hpack on git dependencies).
