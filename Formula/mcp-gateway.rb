class McpGateway < Formula
  desc "Open-source MCP Gateway operator CLI."
  homepage "https://github.com/Fetch-Hive/openapi-mcp"
  version "0.10.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Fetch-Hive/openapi-mcp/releases/download/v0.10.0/mcp-gateway-cli-aarch64-apple-darwin.tar.xz"
      sha256 "e85d583b9c9a61a9ae3a3ef7400ea989929b2bf4d1863f000b020828bd4db0f8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Fetch-Hive/openapi-mcp/releases/download/v0.10.0/mcp-gateway-cli-x86_64-apple-darwin.tar.xz"
      sha256 "b9955a9a64800127b676a85c72c634a2430e826b22e8ea8273391becb13e4eac"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Fetch-Hive/openapi-mcp/releases/download/v0.10.0/mcp-gateway-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "4fcdbeb92c32ab80e2476185e655c6a0a18050f6d755753451b276931c0961cc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Fetch-Hive/openapi-mcp/releases/download/v0.10.0/mcp-gateway-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "8ffcf002ecabed3e5407c2f99ca3ab4fd9a73d6a092ad9f8e5df58c0ba127f09"
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
