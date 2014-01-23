mkdir -p build

CCITY="upstream/ccityhash"
CCITY_ARGS="-isystem $CCITY/include $CCITY/build/ccity.a"

RSIMG="upstream/RSImg"
RSIMG_ARGS="-isystem $RSIMG $RSIMG/RSImg.c"

RSUTIL="upstream/RSUtil"
RSUTIL_ARGS="-isystem $RSUTIL $RSUTIL/RSUtil.c"

ARGS="-std=c99 -O3 -Wall $CCITY_ARGS $RSIMG_ARGS $RSUTIL_ARGS"

cd $CCITY && \
    bash build.sh && \
    cd ../.. && \
    $CC $ARGS -o build/hash-frames hash-frames.c
