FROM emscripten/emsdk:3.1.50

RUN apt-get update && apt-get install -y libtool autoconf pkg-config

RUN wget https://github.com/openssl/openssl/archive/refs/tags/openssl-3.0.0.zip &&\
    unzip openssl-3.0.0.zip &&\
    cd openssl-openssl-3.0.0 &&\
    emconfigure ./Configure --cross-compile-prefix="" no-asm no-engine no-tests no-unit-test no-shared &&\
    make install_sw &&\
    make install

RUN wget https://download.gnome.org/sources/libxml2/2.9/libxml2-2.9.12.tar.xz &&\
    tar -xf libxml2-2.9.12.tar.xz &&\
    cd libxml2-2.9.12 &&\
    ./autogen.sh &&\
    emconfigure ./configure &&\
    emmake make &&\
    make install

RUN emcc -s USE_ZLIB=1 -s USE_FREETYPE=1 -s USE_LIBJPEG=1 -s USE_LIBPNG=1 -E .
