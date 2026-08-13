# Eventium Examples — Development Commands
# List all recipes: just --list

# Default recipe to display help
default:
    @just --list

# Generate .cabal files from package.yaml
hpack:
    @echo "Generating .cabal files from package.yaml..."
    @find . -name package.yaml -exec dirname {} \; | while read dir; do \
        echo "  → $dir"; \
        (cd "$dir" && hpack); \
    done
    @echo "✓ Done"

# Build examples against the git-pinned eventium (self-contained; see cabal.project)
build: hpack
    cabal build all

# Build examples against a sibling ../eventium checkout (local dev)
build-local: hpack
    cabal build all --project-file=cabal.project.dev

# Run example tests against a sibling ../eventium checkout (local dev)
test: hpack
    cabal test all --project-file=cabal.project.dev --test-show-details=direct --enable-tests

# Format Haskell sources with ormolu
format:
    find . -name '*.hs' -not -path './dist-newstyle/*' -exec ormolu --mode inplace {} +

# Check formatting without modifying files
format-check:
    find . -name '*.hs' -not -path './dist-newstyle/*' -exec ormolu --mode check {} +

# Lint with hlint
lint:
    hlint --git

# Clean build artifacts
clean:
    cabal clean
    rm -rf dist-newstyle/
