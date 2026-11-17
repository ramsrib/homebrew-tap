class Later < Formula
  desc "Leave a reminder for a future Claude Code or Codex session in this project"
  homepage "https://github.com/ramsrib/later"
  version "0.1.4"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/ramsrib/later/releases/download/v#{version}/later_#{version}_darwin_arm64.tar.gz"
      sha256 "bf7080ae8e2dfc371854d533a34303575e657e7f490206559950c4e3dbcfa345"
    end
    on_intel do
      url "https://github.com/ramsrib/later/releases/download/v#{version}/later_#{version}_darwin_amd64.tar.gz"
      sha256 "0bf9032b8d71329420b84983fc5616121a7c629e3541fc3c688d294f417d9c81"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ramsrib/later/releases/download/v#{version}/later_#{version}_linux_arm64.tar.gz"
      sha256 "680bca333fd8987da552c7648a92bfead32bce33f38384579f283b1a53cc2be2"
    end
    on_intel do
      url "https://github.com/ramsrib/later/releases/download/v#{version}/later_#{version}_linux_amd64.tar.gz"
      sha256 "99f56f165455cbb2f906aad776561d1066c189a5dfa3cfe195533a1f38b358d3"
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
