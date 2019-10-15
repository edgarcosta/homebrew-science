class Arb < Formula
  desc "C library for arbitrary-precision floating-point ball arithmetic"
  homepage "http://fredrikj.net/arb/index.html"
  url "https://github.com/fredrik-johansson/arb/archive/2.16.0.tar.gz"
  sha256 "77464be4d34a511bb004457f862fec857ff934b0ed58d56d6f52d76ebadd4daf"
  head "https://github.com/fredrik-johansson/arb.git"

  option "without-test", "Disable build-time checking (not recommended)"

  depends_on "gmp"
  depends_on "mpfr"
  depends_on "flint"

  def install
    if OS.mac?
      inreplace "Makefile.in" do |s|
        s.gsub! "ln -sf \"$(ARB_LIB)\" \"$(ARB_LIBNAME).$(ARB_MAJOR)\";",
                "ln -sf \"$(ARB_LIB)\" \"libarb.$(ARB_MAJOR).dylib\";"
        s.gsub! "cp -a $(shell ls $(ARB_LIBNAME)*) \"$(DESTDIR)$(PREFIX)/$(LIBDIR)\";",
                "cp -a $(shell ls libarb*) \"$(DESTDIR)$(PREFIX)/$(LIBDIR)\";"
      end
    end

    ENV.append "CCFLAGS", "-std=c11"
    system "./configure", "--prefix=#{prefix}",
                          "--with-gmp=#{Formula["gmp"].opt_prefix}",
                          "--with-mpfr=#{Formula["mpfr"].opt_prefix}",
                          "--with-flint=#{Formula["flint"].opt_prefix}"

    system "make"
    system "make", "install"
    system "make", "check" if build.with? "test"
  end

  test do
    (testpath / "test.c").write <<~EOS
      #include <stdio.h>
      #include "arb.h"

      int main()
      {
        arb_t x;
        arb_init(x);
        arb_const_pi(x, 50 * 3.33);
        arb_printn(x, 50, 0);
        printf("\\nComputed with arb-%s\\n", arb_version);
        arb_clear(x);

        return EXIT_SUCCESS;
      }
    EOS
    system ENV.cc, "test.c", "-larb", "-lflint", "-I#{Formula["flint"].include}/flint", "-o", "test"
    system "./test"
  end
end
