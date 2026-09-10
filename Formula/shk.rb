class Shk < Formula
  desc "shk CLI"
  homepage "https://github.com/Kazuki-tam/security-harness-kit"
  version "0.6.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Kazuki-tam/security-harness-kit/releases/download/v0.6.4/shk-cli-aarch64-apple-darwin.tar.xz"
      sha256 "50acd78ec9c915481c1943b9d8b1e29d2698375fd4a7c5e04d2bb4e852457ed9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kazuki-tam/security-harness-kit/releases/download/v0.6.4/shk-cli-x86_64-apple-darwin.tar.xz"
      sha256 "af458573e20b37729766f02db35c3fdc11fa5eed0f4d391891255bb05d28c452"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Kazuki-tam/security-harness-kit/releases/download/v0.6.4/shk-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1e4357cf00935a656d1930a726689b44294b7f8d402724e655849dd13bb656bb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kazuki-tam/security-harness-kit/releases/download/v0.6.4/shk-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3a7db47b55911af2b9b95db84fee4984af9a60160cbc9fbd64cba7e1a039bb54"
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
