{
  description = "Example applications for the Eventium event sourcing library";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # Use GHC 9.10.3 (Stackage LTS 24), matching the eventium library.
        hPkgs = pkgs.haskell.packages.ghc9103;

        devDependencies = with pkgs; [
          # Haskell toolchain
          hPkgs.ghc
          hPkgs.cabal-install
          hPkgs.hpack

          # Development tools
          hPkgs.haskell-language-server
          hPkgs.hlint
          hPkgs.ormolu
          hPkgs.ghcid
          hPkgs.hspec-discover
          just

          # System dependencies (examples use eventium-sqlite)
          pkg-config
          sqlite
          zlib
        ];
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = devDependencies;

          shellHook = ''
            just hpack
            echo ""
            just --list
          '';

          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
            pkgs.sqlite
            pkgs.zlib
          ];
        };
      }
    );
}
