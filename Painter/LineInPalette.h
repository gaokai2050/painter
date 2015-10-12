//
//  LineInPalette.h
//  Painter
//
//  Created by Michael Gao on 15/9/13.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Line.h"

@interface LineInPalette : Line

-(void)drawInContext:(CGContextRef)context withRect:(CGRect)rect;

@end
