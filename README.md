# nix-dvc

[Nix](https://nixos.org) flake for [DVC](https://github.com/iterative/dvc).

Doesn't work yet due to recursive dependencies (e.g., dvc => dvc-http => dvc).

## Usage

Install with `nix profile install github:insilica/nix-dvc`

Or run with `nix run github:insilica/nix-dvc`

## Updating

- Update version and the dvc version in pyproject.toml.
- Run `poetry install`
  - I used `docker run -ti --volume ~/src/nix-dvc:/nix-dvc fnndsc/python-poetry poetry install -C /nix-dvc` to work around bugs in poetry (via dulwich). See https://github.com/python-poetry/poetry/issues/6873
- Test with `nix run` and `nix flake check`
