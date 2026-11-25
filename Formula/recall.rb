class Recall < Formula
  desc "Local-first hybrid search over Claude Code, Codex, and Antigravity sessions"
  homepage "https://github.com/ramsrib/recall-cli"
  version "0.1.3"
  license "MIT"

  # Ollama is deliberately NOT a depends_on. Most people run it as Ollama.app
  # (from ollama.com), and the formula would install a second copy — dragging in
  # python + mlx — that competes with the app's server on :11434. Either install
  # satisfies recall, so the caveats ask for one rather than forcing this one.

  on_macos do
    on_arm do
      url "https://github.com/ramsrib/recall-cli/releases/download/v#{version}/recall_#{version}_darwin_arm64.tar.gz"
      sha256 "80cc1afede095711cc7445c9cdad3e223f8cd9558f1753c7e2a87a33bb5f4af4"
    end
    on_intel do
      url "https://github.com/ramsrib/recall-cli/releases/download/v#{version}/recall_#{version}_darwin_amd64.tar.gz"
      sha256 "878d24f633592ad6dc98bbdd4bf967f00b3814863d2206d96455330b09bd43d4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ramsrib/recall-cli/releases/download/v#{version}/recall_#{version}_linux_arm64.tar.gz"
      sha256 "0702e90364d795b391545d86285942515f287909699b5b63a6b1a9cc8dc27cb3"
    end
    on_intel do
      url "https://github.com/ramsrib/recall-cli/releases/download/v#{version}/recall_#{version}_linux_amd64.tar.gz"
      sha256 "2398637670965227e6ed6d9d944e43437b8cc574adc61d7c1001292cded19894"
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
