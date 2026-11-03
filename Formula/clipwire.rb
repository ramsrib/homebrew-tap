class Clipwire < Formula
  desc "Paste clipboard images into a program on a remote host over SSH"
  homepage "https://github.com/ramsrib/clipwire"
  url "https://github.com/ramsrib/clipwire/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "69fea5723065e3e6ee5de29eb2f6671c9e3e38afe0be9942c50a7c0342f8e79c"
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
