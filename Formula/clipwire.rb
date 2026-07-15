class Clipwire < Formula
  desc "Paste clipboard images into a program on a remote host over SSH"
  homepage "https://github.com/ramsrib/clipwire"
  url "https://github.com/ramsrib/clipwire/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "7bf8b36376613d2b4d4272add737245df9667589377c7c26c09e539fa64942d1"
  license "MIT"
  head "https://github.com/ramsrib/clipwire.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  service do
    run [opt_bin/"clipwire", "serve"]
    keep_alive true
    log_path var/"log/clipwire.log"
    error_log_path var/"log/clipwire.log"
  end

  test do
    assert_match "clipwire #{version}", shell_output("#{bin}/clipwire --version")
  end
end
