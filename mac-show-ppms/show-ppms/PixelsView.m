#import "PixelsView.h"
#import <RSUtil.h>

@interface PixelsView() {
    CGColorSpaceRef _colorSpace;
    CGDataProviderRef _provider;
    uint32_t _width;
    uint32_t _height;
    uint32_t _headerSize;
    uint8_t *_frameData;
}
@end

@implementation PixelsView

- (id)initWithFrame:(NSRect)frame
              width:(uint32_t)width
             height:(uint32_t)height
         headerSize:(uint32_t)headerSize
          frameData:(uint8_t *)frameData
{
    self = [super initWithFrame:frame];
    if (self) {
        _colorSpace = CGColorSpaceCreateDeviceRGB();
        _width = width;
        _height = height;
        _headerSize = headerSize;
        _frameData = frameData;
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    if (!_provider) {
        uint8_t *pixels = &(_frameData[_headerSize]);
        _provider = CGDataProviderCreateWithData(nil, pixels, _width * _height, nil);
    }
    CGContextRef c = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
    size_t bitsPerComponent = 8;
    size_t bitsPerPixel = 24;
    size_t bytesPerRow = _width * 3;
    CGImageRef image = CGImageCreate(
                                     _width, _height,
                                     bitsPerComponent, bitsPerPixel, bytesPerRow,
                                     _colorSpace,
                                     kCGBitmapByteOrderDefault,
                                     _provider,
                                     nil,
                                     NO,
                                     kCGRenderingIntentDefault);
    CGContextDrawImage(c, self.bounds, image);
    CGImageRelease(image);
}

@end
