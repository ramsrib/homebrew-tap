cask "abra" do
  version "0.2.7"
  sha256 "51ccef6ef0a1ca283a33bf772efb2d5043e8409854e40a814c7aadc051c9842d"

  url "https://github.com/ramsrib/abra/releases/download/v#{version}/Abra-#{version}-darwin-arm64.zip"
  name "abra"
  desc "Local push-to-talk dictation — hold Fn, speak, release"
  homepage "https://github.com/ramsrib/abra"

  depends_on arch: :arm64
  depends_on formula: "ffmpeg"
  depends_on formula: "uv"
  depends_on macos: :ventura

  app "Abra.app"

  # The engine is pinned to this release's tag, never a moving branch, so a
  # broken main can't affect installs or upgrades.
  # Steps run sandboxed with HOME pointing at a throwaway directory, so the
  # real home is spelled out, and uv is pointed at the real cache and Python
  # installs (otherwise the venv would link a Python that is deleted).
  postflight_steps do
    if_path_exists ".abra/engine/pyproject.toml", base: :home do
      run "/bin/sh",
          args:           ["-c",
                           "cd /Users/{{user}}/.abra/engine && " \
                           "(/usr/bin/git fetch --depth 1 origin tag v{{version}} && " \
                           "/usr/bin/git checkout -q v{{version}} && " \
                           "{{HOMEBREW_PREFIX}}/bin/uv sync) || true"],
          env:            {
            "UV_CACHE_DIR"          => "/Users/{{user}}/.cache/uv",
            "UV_PYTHON_INSTALL_DIR" => "/Users/{{user}}/.local/share/uv/python",
          },
          print_stderr:   false,
          writable_paths: [".abra", ".cache/uv", ".local/share/uv"],
          writable_base:  :home,
          network_access: true
    end
    unless_path_exists ".abra/engine/pyproject.toml", base: :home do
      run "/bin/sh",
          args:           ["-c",
                           "/usr/bin/git clone --depth 1 --branch v{{version}} " \
                           "https://github.com/ramsrib/abra /Users/{{user}}/.abra/engine && " \
                           "cd /Users/{{user}}/.abra/engine && {{HOMEBREW_PREFIX}}/bin/uv sync"],
          env:            {
            "UV_CACHE_DIR"          => "/Users/{{user}}/.cache/uv",
            "UV_PYTHON_INSTALL_DIR" => "/Users/{{user}}/.local/share/uv/python",
          },
          print_stderr:   false,
          writable_paths: [".abra", ".cache/uv", ".local/share/uv"],
          writable_base:  :home,
          network_access: true
    end
  end

  zap trash: "~/.abra"

  caveats <<~EOS
    First launch downloads the speech model (~700MB) — the menu bar icon
    shows an hourglass while it loads.

    The engine lives in ~/.abra/engine, pinned to this release's tag and
    updated automatically on brew upgrade.
  EOS
end
