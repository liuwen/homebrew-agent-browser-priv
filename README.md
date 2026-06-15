# Homebrew tap for agent-browser

This tap distributes `agent-browser`, a fork of `vercel-labs/agent-browser`
with Patchright as the default local Chrome-compatible backend.

Install:

```bash
brew tap liuwen/agent-browser-priv
brew install agent-browser
```

The formula installs `agent-browser` and keeps `agent-browser-priv` as a
compatibility command alias for existing scripts. Published binaries are
available for macOS ARM64 and Linux x86_64/ARM64.
