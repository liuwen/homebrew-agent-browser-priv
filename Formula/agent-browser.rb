class AgentBrowser < Formula
  desc "Browser automation CLI for AI agents with Patchright as the default backend"
  homepage "https://github.com/liuwen/agent-browser-priv"
  version "0.27.3-priv.4"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/liuwen/agent-browser-priv/releases/download/v0.27.3-priv.4/agent-browser-priv-darwin-arm64"
      sha256 "09de4408f259f786790d0988008beabf93d554196c50441e91a1efbbbd6df365"
    end
  end

  def install
    unsupported = "agent-browser Homebrew binary is currently published for macOS ARM64 only"
    odie unsupported unless supported_platform?

    bin.install "agent-browser-priv-darwin-arm64" => "agent-browser"
    bin.install_symlink bin/"agent-browser" => "agent-browser-priv"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agent-browser --version")
    assert_match version.to_s, shell_output("#{bin}/agent-browser-priv --version")
  end

  def supported_platform?
    OS.mac? && Hardware::CPU.arm?
  end
end
