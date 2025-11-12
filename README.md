# playwright-nix

A NixOS flake providing a Playwright development environment with pre-configured
browser binaries. This flake sets up Node.js 24, Playwright Test, and browser
drivers with proper NixOS paths, eliminating manual browser installation issues.

## Quick Start

Run Playwright directly from GitHub:

```bash
nix run github:BridgerB/playwright-nix -- open bridgerb.com
```

Or enter a development shell:

```bash
nix develop github:BridgerB/playwright-nix
```

Or clone and use locally:

```bash
git clone https://github.com/BridgerB/playwright-nix.git
cd playwright-nix
nix develop
```

The environment includes the `playwright` CLI command and all necessary browser
binaries ready to use.
