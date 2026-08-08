class Routines < Formula
  desc "Presence-gated job scheduler - jobs fire when you're active, not on a wall clock"
  homepage "https://github.com/ramsrib/routines"
  version "0.1.0"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/ramsrib/routines/releases/download/v#{version}/routines_#{version}_darwin_arm64.tar.gz"
      sha256 "c41136cc44f8cf273f0de40fa0f2f7e1e8f42cc273ea82961ff7c3d6896e2ff0"
    end
    on_intel do
      url "https://github.com/ramsrib/routines/releases/download/v#{version}/routines_#{version}_darwin_amd64.tar.gz"
      sha256 "bb55bb633744de3bb8e9bfd568896e2c8f13890ab05188f040cb58f77a7f932b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/ramsrib/routines/releases/download/v#{version}/routines_#{version}_linux_arm64.tar.gz"
      sha256 "7fab80c2e4f0b967b24441d49583bc8acb6d04959b8103f990fefaa1c00cc588"
    end
    on_intel do
      url "https://github.com/ramsrib/routines/releases/download/v#{version}/routines_#{version}_linux_amd64.tar.gz"
      sha256 "ca913b66b6b0565b9e727dade463b9741f568532b78230cdc2c75e26d7ed0ef5"
    end
  end

  def install
    bin.install "routines"
  end

  def caveats
    <<~EOS
      Describe your jobs in ~/.config/routines/jobs.toml (see the README for
      the schema), then wire the dispatcher to fire on a schedule — on macOS a
      launchd agent running `routines tick` at login and every 15 minutes.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/routines --version")
  end
end
