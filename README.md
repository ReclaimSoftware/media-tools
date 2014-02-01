**Some command-line tools for media**

[![Build Status](https://secure.travis-ci.org/ReclaimSoftware/media-tools.png)](http://travis-ci.org/ReclaimSoftware/media-tools)


### hash-frames

`PPM-list` &rarr; `hash64(RGB frame pixels)-list`, e.g. for "trust-but-verify" frame accuracy for extracting clips.

    cat foo.mp4 | \
      ffmpeg -loglevel warning -i - -f image2pipe -c ppm - | \
      hash-frames > foo.mp4.hashes

The current hash function is [cityhash](https://en.wikipedia.org/wiki/CityHash) (64-bit).


### show-ppms (Mac)

    cd mac-show-ppms && \
      xcodebuild && \
      cat foo.mp4 | \
        ffmpeg -loglevel warning -i - -f image2pipe -c ppm - | \
        ./build/Release/show-ppms.app/Contents/MacOS/show-ppms

The current implementation plays frames as quickly as it can, which is approximately the right speed for my use case.

TODO: improve performance, take `--fps=` argument.


### License: TBD
