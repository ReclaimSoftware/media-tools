#import <Cocoa/Cocoa.h>

@interface PixelsView : NSView

- (id)initWithFrame:(NSRect)frame
              width:(uint32_t)width
             height:(uint32_t)height
         headerSize:(uint32_t)headerSize
          frameData:(uint8_t *)frameData;

@end
