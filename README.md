# homebrew-tap

A [Homebrew](https://brew.sh) tap for [ramsrib](https://github.com/ramsrib)'s apps.

## Install

```sh
brew tap ramsrib/tap
```

Then install what you want:

```sh
brew install --cask temple        # session manager for Claude Code / Codex
brew install --cask tarp          # plain, privacy-first terminal
brew install --cask folio         # Markdown notes reader
brew install --cask recall-app    # browse + read your agent sessions (pulls in recall)
brew install recall               # the recall CLI on its own
brew install raven                # terminal dashboard for live Claude Code sessions
brew install clipwire             # paste clipboard images into a remote program over SSH
```

Or install without tapping first, using the full name:

```sh
brew install --cask ramsrib/tap/recall-app
```

Updates come through Homebrew:

```sh
brew upgrade --cask recall-app
brew upgrade recall
```

## Casks (apps)

| Cask | Description | Repo |
|---|---|---|
| `temple` | Session manager for Claude Code and Codex sessions — macOS, Apple Silicon | [ramsrib/temple](https://github.com/ramsrib/temple) |
| `tarp` | A plain, privacy-first terminal (a fork of Warp) — macOS, Apple Silicon | [ramsrib/tarp](https://github.com/ramsrib/tarp) |
| `recall-app` | Browse, search, and read your Claude Code & Codex sessions — macOS 14+, Apple Silicon | [ramsrib/recall-app](https://github.com/ramsrib/recall-app) |
| `folio` | Read-optimized, files-on-disk Markdown notes reader — macOS 26+, Apple Silicon | [ramsrib/folio](https://github.com/ramsrib/folio) |

Apps are signed with a Developer ID and notarized by Apple, so they install and
launch cleanly through Gatekeeper.

## Formulae (CLIs)

| Formula | Description | Repo |
|---|---|---|
| `recall` | Local-first hybrid search over your Claude Code and Codex sessions | [ramsrib/recall-cli](https://github.com/ramsrib/recall-cli) |
| `raven` | Terminal dashboard for your local Claude Code sessions — macOS | [ramsrib/raven](https://github.com/ramsrib/raven) |
| `clipwire` | Paste clipboard images into a program on a remote host over SSH — macOS + Linux | [ramsrib/clipwire](https://github.com/ramsrib/clipwire) |

`clipwire` runs a small daemon on your laptop (`brew services start clipwire`) plus a
bit of SSH config — see the [clipwire README](https://github.com/ramsrib/clipwire#readme)
for setup.

## The recall stack

`recall-app` is a front end for the `recall` CLI, so installing the app installs
the CLI too:

```sh
brew install --cask ramsrib/tap/recall-app   # → pulls in the recall formula
```

`recall` embeds locally via [Ollama](https://ollama.com), which is *not* a
Homebrew dependency on purpose: most people run Ollama.app, and forcing the
formula would install a second copy that competes with it for port 11434. Either
install works — if you don't have one yet, pick whichever you prefer:

```sh
# Ollama.app from https://ollama.com, or:
brew install ollama && brew services start ollama
```

Then pull the embedding model and index:

```sh
ollama pull qwen3-embedding:0.6b
recall index
```
