class AgentBrowser < Formula
  desc "Browser automation CLI for AI agents with Patchright as the default backend"
  homepage "https://github.com/liuwen/agent-browser-priv"
  version "0.28.0-priv.1"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/liuwen/agent-browser-priv/releases/download/v0.28.0-priv.1/agent-browser-priv-darwin-arm64"
      sha256 "dc9d939b8ecfc73124472f5b558c6bfb59bed9377b300274f66617a3ea182b73"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/liuwen/agent-browser-priv/releases/download/v0.28.0-priv.1/agent-browser-priv-linux-arm64"
      sha256 "0403f27e513b3a9a199a96f63dfe3b73c9dff46fe49acbae85875fd84614b92f"
    elsif Hardware::CPU.intel?
      url "https://github.com/liuwen/agent-browser-priv/releases/download/v0.28.0-priv.1/agent-browser-priv-linux-x64"
      sha256 "56a8609436d845681c89f4a9325c09bff37aa15d65bd62ddc6f60281278431b7"
    end
  end

  def install
    unsupported = "agent-browser Homebrew binary is published for macOS ARM64 and Linux x86_64/ARM64"
    odie unsupported unless supported_platform?

    binary = if OS.mac? && Hardware::CPU.arm?
      "agent-browser-priv-darwin-arm64"
    elsif OS.linux? && Hardware::CPU.arm?
      "agent-browser-priv-linux-arm64"
    elsif OS.linux? && Hardware::CPU.intel?
      "agent-browser-priv-linux-x64"
    else
      odie unsupported
    end

    bin.install binary => "agent-browser"
    bin.install_symlink bin/"agent-browser" => "agent-browser-priv"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agent-browser --version")
    assert_match version.to_s, shell_output("#{bin}/agent-browser-priv --version")
  end

  def supported_platform?
    (OS.mac? && Hardware::CPU.arm?) || (OS.linux? && (Hardware::CPU.arm? || Hardware::CPU.intel?))
  end
end
