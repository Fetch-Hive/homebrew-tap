class McpGateway < Formula
  desc "Open-source MCP Gateway operator CLI."
  homepage "https://github.com/Fetch-Hive/openapi-mcp"
  version "0.7.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Fetch-Hive/openapi-mcp/releases/download/v0.7.1/mcp-gateway-cli-aarch64-apple-darwin.tar.xz"
      sha256 "9b04976186a68910272644799e2753c6470072f4c25cbe44f7df7072e5545d1d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Fetch-Hive/openapi-mcp/releases/download/v0.7.1/mcp-gateway-cli-x86_64-apple-darwin.tar.xz"
      sha256 "5f65cd01cc8547be51efbf06223226577ae75baefee87f9b9964b60eebd47461"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Fetch-Hive/openapi-mcp/releases/download/v0.7.1/mcp-gateway-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "e363b657bce6f9a3c0487cffe1f4510e98608f3234b28076ce5d8ae6f742055a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Fetch-Hive/openapi-mcp/releases/download/v0.7.1/mcp-gateway-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "86acc73342863184bddc2c14f8cf9fba83cafc128d4e76785dbce5fdee83fd07"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "mcp-gateway"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "mcp-gateway"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "mcp-gateway"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "mcp-gateway"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
