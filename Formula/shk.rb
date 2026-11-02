class Shk < Formula
  desc "shk CLI"
  homepage "https://github.com/Kazuki-tam/security-harness-kit"
  version "0.7.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Kazuki-tam/security-harness-kit/releases/download/v0.7.6/shk-cli-aarch64-apple-darwin.tar.xz"
      sha256 "8e3b5c4669013c64dd9c024bb8ab818caea8723b1514248d06113c23f27eef96"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kazuki-tam/security-harness-kit/releases/download/v0.7.6/shk-cli-x86_64-apple-darwin.tar.xz"
      sha256 "edd05eccd58a1aa1aeb4f2751db27ca70141b905b7366c977c15a7d023cdad3a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Kazuki-tam/security-harness-kit/releases/download/v0.7.6/shk-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "eb20b3c840b9a572a3bf8c9962aabf239094cd552a575acc69d08726a16e3443"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kazuki-tam/security-harness-kit/releases/download/v0.7.6/shk-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f750ef433ae2dbd6f2690c7b8fc21d2157435904ff57bfd579d62ed2983fb36f"
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
