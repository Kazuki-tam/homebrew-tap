class Shk < Formula
  desc "shk CLI"
  homepage "https://github.com/Kazuki-tam/security-harness-kit"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Kazuki-tam/security-harness-kit/releases/download/v0.7.0/shk-cli-aarch64-apple-darwin.tar.xz"
      sha256 "8a644b4b0ef3006652b88c04f7d8507e5ddea8d71186f6a179628faa8c2ebca0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kazuki-tam/security-harness-kit/releases/download/v0.7.0/shk-cli-x86_64-apple-darwin.tar.xz"
      sha256 "0d49d75718409631201690499ac3e7ce6f37530c02f8717c8e89a60a06d85d1f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Kazuki-tam/security-harness-kit/releases/download/v0.7.0/shk-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e3af07213b0eeabf5a5333c67371a86a2c32f69569880094bbb95b80277cecc6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kazuki-tam/security-harness-kit/releases/download/v0.7.0/shk-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c0bd272b2a7390f08f14ebd9fda0e91b642d891abc433155c11277facf016057"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
      bin.install "shk"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "shk"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "shk"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "shk"
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
