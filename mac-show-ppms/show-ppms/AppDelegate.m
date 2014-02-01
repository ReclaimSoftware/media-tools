#import "AppDelegate.h"
#import "PixelsView.h"
#import <RSImg.h>
#import <RSUtil.h>

@interface AppDelegate () {
    FILE *_file;
    uint8_t *_frameData;
    uint32_t _frameDataSize;
    uint32_t _width;
    uint32_t _height;
    uint32_t _headerSize;
}
@property (strong) NSWindow *window;
@property (strong) PixelsView *pixelsView;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    _file = stdin;
    [self readFirstFrame];
    [self createUI];
    [NSTimer scheduledTimerWithTimeInterval:0
                                     target:self
                                   selector:@selector(next)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)next {
    if (fread(_frameData, _frameDataSize, 1, _file) != 1) {
        exit(0);
    }
    self.pixelsView.needsDisplay = YES;
}

- (void)readFirstFrame {
    if (!RSImgFreadPPMP6Header(_file, &_width, &_height, &_headerSize)) {
        RSFatalError("couldn't read first frame");
    }
    uint32_t rgbPixelsSize = _width * _height * 3;
    _frameDataSize = _headerSize + rgbPixelsSize;
    _frameData = RSMallocOrDie(_frameDataSize);
    uint8_t *rgbPixels = &(_frameData[_headerSize]);
    RSFReadOrDie(rgbPixels, rgbPixelsSize, _file);
}

- (void)createUI {
    NSScreen *screen = [NSScreen mainScreen];
    self.window = [[NSWindow alloc] initWithContentRect:CGRectMake(0, screen.frame.size.height, _width, _height)
                                              styleMask:NSTitledWindowMask
                                                backing:NSBackingStoreBuffered
                                                  defer:NO
                                                 screen:screen];
    NSView *contentView = self.window.contentView;
    self.pixelsView = [[PixelsView alloc] initWithFrame:contentView.bounds
                                                  width:_width
                                                 height:_height
                                             headerSize:_headerSize
                                              frameData:_frameData];
    [contentView addSubview:self.pixelsView];
    [self.window makeKeyAndOrderFront:nil];
}

@end
