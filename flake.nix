{
  description = "dvc";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    poetry2nix = {
      url = "github:nix-community/poetry2nix";
      inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, flake-utils, poetry2nix }:
    flake-utils.lib.eachDefaultSystem (system:
      with import nixpkgs { inherit system; };
      let
        inherit (poetry2nix.legacyPackages.${system})
          defaultPoetryOverrides mkPoetryApplication;
        dvc = mkPoetryApplication {
          projectDir = self;
          overrides = defaultPoetryOverrides.extend (self: super: {
            flufl-lock = super.flufl-lock.overridePythonAttrs
              (old: { buildInputs = (old.buildInputs or [ ]) ++ [ pdm ]; });
            hydra-core = python3Packages.hydra-core;
            pygit2 = super.pygit2.overridePythonAttrs
              (old: { buildInputs = (old.buildInputs or [ ]) ++ [ libgit2 ]; });
          });
        };
      in {
        packages = {
          inherit dvc;
          default = dvc;
        };
        devShells.default =
          mkShell { buildInputs = [ poetry2nix.packages.${system}.poetry ]; };
      });
}
