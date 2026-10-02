# Package sets split by platform. Auto-imported by ../default.nix.
#   common.nix  - every machine (Linux + macOS)
#   linux.nix   - Linux/Wayland desktop (self-guarded)
#   darwin.nix  - macOS extras (self-guarded)
{
  imports = [
    ./common.nix
    ./linux.nix
    ./darwin.nix
  ];
}
