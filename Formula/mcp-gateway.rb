class McpGateway < Formula
  desc "Open-source MCP Gateway operator CLI."
  homepage "https://github.com/Fetch-Hive/openapi-mcp"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Fetch-Hive/openapi-mcp/releases/download/v0.6.0/mcp-gateway-cli-aarch64-apple-darwin.tar.xz"
      sha256 "39d767fa4c749afdb826791ecbc670d0e738c406a08a634dea3b24093b2f49f8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Fetch-Hive/openapi-mcp/releases/download/v0.6.0/mcp-gateway-cli-x86_64-apple-darwin.tar.xz"
      sha256 "6f1138ae05f7e4d41b41ece3cfc3307b8005cef917e834e9908c3306e25568ef"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Fetch-Hive/openapi-mcp/releases/download/v0.6.0/mcp-gateway-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "740db9fb9715af3cc2d7b0e7b13d7f0ea1b1ddf9a11e96ed55c23264cbc22596"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Fetch-Hive/openapi-mcp/releases/download/v0.6.0/mcp-gateway-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "5c45db66aab395ae75d197ae1f6f6e2a7f613c1c7705b7aa12c1395cfba0633c"
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
