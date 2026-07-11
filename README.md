# homebrew-tap

A [Homebrew](https://brew.sh) tap for [ramsrib](https://github.com/ramsrib)'s apps.

## Install

```sh
brew install --cask ramsrib/tap/temple
brew install --cask ramsrib/tap/tarp
```

or tap once, then install by short name:

```sh
brew tap ramsrib/tap
brew install --cask temple
```

Updates come through Homebrew:

```sh
brew upgrade --cask temple
```

## Casks

| Cask | Description | Repo |
|---|---|---|
| `temple` | Your CLI coding agents (Claude Code, Codex), as a chat app — macOS, Apple Silicon | [ramsrib/temple](https://github.com/ramsrib/temple) |
| `tarp` | A plain, privacy-first terminal (a fork of Warp) — macOS, Apple Silicon | [ramsrib/tarp](https://github.com/ramsrib/tarp) |

Apps are signed with a Developer ID and notarized by Apple, so they install and
launch cleanly through Gatekeeper.
