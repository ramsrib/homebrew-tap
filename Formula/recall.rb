class Recall < Formula
  desc "Local-first hybrid search over your Claude Code and Codex sessions"
  homepage "https://github.com/ramsrib/recall-cli"
  version "0.1.0"
  license "MIT"

  # Ollama is deliberately NOT a depends_on. Most people run it as Ollama.app
  # (from ollama.com), and the formula would install a second copy — dragging in
  # python + mlx — that competes with the app's server on :11434. Either install
  # satisfies recall, so the caveats ask for one rather than forcing this one.

  on_macos do
    on_arm do
      url "https://github.com/ramsrib/recall-cli/releases/download/v#{version}/recall_#{version}_darwin_arm64.tar.gz"
      sha256 "70c2b80d3850bf36237029fead4fc7c3c8c130d1690892fbc857a3bc2f1349fa"
    end
    on_intel do
      url "https://github.com/ramsrib/recall-cli/releases/download/v#{version}/recall_#{version}_darwin_amd64.tar.gz"
      sha256 "2d70391c69be998fe693d2e3c8e57f4d4f4f3968dd37714b5df6674ed4517be2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ramsrib/recall-cli/releases/download/v#{version}/recall_#{version}_linux_arm64.tar.gz"
      sha256 "bcb51227554b65d27534be853b8139d4177cc4a493ab35be373de12a0cb54222"
    end
    on_intel do
      url "https://github.com/ramsrib/recall-cli/releases/download/v#{version}/recall_#{version}_linux_amd64.tar.gz"
      sha256 "0529c106cab29ed11341ec85cf63fe1eb58be3d6d5c3cd19179ad1cb7e4d40f1"
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
