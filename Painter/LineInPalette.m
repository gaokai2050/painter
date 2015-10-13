//
//  LineInPalette.m
//  Painter
//
//  Created by Michael Gao on 15/9/13.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import <Math.h>
#import "LineInPalette.h"

@implementation LineInPalette

-(void)drawInContext:(CGContextRef)context withRect:(CGRect)rect
{
    [self.color set];
    CGContextSetLineWidth(context, 15.0);
    CGContextMoveToPoint(context, self.start.x, self.start.y);
    CGContextAddLineToPoint(context, self.end.x, self.end.y);
    CGContextStrokePath(context);
}

@end
