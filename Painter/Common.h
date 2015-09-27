//
//  Common.h
//  Painter
//
//  Created by Michael Gao on 15/9/26.
//  Copyright © 2015年 1quuu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NSLOG_FRAME(prefix, frame) NSLog(@"%@ : %.1f,%.1f-%.1f,%.1f", prefix, (frame).origin.x, (frame).origin.y, (frame).size.width, (frame).size.height)

@interface Common : NSObject

@end
