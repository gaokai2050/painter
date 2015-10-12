//
//  Line.m
//  Painter
//
//  Created by Michael Gao on 15/10/7.
//  Copyright © 2015年 1quuu. All rights reserved.
//

#import "Line.h"

@implementation Line

- (id)init
{
    self = [super init];
    if (self) {
        self.color = [UIColor blackColor];
    }
    return self;
}

-(id)initWithBegin:(CGPoint)begin end:(CGPoint)end color:(UIColor*)color
{
    self = [super init];
    if (self) {
        self.begin = begin;
        self.end = end;
        self.color = color ? color : [UIColor blackColor];
    }
    return self;
}

-(id)initWithLine:(Line*)line
{
    self = [super init];
    if (self) {
        if (line) {
            self.begin = line.begin;
            self.end = line.end;
            self.color = line.color;
        }
    }
    return self;
}

@end
