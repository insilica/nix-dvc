# nix-dvc

[Nix](https://nixos.org) flake for [DVC](https://github.com/iterative/dvc).

Doesn't work yet due to pathspec error, but try again after dvc 2.42.0 release.

## Usage

Install with `nix profile install github:insilica/nix-dvc`

Or run with `nix run github:insilica/nix-dvc`

## Updating

- Update version and the dvc version in pyproject.toml.
- Run `poetry install`
- Remove lines that say `dvc = "*"` from poetry.lock to avoid an infinite recursion error.
- Test with `nix run` and `nix flake check`
