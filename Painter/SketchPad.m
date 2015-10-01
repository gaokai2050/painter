//
//  SketchPad.m
//  Painter
//
//  Created by Michael Gao on 15/9/22.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import "SketchPad.h"

@interface SketchPad()
@property (strong, nonatomic) UIColor *drawColor;
@end

@implementation SketchPad

@synthesize pen = _pen;

-(id) init
{
    self = [super init];
    if (self) {
        _pen = [[PenManager instance].pens objectAtIndex:0];
        _color = [UIColor blackColor];
    }
    return self;
}

-(PenRef*)pen
{
    if (!_pen) {
        // Make sure _pen is not nil;
        _pen = [[PenManager instance].pens objectAtIndex:0];
    }
    return _pen;
}
-(void)setPen:(PenRef*)pen
{
    _pen = pen;
    [self calculateDrawColor];
}
-(void)setColor:(UIColor *)color
{
    _color = color;
    [self calculateDrawColor];
}

-(void)calculateDrawColor
{
    if (_color) {
        self.drawColor = [_color colorWithAlphaComponent:self.pen.alpha];
    }
}
@end
