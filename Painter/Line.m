//
//  Line.m
//  Painter
//
//  Created by Michael Gao on 15/9/13.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import "Line.h"

@implementation Line

@synthesize begin, end, color;

- (id)init
{
    self = [super init];
    if (self) {
        [self setColor:[UIColor blackColor]];
    }
    return self;
}

@end
