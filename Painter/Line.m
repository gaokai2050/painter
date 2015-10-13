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

-(id)initWithStart:(CGPoint)start end:(CGPoint)end color:(UIColor*)color
{
    self = [super init];
    if (self) {
        self.start = start;
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
            self.start = line.start;
            self.end = line.end;
            self.color = line.color;
        }
    }
    return self;
}

//判断一个点是否在一个线段上
-(BOOL)pointInLine:(CGPoint)point includeEndpoint:(BOOL)includeEndpoint
{
    //如果point和端点相同，根据includeEndpoint决定返回值
    if (QUIsSamePoint(self.start, point) || QUIsSamePoint(self.end, point)) {
        return includeEndpoint;
    }
    double x = (point.x - self.start.x) * (self.end.y - self.start.y) - (point.y - self.start.y) * (self.end.x - self.start.x);
    //如果两个向量不共线，返回NO。
    if (x > QU_INACCURACY_DELTA) {
        return NO;
    }
    //返回是否在线段内
    return QUIsSameDirection(self.start, point, self.end);
}

@end
