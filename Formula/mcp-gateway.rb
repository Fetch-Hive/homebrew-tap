class McpGateway < Formula
  desc "Open-source MCP Gateway operator CLI."
  homepage "https://github.com/Fetch-Hive/openapi-mcp"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Fetch-Hive/openapi-mcp/releases/download/v0.4.0/mcp-gateway-cli-aarch64-apple-darwin.tar.xz"
      sha256 "374e9edb5cd0107fc88de699cf83381655f2d8356238fcbfb27305f114cf752b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Fetch-Hive/openapi-mcp/releases/download/v0.4.0/mcp-gateway-cli-x86_64-apple-darwin.tar.xz"
      sha256 "a9402082700b30c92aa9ed762f150dc8a9d6bd48fcb5158a99632e58d43a806e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Fetch-Hive/openapi-mcp/releases/download/v0.4.0/mcp-gateway-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "4b26e8d643a4bbeae09e6ffa0fe712425e0614d79a31425239237415f23e6669"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Fetch-Hive/openapi-mcp/releases/download/v0.4.0/mcp-gateway-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "a0b9dcb6cccaadfa82fb35238f627b553a52d09c6680b44447c423b927260d66"
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
