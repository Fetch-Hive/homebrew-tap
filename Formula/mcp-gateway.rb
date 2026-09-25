class McpGateway < Formula
  desc "Open-source MCP Gateway operator CLI."
  homepage "https://github.com/Fetch-Hive/openapi-mcp"
  version "0.8.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Fetch-Hive/openapi-mcp/releases/download/v0.8.1/mcp-gateway-cli-aarch64-apple-darwin.tar.xz"
      sha256 "3ed1c4f9fa65f7faefb11677cc94c2bad89737ff38390fb62b2394ad2ae59df4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Fetch-Hive/openapi-mcp/releases/download/v0.8.1/mcp-gateway-cli-x86_64-apple-darwin.tar.xz"
      sha256 "73c5c4f3be477c695467249d5304c38cd3821a159267809e05a0aba1525665d7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Fetch-Hive/openapi-mcp/releases/download/v0.8.1/mcp-gateway-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "1e5da3a88326ccf1b3752d9c9d410070eace207fef58341ab9ea7fb4e54a05a8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Fetch-Hive/openapi-mcp/releases/download/v0.8.1/mcp-gateway-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "01052c4741efad455cafc66420c6a38ac78269daec4c21df954ff4a08f6aa2d1"
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
