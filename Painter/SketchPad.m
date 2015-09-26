//
//  SketchPad.m
//  Painter
//
//  Created by Michael Gao on 15/9/22.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import "SketchPad.h"

@implementation SketchPad

-(id) init
{
    self = [super init];
    if (self) {
        _pen = [[PenManager instance].pens objectAtIndex:0];
        _color = [UIColor blackColor];
    }
    return self;
}

@end
