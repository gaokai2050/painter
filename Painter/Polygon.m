//
//  Polygon.m
//  Painter
//
//  Created by Michael Gao on 15/10/7.
//  Copyright © 2015年 1quuu. All rights reserved.
//

#import "Polygon.h"

@interface Polygon()
// 多边形外部边框的坐标，顺时针方向
// NSArray of NSValue(CGPoint)
@property (nonatomic, strong) NSArray *framePoints;
@end

@implementation Polygon

-(id)initWithFrame:(NSArray*)frame
{
    self = [super init];
    if (self) {
        _framePoints = [[NSArray alloc] initWithArray:frame];
    }
    return self;
}
//多边形的顶点数量
-(int)pointCount
{
    return _framePoints.count;
}
//多边形的第n个顶点，所有顶点按照顺时针顺序
-(CGPoint)pointAtIndex:(int)index
{
    return [[_framePoints objectAtIndex:index] CGPointValue];
}

//给定一条Line，计算在多边形内/外的Line，可能会切割成多条Line。
//NSArray of Line
-(NSArray*)getLines:(Line*)line inside:(BOOL)inside
{
    //计算和polygon所有Frame线段的所有交点
    NSMutableArray *intersects = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.pointCount; i++) {
        CGPoint p1 = [self pointAtIndex:i];
        CGPoint p2 = [self pointAtIndex:(i + 1) % self.pointCount];
        CGPoint intersect = QUSegmentIntersect(line.start, line.end, p1, p2, NO);
        if (QUIsValidPoint(intersect)) {
            if (!QUIsSamePoint(intersect, line.start) && !QUIsSamePoint(intersect, line.end)) {
                [intersects addObject:[NSValue valueWithCGPoint:intersect]];
            }
        }
    }
    //排序所有的交点，根据端点是否在形状内来确定哪些线段是在多边形内的
    int dirX = QUDirection(line.start.x, line.end.x);
    int dirY = QUDirection(line.start.y, line.end.y);
    NSArray *sortedIntersects = [intersects sortedArrayUsingComparator:^(id obj1, id obj2) {
        CGPoint p1 = [(NSValue*)obj1 CGPointValue];
        CGPoint p2 = [(NSValue*)obj2 CGPointValue];
        int dx = QUDirection(p1.x, p2.x);
        int dy = QUDirection(p1.y, p2.y);
        
        if (dx != 0) {
            return dx * dirX > 0 ? NSOrderedAscending : NSOrderedDescending;
        } else if (dy != 0) {
            return dy * dirY > 0 ? NSOrderedAscending : NSOrderedDescending;
        } else {
            return NSOrderedSame;
        }
    }];
    NSMutableArray *sortedIntersectsMutable = [sortedIntersects mutableCopy];
    [sortedIntersectsMutable addObject:[NSValue valueWithCGPoint:line.end]];
    //计算line.begin和[sortedIntersectsMutable objectAtIndex:0]的中点，根据中点决定是否需要加入line.begin。
    CGPoint p0 = [[sortedIntersectsMutable objectAtIndex:0] CGPointValue];
    CGPoint mid = CGPointMake((line.start.x + p0.x) / 2, (line.start.y + p0.y) / 2);
    BOOL lineBeginInside = [self pointInside:mid];
    if (inside == lineBeginInside) {
        [sortedIntersectsMutable insertObject:[NSValue valueWithCGPoint:line.start] atIndex:0];
    }
    //返回形状内的线段
    NSMutableArray *frameSegments = [[NSMutableArray alloc] init];
    for (int index = 0; index + 1 < sortedIntersectsMutable.count; index += 2) {
        CGPoint p1 = [[sortedIntersectsMutable objectAtIndex:index] CGPointValue];
        CGPoint p2 = [[sortedIntersectsMutable objectAtIndex:index + 1] CGPointValue];
        //TODO: 判断是否是line本身，并且返回本身。
        Line *l = [[Line alloc] initWithStart:p1 end:p2 color:line.color];
        [frameSegments addObject:l];
    }
    return [[NSArray alloc] initWithArray:frameSegments];
}
//判断一个点是否在形状内。在边框上的点判定为在形状内。
-(BOOL)pointInside:(CGPoint)point
{
    int count = 0;
    CGPoint p0 = CGPointMake(QU_MINUS_INFINITY, point.y);
    for (int i = 0; i < self.pointCount; i++) {
        CGPoint p1 = [self pointAtIndex:i];
        CGPoint p2 = [self pointAtIndex:(i + 1) % self.pointCount];
        Line *l = [[Line alloc] initWithStart:p1 end:p2 color:nil];
        if ([l pointInLine:point includeEndpoint:YES]) {
            return YES;
        }
        //判断p1/p2是否是平行线
        if (!QUIsSameFloat(p1.y, p2.y)) {
            if ((QUIsSameFloat(p1.y, point.y) && (p1.y < p2.y)) ||
                (QUIsSameFloat(p2.y, point.y) && (p2.y < p1.y))) {
                //对于正好穿过顶点的情况，只计算y坐标小的那个。
                count++;
            } else {
                CGPoint intersect = QUSegmentIntersect(p1, p2, point, p0, NO);
                if (QUIsValidPoint(intersect)) {
                    count++;
                }
            }
        }
    }
    return count % 2 == 1;
}
@end
                    
@implementation PolygonWithHoles

-(id)initWithFrame:(Polygon*)frame holes:(NSArray*)holes
{
    self = [super init];
    if (self) {
        _frame = frame;
        _holes = holes;
    }
    return self;
}
//给定一条Line，计算在多边形内/外的Line，可能会切割成多条Line。
//NSArray of Line
-(NSArray*)getLines:(Line*)line inside:(BOOL)inside
{
    //计算和Frame的所有交点
    NSArray *la1 = [_frame getLines:line inside:YES];
    //将所有多边形内的线段和Hole相交，去掉Hole内部的线段
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (Line *l in la1) {
        NSMutableArray *t = [[NSMutableArray alloc] initWithObjects:l, nil];
        for (Polygon *h in _holes) {
            for (int index = 0; index < t.count; ) {
                NSArray *x = [h getLines:[t objectAtIndex:index] inside:NO];
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
-(BOOL)pointInside:(CGPoint)point
{
    if ([_frame pointInside:point]) {
        for (Polygon *hole in _holes) {
            if ([hole pointInside:point]) {
                return NO;
            }
        }
        return YES;
    }
    return NO;
}

@end
