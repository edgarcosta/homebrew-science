class Ff_poly < Formula
  desc "fast finite field arithmetic over word size prime fields (up to 61 bits)"
  homepage "http://math.mit.edu/~drew/"
  # tag "math"
  url "http://math.mit.edu/~drew/ff_poly_v1.2.7.tar"
  sha256 "686efe53ee138e8be76ec65b1edd0a07e7c661d1ab3a21accb55dee5d019a104"


  depends_on "gmp"

  def install
    ENV.append "CXXFLAGS", "-std=c++11"
    system "make", "-j4"
    # system "make", "install"
  end

end
