class AgentBrowserPriv < Formula
  desc "Browser automation CLI for AI agents with opt-in local privacy backends"
  homepage "https://github.com/liuwen/agent-browser-priv"
  version "0.27.3-priv.3"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/liuwen/agent-browser-priv/releases/download/v0.27.3-priv.3/agent-browser-priv-darwin-arm64"
      sha256 "51cb2c13543d264cde580f8880361a91f26786c707b54e996597edd59cfa0859"
    end
  end

  def install
    odie "agent-browser-priv Homebrew binary is currently published for macOS ARM64 only" unless OS.mac? && Hardware::CPU.arm?

    bin.install "agent-browser-priv-darwin-arm64" => "agent-browser-priv"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agent-browser-priv --version")
  end
end
