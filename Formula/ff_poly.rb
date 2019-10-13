class FfPoly < Formula
  desc "fast finite field arithmetic over word size prime fields (up to 61 bits)"
  homepage "http://math.mit.edu/~drew/"
  # tag "math"
  url "http://math.mit.edu/~drew/ff_poly_v1.2.7.tar"
  sha256 "686efe53ee138e8be76ec65b1edd0a07e7c661d1ab3a21accb55dee5d019a104"


  depends_on "gmp"

  def install
    system "make"
    ENV.append "INSTALL_ROOT", "#{prefix}"
    system "make", "install"
  end

  test do
    system "false"
  end

end
__END__
diff --git a/makefile b/makefile
index b058da1..3f16a18 100644
--- a/makefile
+++ b/makefile
@@ -1,9 +1,9 @@
-CC = gcc
+# CC = gcc
 CFLAGS = -O3 -fomit-frame-pointer -funroll-loops -m64 -pedantic -std=gnu99
 LDFLAGS = -static
-INCLUDES = -I/usr/local/include
+INCLUDES = # -I/usr/local/include
 LIBS = -lgmp -lm
-INSTALL_ROOT = /usr/local
+# INSTALL_ROOT = /usr/local
 
 HEADERS = asm.h ff.h ffmontgomery64.h ff2k.h ffext.h ffpolyfromroots.h ffpolybig.h ffpolysmall.h ffpoly.h cstd.h ntutil.h polyparse.h
 OBJECTS = ff.o ff2k.o  ffext.o  ffpolyfromroots.o ffpolysmall.o ffpoly_small.o polyparse.o

