cask "temple" do
  version "0.12.0"
  sha256 "3b0802fc93376afd8458002ba2e6ec611c6fdd131aa8d0a12a0addc28d0ed77f"

  url "https://github.com/ramsrib/temple/releases/download/v#{version}/Temple-v#{version}-arm64.dmg"
  name "Temple"
  desc "IDE for your Claude Code and Codex agents"
  homepage "https://github.com/ramsrib/temple"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Temple.app"
  binary "#{appdir}/Temple.app/Contents/Helpers/temple"

  zap trash: [
    "~/Library/Application Support/Temple",
    "~/Library/Caches/com.sriramb.temple",
    "~/Library/Preferences/com.sriramb.temple.plist",
    "~/Library/Saved Application State/com.sriramb.temple.savedState",
  ]
end
