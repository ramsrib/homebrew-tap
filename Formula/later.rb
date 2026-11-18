class Later < Formula
  desc "Leave a reminder for a future Claude Code or Codex session in this project"
  homepage "https://github.com/ramsrib/later"
  version "0.1.5"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/ramsrib/later/releases/download/v#{version}/later_#{version}_darwin_arm64.tar.gz"
      sha256 "a204c13b86862dcb66af04a0a60f6e6b37c6de9bc811954033cba6f34c3f47c7"
    end
    on_intel do
      url "https://github.com/ramsrib/later/releases/download/v#{version}/later_#{version}_darwin_amd64.tar.gz"
      sha256 "b04b862108de5d424147cf38acdde9648b332382aa872e65ac693aca86da66b7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ramsrib/later/releases/download/v#{version}/later_#{version}_linux_arm64.tar.gz"
      sha256 "2b8dfa1dba1632c87a89fc022bcd6611c57a42847691f4f014af903022b139bb"
    end
    on_intel do
      url "https://github.com/ramsrib/later/releases/download/v#{version}/later_#{version}_linux_amd64.tar.gz"
      sha256 "4c91b7d7765b70464a23be3d4e827318be86bfd21a6df0cad61a54b03199519a"
    end
  end

  def install
    bin.install "later"
  end

  def caveats
    <<~EOS
      Wire the prompt hook for whichever agents you use:

        later install --claude
        later install --codex     # then approve trust on your next Codex session

      An untrusted Codex hook fails silently, so confirm both with:

        later doctor
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/later --version")
    assert_match "no reminders due", shell_output("#{bin}/later check")
  end
end
