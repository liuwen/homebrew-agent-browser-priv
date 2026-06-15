class AgentBrowser < Formula
  desc "Browser automation CLI for AI agents with Patchright as the default backend"
  homepage "https://github.com/liuwen/agent-browser-priv"
  version "0.27.3-priv.6"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/liuwen/agent-browser-priv/releases/download/v0.27.3-priv.6/agent-browser-priv-darwin-arm64"
      sha256 "b1862e24dc63bd5448039eca2a6f8dddd0c231ca79d03201b2e83aab43a137f6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/liuwen/agent-browser-priv/releases/download/v0.27.3-priv.6/agent-browser-priv-linux-arm64"
      sha256 "9576968891446428d986fee4f1e49fb26031225318c1f575250e4edae32a91a8"
    elsif Hardware::CPU.intel?
      url "https://github.com/liuwen/agent-browser-priv/releases/download/v0.27.3-priv.6/agent-browser-priv-linux-x64"
      sha256 "364544c589e8f2d92e2a7162ea79f3040765d082882158e71e60c8665615b848"
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
