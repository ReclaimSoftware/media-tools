**Some command-line tools for media**


### Tool: hash-frames

`PPM-list` &rarr; `hash64(RGB frame pixels)-list`, e.g. for "trust-but-verify" frame accuracy for extracting clips.

    cat foo.mp4 | \
      ffmpeg -loglevel warning -i - -f image2pipe -c ppm - \
      hash-frames > foo.mp4.hashes

The current hash function is [cityhash](https://en.wikipedia.org/wiki/CityHash) (64-bit).


### License: TBD
