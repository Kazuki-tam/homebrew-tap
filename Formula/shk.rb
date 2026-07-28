class Shk < Formula
  desc "shk CLI"
  homepage "https://github.com/Kazuki-tam/security-harness-kit"
  version "0.5.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Kazuki-tam/security-harness-kit/releases/download/v0.5.8/shk-cli-aarch64-apple-darwin.tar.xz"
      sha256 "f0e2a5aa2cc37f16f8690348762f3117b227eb0954ba7c54f1fc5ab24d408982"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kazuki-tam/security-harness-kit/releases/download/v0.5.8/shk-cli-x86_64-apple-darwin.tar.xz"
      sha256 "1c710b40b9f20576c1212ddf7284e8342ec4db8a9a36a8e99ee7f20424cfd0d7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Kazuki-tam/security-harness-kit/releases/download/v0.5.8/shk-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "129527bb06f4503896e264ba50862e163d409515318d6faf6bca229959250619"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kazuki-tam/security-harness-kit/releases/download/v0.5.8/shk-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b918b9e8dc8628b13215f6afa1ebeb0497230259b4759f1c0301781cd9af1b29"
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
