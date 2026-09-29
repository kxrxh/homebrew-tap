class Passgen < Formula
  desc "Generate random, phonetic, and patterned passwords"
  homepage "https://github.com/kxrxh/passgen"
  url "https://github.com/kxrxh/passgen/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "3dd1c0ff3848580c5e1b715b2e85d3865b989d5663ce58a4385d32971111bae3"
  license "MIT"

  depends_on "rust" => :build

  deny_network_access!

  def fetch
    system "cargo", "fetch", *std_cargo_fetch_args
  end

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match(/\A[A-Z]{2}[a-z]{2}\d{2}\z/, shell_output("#{bin}/passgen --pattern UULLDD").strip)
  end
end
