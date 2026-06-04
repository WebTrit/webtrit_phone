# ── Stage 1: build pjsua with video support ──────────────────────────────────
FROM debian:trixie-slim AS pjsip-builder

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    git \
    pkg-config \
    libssl-dev \
    libopus-dev \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libswscale-dev \
    libasound2-dev \
    libsdl2-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build
RUN git clone --depth 1 https://github.com/pjsip/pjproject.git

WORKDIR /build/pjproject
# config_site.h is PJSIP's official override file; force-enable video + SDL device
RUN printf '#define PJMEDIA_HAS_VIDEO 1\n#define PJMEDIA_VIDEO_DEV_HAS_SDL 1\n' \
    > pjlib/include/pj/config_site.h
RUN ./configure && make dep && make && make install && \
    cp pjsip-apps/bin/pjsua-* /usr/local/bin/pjsua

# ── Stage 2: runtime image with Dart SDK ─────────────────────────────────────
FROM dart:stable

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    libssl3 \
    libopus0 \
    libavcodec61 \
    libavformat61 \
    libavutil59 \
    libswscale8 \
    libasound2t64 \
    libsdl2-2.0-0 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=pjsip-builder /usr/local/bin/pjsua /usr/local/bin/pjsua

# SDL_VIDEODRIVER=offscreen lets SDL (and pjsua video) run without a display
ENV SDL_VIDEODRIVER=offscreen

WORKDIR /app

# resolution: workspace is only valid inside a Melos workspace — strip it here
COPY pubspec.yaml ./
RUN sed -i '/^resolution:/d' pubspec.yaml && dart pub get

COPY bin/ bin/

EXPOSE 7788
CMD ["dart", "run", "bin/server.dart"]
