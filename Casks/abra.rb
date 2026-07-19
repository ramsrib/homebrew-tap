cask "abra" do
  version "0.2.2"
  sha256 "536526c96c559728d3e149618119fe2ecef67117b1ac3c82dfe09b126fbcc3b0"

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
    if File.exist?(File.join(engine, "pyproject.toml"))
      # Upgrade: refresh the engine to match the app (best-effort — a locally
      # modified engine is left alone rather than failing the install).
      refresh = "cd #{engine} && " \
                "(/usr/bin/git pull --ff-only && #{HOMEBREW_PREFIX}/bin/uv sync) || true"
      system_command "/bin/sh",
                     args:         ["-c", refresh],
                     print_stderr: false
    else
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

    The engine lives in ~/.abra/engine (cloned on install). To update it:
      cd ~/.abra/engine && git pull && uv sync
  EOS
end
