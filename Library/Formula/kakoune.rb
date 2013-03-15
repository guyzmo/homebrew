require 'formula'

class Kakoune < Formula
  homepage 'https://github.com/mawww/kakoune'
  url 'https://github.com/mawww/kakoune.git'
  version '1.0'

  depends_on 'boost'
  depends_on 'gcc'

  def patches; DATA; end

  def install
    cd 'src' do
      system "make", "CXX=g++-4.7"
      prefix.install "kak"
      prefix.install "rc"
    end
    bin.install_symlink prefix/"kak"
    etc.install_symlink prefix/"rc" => "kak"
  end

  def caveats; <<-EOS.undent
    All configuration files of Kakoune are installed in /usr/local/etc/kak/. To use
    them you shall copy those files into ~/.config/kak/:

        mkdir -p ~/.config/kak/
        cp /usr/local/etc/kak/*.kak ~/.config/kak/

    Go have a look at kak's homepage 
    EOS
  end
end


# change libboost_regex to libboost_regex-mt
__END__
diff --git a/src/Makefile b/src/Makefile
index f0ac8aa..aaba8ed 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -3,7 +3,7 @@ objects := $(sources:.cc=.o)
 deps := $(addprefix ., $(sources:.cc=.d))
 
 CXXFLAGS += -std=c++0x -g -Wall -Wno-reorder -Wno-sign-compare
-LDFLAGS += -lmenu -lncursesw -lboost_regex
+LDFLAGS += -lmenu -lncursesw -lboost_regex-mt
 
 debug ?= yes
 ifeq ($(debug),yes)
