class Recall < Formula
  desc "Local-first hybrid search over your Claude Code and Codex sessions"
  homepage "https://github.com/ramsrib/recall-cli"
  version "0.1.1"
  license "MIT"

  # Ollama is deliberately NOT a depends_on. Most people run it as Ollama.app
  # (from ollama.com), and the formula would install a second copy — dragging in
  # python + mlx — that competes with the app's server on :11434. Either install
  # satisfies recall, so the caveats ask for one rather than forcing this one.

  on_macos do
    on_arm do
      url "https://github.com/ramsrib/recall-cli/releases/download/v#{version}/recall_#{version}_darwin_arm64.tar.gz"
      sha256 "fc91862202ca32d5176faebd2e27cb4b23bf5cda12ed9549f55ea86208b5ef66"
    end
    on_intel do
      url "https://github.com/ramsrib/recall-cli/releases/download/v#{version}/recall_#{version}_darwin_amd64.tar.gz"
      sha256 "cb2a42692581146d0665ce56caa22b73960090b122727be3023dfe5a3762ae38"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ramsrib/recall-cli/releases/download/v#{version}/recall_#{version}_linux_arm64.tar.gz"
      sha256 "2ee1424bf8d55077235682f804ce95d4a9817cb34eccc2c4aad1ba9a530115e7"
    end
    on_intel do
      url "https://github.com/ramsrib/recall-cli/releases/download/v#{version}/recall_#{version}_linux_amd64.tar.gz"
      sha256 "3b3ea7a7b22140573e903cc5ecff34cf17edc8c90becf2f1952060725f333cb0"
    end
  end

  livecheck do
    url "https://github.com/ramsrib/recall-cli/releases/latest"
    strategy :github_latest
  end

  def install
    bin.install "recall"
  end

  def caveats
    <<~EOS
      recall embeds locally via Ollama. If you don't already have it, install it
      either way — Ollama.app from https://ollama.com, or:

        brew install ollama && brew services start ollama

      Then pull the embedding model and build the index (the first index takes a
      while — it reads every session you have):

        ollama pull qwen3-embedding:0.6b
        recall index
        recall "how did I fix that migration"

      Lexical search needs neither Ollama nor a model:

        recall "migration" --mode lexical

      The index lives at ~/.config/recall/index.db. Note that `recall summary`
      sends transcript text to the `codex` CLI, so that command does leave your
      machine — see the README's "Privacy & network behavior".
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/recall --version")
  end
end
