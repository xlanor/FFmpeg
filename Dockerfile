# Dockerfile for building switch-ffmpeg 8.0
# Uses devkitpro's devkita64 image for Nintendo Switch cross-compilation

FROM devkitpro/devkita64:latest

# Install required Switch portlibs dependencies
RUN dkp-pacman -Sy --noconfirm \
    switch-zlib \
    switch-bzip2 \
    switch-libass \
    switch-libfribidi \
    switch-freetype \
    switch-mbedtls \
    switch-dav1d \
    switch-libssh2 \
    switch-pkg-config \
    dkp-toolchain-vars

# Set working directory
WORKDIR /build/ffmpeg

# Copy the FFmpeg source (with patches already applied)
COPY . .

# Build script
RUN bash -c '\
    source /opt/devkitpro/switchvars.sh && \
    ./configure \
        --prefix=$PORTLIBS_PREFIX \
        --enable-gpl \
        --disable-shared \
        --enable-static \
        --cross-prefix=aarch64-none-elf- \
        --enable-cross-compile \
        --arch=aarch64 \
        --cpu=cortex-a57 \
        --target-os=horizon \
        --enable-pic \
        --extra-cflags="-D__SWITCH__ -D_GNU_SOURCE -O2 -march=armv8-a -mtune=cortex-a57 -mtp=soft -fPIC -ftls-model=local-exec" \
        --extra-cxxflags="-D__SWITCH__ -D_GNU_SOURCE -O2 -march=armv8-a -mtune=cortex-a57 -mtp=soft -fPIC -ftls-model=local-exec" \
        --extra-ldflags="-fPIE -L${PORTLIBS_PREFIX}/lib -L${DEVKITPRO}/libnx/lib" \
        --disable-runtime-cpudetect \
        --disable-programs \
        --disable-debug \
        --disable-doc \
        --enable-asm \
        --enable-neon \
        --disable-autodetect \
        --enable-libnx \
        --enable-version3 \
        --disable-avdevice \
        --disable-encoders \
        --disable-muxers \
        --enable-swscale \
        --enable-swresample \
        --enable-network \
        --enable-libssh2 \
        --enable-zlib \
        --enable-bzlib \
        --enable-libass \
        --enable-libdav1d \
        --enable-nvtegra && \
    make -j$(nproc)'

# The built libraries will be in the container
# To install to a volume or extract, use docker cp or mount a volume

CMD ["echo", "Build completed successfully! Use 'docker cp' to extract built libraries."]
