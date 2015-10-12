//
//  Polygon.m
//  Painter
//
//  Created by Michael Gao on 15/10/7.
//  Copyright © 2015年 1quuu. All rights reserved.
//

#import "Polygon.h"

@implementation Polygon

-(id)initWithFrame:(NSArray*)framePoints holes:(NSArray*)holes
{
    self = [super init];
    if (self) {
        _framePoints = framePoints;
        _holes = holes;
    }
    return self;
}

//给定一条Line，计算在多边形内的Line。
//如果line都在多边形内，返回line本身；如果部分在多边形内，创建一个新的Line对象并返回；如果line都不在多边形内，返回nil。
-(NSArray*)getLineInside:(Line*)line
{
    //计算和Frame的所有交点
    NSArray *la1 = QUGetLineSegment(_framePoints, line, YES);
    //将所有多边形内的线段和Hole相交，去掉Hole内部的线段
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (Line *l in la1) {
        NSMutableArray *t = [[NSMutableArray alloc] initWithObjects:l, nil];
        for (NSArray *h in _holes) {
            for (int index = 0; index < t.count; ) {
                NSArray *x = QUGetLineSegment(h, [t objectAtIndex:index], NO);
                [t removeObjectAtIndex:index];
                for (Line *ll in x) {
                    [t insertObject:ll atIndex:(index++)];
                }
            }
        }
        [result addObjectsFromArray:t];
    }
    return [[NSArray alloc] initWithArray:result];
}
//判断一个点是否在形状内。在边框上的点判定为在形状内，在洞的边框上的点判定为不在形状内。
-(BOOL)inside:(CGPoint)point
{
    if (QUInsidePolygon(_framePoints, point)) {
        for (NSArray *hole in _holes) {
            if (QUInsidePolygon(hole, point)) {
                return NO;
            }
        }
        return YES;
    }
    return NO;
}
@end
                    
