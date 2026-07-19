class Later < Formula
  desc "Leave a reminder for a future Claude Code or Codex session in this project"
  homepage "https://github.com/ramsrib/later"
  version "0.1.0"
  license "MIT"

  livecheck do
    url "https://github.com/ramsrib/later/releases/latest"
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/ramsrib/later/releases/download/v#{version}/later_#{version}_darwin_arm64.tar.gz"
      sha256 "016c8a83149723e58c5c130a4e0316eb2668eeec2f126a3565298e48b8fca6a1"
    end
    on_intel do
      url "https://github.com/ramsrib/later/releases/download/v#{version}/later_#{version}_darwin_amd64.tar.gz"
      sha256 "59456bf4a445d21781084a90411e8455bb767aacbee38298c44961591ae4fbbb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ramsrib/later/releases/download/v#{version}/later_#{version}_linux_arm64.tar.gz"
      sha256 "274810d173efd94d6a78255fa5e055b23dffc5216f97776a141e7f05c087812e"
    end
    on_intel do
      url "https://github.com/ramsrib/later/releases/download/v#{version}/later_#{version}_linux_amd64.tar.gz"
      sha256 "28780d019c9176e78908bea0dff9b7be086f2e0249984e180b1dd567240f3667"
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
