cask "tarp" do
  version "0.1.1"
  sha256 "c4117b70e2a0103d48a9a483af5c1acbdabb021de99fe1838082c37bd9988a52"

  url "https://github.com/ramsrib/tarp/releases/download/v#{version}/Tarp-macos-arm64.dmg"
  name "Tarp"
  desc "Plain, privacy-first terminal"
  homepage "https://github.com/ramsrib/tarp"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :big_sur

  app "Tarp.app"

  zap trash: [
    "~/.tarp",
    "~/Library/Application Support/dev.tarp.Tarp",
    "~/Library/Caches/dev.tarp.Tarp",
    "~/Library/Preferences/dev.tarp.Tarp.plist",
    "~/Library/Saved Application State/dev.tarp.Tarp.savedState",
  ]
end
