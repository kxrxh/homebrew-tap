class Passgen < Formula
  desc "Generate passwords and memorable passphrases offline"
  homepage "https://github.com/kxrxh/passgen"
  url "https://github.com/kxrxh/passgen/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "5c73baea04b6a70384ba9788c42ea307b5dba15fe105cb73d49823ea57039516"
  license all_of: ["MIT", "CC-BY-4.0"]

  depends_on "rust" => :build

  deny_network_access!

  def fetch
    system "cargo", "fetch", *std_cargo_fetch_args
  end

  def install
    system "cargo", "install", *std_cargo_args
    pkgshare.install "data/README.md" => "wordlist-attribution.md"
  end

  test do
    assert_equal "passgen #{version}", shell_output("#{bin}/passgen --version").strip
    assert_match(/\A[A-Z]{2}[a-z]{2}\d{2}\z/, shell_output("#{bin}/passgen --pattern UULLDD").strip)
    assert_match(/\A[a-z]+(?:-[a-z]+){5}\z/, shell_output("#{bin}/passgen --words 6").strip)
    result = JSON.parse(shell_output("#{bin}/passgen --words 6 --count 2 --json"))
    assert_equal 2, result.fetch("count")
    assert_equal 2, result.fetch("passwords").length
  end
end
