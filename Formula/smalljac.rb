class Smalljac < Formula
  desc "Computing L-series of hyperelliptic curves"
  homepage "http://math.mit.edu/~drew/"
  # tag "math"
  url "http://math.mit.edu/~drew/smalljac_v4.1.3.tar"
  sha256 "981076c082079b18176ad2c9d7029c233837ec62eae724e9dece92003cbd4bfa"


  depends_on "gmp"
  depends_on "ff_poly"

  patch :DATA

  def install
    system "make"
    system "make", "install", "INSTALL_ROOT=#{prefix}"
  end


end
__END__
diff --git a/makefile b/makefile
index 6ea1402..3dd6cfa 100644
--- a/makefile
+++ b/makefile
@@ -1,9 +1,9 @@
-CC = gcc
+#CC = gcc
 CFLAGS = -O3 -fomit-frame-pointer -funroll-loops -m64 -pedantic -std=gnu99
-LDFLAGS = -static
+LDFLAGS = # -static
-INCLUDES = -I/usr/local/include
+INCLUDES = # -I/usr/local/include
 LIBS = -lff_poly -lgmp -lm
-INSTALL_ROOT = /usr/local
+INSTALL_ROOT = # /usr/local
 
 HEADERS = ecurve.h ecurve_ff2.h g2tor3poly.h hecurve.h hcpoly.h igusa.h jac.h jacorder.h lpplot.h nfpoly.h pointcount.h smalljac_g23.h smalljac_internal.h smalljactab.h bitmap.h cstd.h mpzpolyutil.h mpzutil.h ntutil.h polyparse.h prime.h
 OBJECTS = ecurve.o ecurve_ladic.o ecurve_ff2.o hcpoly.o hecurve.o hecurve1.o hecurve2_ladic.o hecurve2.o igusa.o jac.o jacorder.o jacstructure.o nfpoly.o pointcount.o \
@@ -17,8 +17,12 @@ clean:
 	rm -f libsmalljac.a $(PROGRAMS)
 
 install: all
+	mkdir -p $(INSTALL_ROOT)/include
 	cp -v smalljac.h $(INSTALL_ROOT)/include
+	mkdir -p $(INSTALL_ROOT)/lib
 	cp -v libsmalljac.a $(INSTALL_ROOT)/lib
+	mkdir -p $(INSTALL_ROOT)/bin
+	cp $(PROGRAMS) $(INSTALL_ROOT)/bin
 
 ##### smalljac library
 


