# Maintainer: Dave Murphy <davem@devkitpro.org>
# Contributor: averne <averne381@gmail.com>
# Contributor: Ezekiel Bethel <stary@9net.org>
# Contributor: carstene1ns <dev f4ke de>
# Contributor: jakibaki <jakibaki live com>

pkgname=switch-ffmpeg
pkgver=8.0
pkgrel=1
pkgdesc='ffmpeg port (for Nintendo Switch homebrew development)'
arch=('any')
url='https://ffmpeg.org/'
license=('GPL')
options=(!strip staticlibs)
makedepends=('switch-pkg-config' 'dkp-toolchain-vars')
depends=('switch-zlib' 'switch-bzip2' 'switch-libass' 'switch-libfribidi'
         'switch-freetype' 'switch-mbedtls' 'switch-dav1d' 'switch-libssh2')

source=()
sha256sums=()

groups=('switch-portlibs')

_srcdir="${startdir}"

prepare() {
  :
}

build() {
  cd "${_srcdir}"

  source /opt/devkitpro/switchvars.sh

  ./configure --prefix=$PORTLIBS_PREFIX --enable-gpl --disable-shared --enable-static \
    --cross-prefix=aarch64-none-elf- --enable-cross-compile \
    --arch=aarch64 --cpu=cortex-a57 --target-os=horizon --enable-pic \
    --extra-cflags='-D__SWITCH__ -D_GNU_SOURCE -O2 -march=armv8-a -mtune=cortex-a57 -mtp=soft -fPIC -ftls-model=local-exec' \
    --extra-cxxflags='-D__SWITCH__ -D_GNU_SOURCE -O2 -march=armv8-a -mtune=cortex-a57 -mtp=soft -fPIC -ftls-model=local-exec' \
    --extra-ldflags='-fPIE -L${PORTLIBS_PREFIX}/lib -L${DEVKITPRO}/libnx/lib' \
    --disable-runtime-cpudetect --disable-programs --disable-debug --disable-doc \
    --enable-asm --enable-neon --disable-autodetect --enable-mbedtls --enable-version3 \
    --disable-avdevice --disable-encoders --disable-muxers \
    --enable-swscale --enable-swresample --enable-network --enable-libssh2 \
    --enable-zlib --enable-bzlib --enable-libass --enable-libdav1d --enable-nvtegra

  make -j$(nproc)
}

package() {
  cd "${_srcdir}"

  source /opt/devkitpro/switchvars.sh

  make DESTDIR="$pkgdir" install

  rm -r "$pkgdir"${PORTLIBS_PREFIX}/share
}
