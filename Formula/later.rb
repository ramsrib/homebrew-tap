class Later < Formula
  desc "Leave a reminder for a future Claude Code or Codex session in this project"
  homepage "https://github.com/ramsrib/later"
  version "0.1.2"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/ramsrib/later/releases/download/v#{version}/later_#{version}_darwin_arm64.tar.gz"
      sha256 "b22beda613e4b74c0996265747d740c6f4c78bd2f6c42afb8c0f5d105f17405d"
    end
    on_intel do
      url "https://github.com/ramsrib/later/releases/download/v#{version}/later_#{version}_darwin_amd64.tar.gz"
      sha256 "4c945481c72a89f125e0b19e11443337c228359d6206df0898a8516a4fa467e4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ramsrib/later/releases/download/v#{version}/later_#{version}_linux_arm64.tar.gz"
      sha256 "e71f73806ae272e155482d43570f3a0298c745241fb60d9559213a65683b9f19"
    end
    on_intel do
      url "https://github.com/ramsrib/later/releases/download/v#{version}/later_#{version}_linux_amd64.tar.gz"
      sha256 "039614253baac61f668d06a7f0829352d678651a63ca67241c0c1b9704474b61"
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
