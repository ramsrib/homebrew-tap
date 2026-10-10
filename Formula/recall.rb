class Recall < Formula
  desc "Local-first hybrid search over your Claude Code and Codex sessions"
  homepage "https://github.com/ramsrib/recall-cli"
  version "0.1.2"
  license "MIT"

  # Ollama is deliberately NOT a depends_on. Most people run it as Ollama.app
  # (from ollama.com), and the formula would install a second copy — dragging in
  # python + mlx — that competes with the app's server on :11434. Either install
  # satisfies recall, so the caveats ask for one rather than forcing this one.

  on_macos do
    on_arm do
      url "https://github.com/ramsrib/recall-cli/releases/download/v#{version}/recall_#{version}_darwin_arm64.tar.gz"
      sha256 "b479575b37f89904b245ec4d1283d029584af347840e2779e47564221cba23dd"
    end
    on_intel do
      url "https://github.com/ramsrib/recall-cli/releases/download/v#{version}/recall_#{version}_darwin_amd64.tar.gz"
      sha256 "44a6f1b6fffac29cff3baa9e34949f3ddbad6f69ba642ee87de39afaa016d491"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ramsrib/recall-cli/releases/download/v#{version}/recall_#{version}_linux_arm64.tar.gz"
      sha256 "892ed22bc6ffda67cbe7a5234ebdccb428abb2b53427cd7dbe672018b96dfca5"
    end
    on_intel do
      url "https://github.com/ramsrib/recall-cli/releases/download/v#{version}/recall_#{version}_linux_amd64.tar.gz"
      sha256 "7b5cbafb5033c5ace50f20252e840ecb2afbf450a828cfa6d1ea44c4846efc3c"
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
