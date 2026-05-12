#!/bin/bash
# RMAP one-line installer.
#
# Usage:
#   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/rythod/homebrew-rmap/main/install.sh)"
#
# Installs Homebrew if missing, taps rythod/rmap, installs the RMAP cask.
# The cask bundles both the GUI app and the `rmap` CLI; the CLI is symlinked
# onto Homebrew's bin prefix so it works in any new terminal with no PATH
# setup.

set -e

# Install Homebrew if missing. The official installer handles arch detection
# (Apple Silicon -> /opt/homebrew, Intel -> /usr/local) and prompts once for
# the user's password.
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found. Installing it first..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Put brew on PATH for the rest of this script. The Homebrew installer also
# persists the equivalent line to ~/.zprofile, so future shells are fine.
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
else
  echo "Error: brew not on PATH after install. Aborting." >&2
  exit 1
fi

# Tap and install.
brew tap rythod/rmap
brew install --cask rmap

cat <<'EOF'

✓ RMAP installed.
  - Launch from Applications, Spotlight, or Launchpad.
  - Open a new Terminal window and type 'rmap' to use the CLI.
  - Run 'brew upgrade --cask rmap' to update.
EOF
