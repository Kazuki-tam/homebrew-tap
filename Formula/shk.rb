class Shk < Formula
  desc "shk CLI"
  homepage "https://github.com/Kazuki-tam/security-harness-kit"
  version "0.7.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Kazuki-tam/security-harness-kit/releases/download/v0.7.7/shk-cli-aarch64-apple-darwin.tar.xz"
      sha256 "2c35f9d34465cb14093ed4a2a377c7ff23854f4908bf277f72ba009c47e61798"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kazuki-tam/security-harness-kit/releases/download/v0.7.7/shk-cli-x86_64-apple-darwin.tar.xz"
      sha256 "88d5f0d872d7f71318d9086d2fb03e057aa2c78c40996459e7bec506dcbfe7cb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Kazuki-tam/security-harness-kit/releases/download/v0.7.7/shk-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6621e646691ff48cdaecf3de760c930ee1816cac6650cded8a6afefa14550bba"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Kazuki-tam/security-harness-kit/releases/download/v0.7.7/shk-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f4e4764ff7e477624db3cbb82e8d6d986e4a174f1c5f2ebf49f8fa33d9c1d551"
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
