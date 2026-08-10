cask "temple" do
  version "0.1.11"
  sha256 "da3337156a9a0f3844fa2d4269a92468aad8ef35dfed7acf4de9a0760bc6fe4a"

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

  zap trash: [
    "~/Library/Application Support/Temple",
    "~/Library/Caches/com.sriramb.temple",
    "~/Library/Preferences/com.sriramb.temple.plist",
    "~/Library/Saved Application State/com.sriramb.temple.savedState",
  ]
end
