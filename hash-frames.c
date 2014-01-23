#include <RSImg.h>
#include <RSUtil.h>
#include <ccity.h>
#include <stdlib.h>

int main() {
    uint32_t width, height, headerSize;
    uint32_t firstWidth, firstHeight, firstHeaderSize;
    if (!RSImgFreadPPMP6Header(stdin, &firstWidth, &firstHeight, &firstHeaderSize)) {
        RSFatalError("RSImgFreadPPMP6Header");
    }

    uint64_t hash;
    uint32_t pixelDataSize = firstWidth * firstHeight * 3;
    uint8_t *pixelData = RSMallocOrDie(pixelDataSize);

    RSFReadOrDie(pixelData, pixelDataSize, stdin);
    while (1) {
        hash = ccity_hash128_64(pixelData, pixelDataSize);
        RSFWriteOrDie(&hash, sizeof(uint64_t), stdout);

        if (!RSImgFreadPPMP6Header(stdin, &width, &height, &headerSize)) {
            break;
        }
        if ((width != firstWidth) || (height != firstHeight)) {
            RSFatalError("dimensions changed");
        }
        RSFReadOrDie(pixelData, pixelDataSize, stdin);
    }
    return 0;
}
