cask "temple" do
  version "0.8.1"
  sha256 "b4f54fc28d0c4b4b237decb8ad9ef62abd5f7abb788aedce4a9ee7e8d9c2d726"

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
