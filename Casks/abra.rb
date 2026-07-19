cask "abra" do
  version "0.2.0"
  sha256 "4cd0cfd4b406e78c7bdaf4d3bf333d9ad6a7e6664c91d60998e3e6a0a0b832b6"

  url "https://github.com/ramsrib/abra/releases/download/v#{version}/Abra-#{version}.zip"
  name "abra"
  desc "Local push-to-talk dictation — hold Fn, speak, release"
  homepage "https://github.com/ramsrib/abra"

  depends_on macos: :ventura
  depends_on arch: :arm64
  depends_on formula: "uv"
  depends_on formula: "ffmpeg"

  app "Abra.app"

  postflight do
    engine = File.expand_path("~/.abra/engine")
    unless File.exist?(File.join(engine, "pyproject.toml"))
      system_command "/usr/bin/git",
                     args:         ["clone", "--depth", "1",
                                    "https://github.com/ramsrib/abra", engine],
                     print_stderr: false
      system_command "/bin/sh",
                     args:         ["-c", "cd #{engine} && #{HOMEBREW_PREFIX}/bin/uv sync"],
                     print_stderr: false
    end
  end

  zap trash: "~/.abra"

  caveats <<~EOS
    First launch downloads the speech model (~700MB) — the menu bar icon
    shows an hourglass while it loads.

    Not yet notarized — macOS will block the first launch. Click "Done"
    (not "Move to Trash"), then: System Settings → Privacy & Security →
    scroll down → "abra" was blocked → Open Anyway → relaunch.

    The engine lives in ~/.abra/engine (cloned on install). To update it:
      cd ~/.abra/engine && git pull && uv sync
  EOS
end
