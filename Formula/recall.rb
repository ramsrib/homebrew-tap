class Recall < Formula
  desc "Local-first hybrid search over your Claude Code and Codex sessions"
  homepage "https://github.com/ramsrib/recall-cli"
  version "0.1.0"
  license "MIT"

  # Semantic and hybrid search (the default) embed via a local Ollama, so it is
  # a real dependency, not a suggestion. Lexical search works without it.
  depends_on "ollama"

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
      recall embeds locally via Ollama. Start it and pull the embedding model:

        brew services start ollama
        ollama pull qwen3-embedding:0.6b

      Then build the index (first run takes a while — it reads every session):

        recall index
        recall "how did I fix that migration"

      Lexical search needs neither Ollama nor a model:

        recall "migration" --mode lexical

      The index lives at ~/.config/recall/index.db. `recall summary` sends
      transcript text to the `codex` CLI, so it leaves your machine — see the
      README's "Privacy & network behavior".
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/recall --version")
  end
end
