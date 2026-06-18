class AgentBrowser < Formula
  desc "Browser automation CLI for AI agents with Patchright as the default backend"
  homepage "https://github.com/liuwen/agent-browser-priv"
  version "0.28.0-priv.2"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/liuwen/agent-browser-priv/releases/download/v0.28.0-priv.2/agent-browser-priv-darwin-arm64"
      sha256 "461deca6263ed406d9ee4c5b7211792e5d150bdfe297d13621935836ad0b2b03"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/liuwen/agent-browser-priv/releases/download/v0.28.0-priv.2/agent-browser-priv-linux-arm64"
      sha256 "82b48c813a2cb5f2e01d1ef4ab3657708138312691d885d2f8b53119cf5be497"
    elsif Hardware::CPU.intel?
      url "https://github.com/liuwen/agent-browser-priv/releases/download/v0.28.0-priv.2/agent-browser-priv-linux-x64"
      sha256 "379ead72de58b7c315bb68b971e2596f4c9b33bc2bd53dd2f800554e71504a5a"
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
