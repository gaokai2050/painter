//
//  Line.m
//  Painter
//
//  Created by Michael Gao on 15/9/13.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import <Math.h>
#import "Line.h"

@interface Line()
@property (nonatomic) BOOL widthCalculated;
@end

@implementation Line

@synthesize width = _width;

- (id)init
{
    self = [super init];
    if (self) {
        self.widthCalculated = NO;
        self.color = [UIColor blackColor];
        _width = 5.0;
    }
    return self;
}

-(void)drawInContext:(CGContextRef)context withRect:(CGRect)rect
{
    [self.color set];
    CGContextSetLineWidth(context, self.width);
    CGContextMoveToPoint(context, self.begin.x, self.begin.y);
    CGContextAddLineToPoint(context, self.end.x, self.end.y);
    CGContextStrokePath(context);
}

-(CGFloat)width
{
    if (!self.widthCalculated && self.pen) {
        // 根据不同的笔，计算笔画的宽度
        double deltaX = self.end.x - self.begin.x, deltaY = self.end.y - self.begin.y;
        double l = hypot(fabs(deltaX), fabs(deltaY));
        if (l > 1.4) {
            double a = asin((self.end.y - self.begin.y) / l);
            _width = [self.pen calculatePenWidth:self.touchDepth angle:a];
            self.widthCalculated = YES;
        }
    }
    return _width;
}

@end
