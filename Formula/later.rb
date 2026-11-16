class Later < Formula
  desc "Leave a reminder for a future Claude Code or Codex session in this project"
  homepage "https://github.com/ramsrib/later"
  version "0.1.3"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/ramsrib/later/releases/download/v#{version}/later_#{version}_darwin_arm64.tar.gz"
      sha256 "1db92d362ebe9b8fcfa10c4dabd5f56cd8003b5da79d98ab9496bfe7ecdb43a0"
    end
    on_intel do
      url "https://github.com/ramsrib/later/releases/download/v#{version}/later_#{version}_darwin_amd64.tar.gz"
      sha256 "1488d51400e331e42463224507b27b25078b782f21a42b21bf5c07099af07bff"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ramsrib/later/releases/download/v#{version}/later_#{version}_linux_arm64.tar.gz"
      sha256 "ebccb4a7f759d00736ca65beeaa16c5b6864c3c1f2b54c5cff892d80d241178e"
    end
    on_intel do
      url "https://github.com/ramsrib/later/releases/download/v#{version}/later_#{version}_linux_amd64.tar.gz"
      sha256 "7d2ae0692eaa4eecae3850c79cd3121faaafc62d52c66d1432d377638aa80d94"
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
