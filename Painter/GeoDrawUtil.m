//
//  GeoDrawUtil.m
//  Painter
//
//  Created by Michael Gao on 15/10/11.
//  Copyright © 2015年 1quuu. All rights reserved.
//

#import "GeoDrawUtil.h"

#define QU_INACCURACY_DELTA        0.001
#define QU_INACCURACY_DELTA_SQUARE 0.00001
#define QU_MINUS_INFINITY          -10000

static CGPoint QU_INVALID_POINT_VALUE;

//返回表示无效点的CGPoint结构
CGPoint QUInvalidPoint()
{
    QU_INVALID_POINT_VALUE.x = QU_INVALID_POINT_VALUE.y = QU_MINUS_INFINITY;
    return QU_INVALID_POINT_VALUE;
}
//判断一个点是否不是无效点
BOOL QUIsValidPoint(CGPoint point)
{
    return point.x != QU_MINUS_INFINITY || point.y != QU_MINUS_INFINITY;
}
//判断一个点是否是无效点
BOOL QUIsInvalidPoint(CGPoint point)
{
    return point.x == QU_MINUS_INFINITY && point.y == QU_MINUS_INFINITY;
}
//判断两个浮点数是否相同（在一定误差范围内，目前误差是0.001）
BOOL QUIsSameFloat(CGFloat float1, CGFloat float2)
{
    return fabs(float1 - float2) < QU_INACCURACY_DELTA;
}
//判断两个点是否重合
BOOL QUIsSamePoint(CGPoint point1, CGPoint point2)
{
    return QUIsSameFloat(point1.x, point2.x) && QUIsSameFloat(point1.y, point2.y);
}
//求两个点沿着正交坐标系的方向，正方向返回1，反方向返回-1，同样位置返回0。
int QUDirection(CGFloat from, CGFloat to)
{
    return QUIsSameFloat(from, to) ? 0 : from < to ? 1 : -1;
}
//判断一条直线上的三个点是否是同一个方向，即point2是否在point1和point3为顶点的矩形中
BOOL QUIsSameDirection(CGPoint point1, CGPoint point2, CGPoint point3)
{
    return QUDirection(point1.x, point2.x) * QUDirection(point2.x, point3.x) >= 0 &&
        QUDirection(point1.y, point2.y) * QUDirection(point2.y, point3.y) >= 0;
}
//判断一个点是否在一个线段上
BOOL QUPointInLine(Line *line, CGPoint point, BOOL includeEndpoint)
{
    //如果point和端点相同，根据includeEndpoint决定返回值
    if (QUIsSamePoint(line.begin, point) || QUIsSamePoint(line.end, point)) {
        return includeEndpoint;
    }
    double x = (point.x - line.begin.x) * (line.end.y - line.begin.y) - (point.y - line.begin.y) * (line.end.x - line.begin.x);
    //如果两个向量不共线，返回NO。
    if (x > QU_INACCURACY_DELTA) {
        return NO;
    }
    //返回是否在线段内
    return QUIsSameDirection(line.begin, point, line.end);
}
//求两个线段的交点。
//如果两条线平行：
//    如果存在类似P1==P3并且P2->P1->P4是一个方向的情况，根据最后一个参数确定是返回重合的交点还是返回QUInvalidPoint
//    否则，返回QUInvalidPoint
//如果无交点，返回QUInvalidPoint
//返回交点
CGPoint QUSegmentIntersect(CGPoint point1, CGPoint point2, CGPoint point3, CGPoint point4, BOOL isParallelConnectValid)
{
    CGPoint p = QULineIntersect(point1, point2, point3, point4, isParallelConnectValid);
    if (!QUIsInvalidPoint(p) && QUIsSameDirection(point1, p, point2) && QUIsSameDirection(point3, p, point4)) {
        return p;
    } else {
        return QUInvalidPoint();
    }
}
//求两条直线的交点，交点可以不在给定四个点所代表的线段上。
//如果两条线平行：
//    如果存在类似P1==P3并且P2->P1->P4是一个方向的情况，根据最后一个参数确定是返回重合的交点还是返回QUInvalidPoint
//    否则，返回QUInvalidPoint
//如果无交点，返回QUInvalidPoint
//返回交点
CGPoint QULineIntersect(CGPoint point1, CGPoint point2, CGPoint point3, CGPoint point4, BOOL isParallelConnectValid)
{
    double xx = (point1.x - point2.x) * (point3.y - point4.y) - (point1.y - point2.y) * (point3.x - point4.x);
    if (fabs(xx) < QU_INACCURACY_DELTA_SQUARE) {
        // 平行或者重合
        if (isParallelConnectValid) {
            if ((QUIsSamePoint(point1, point3) && QUIsSameDirection(point2, point1, point4)) ||
                (QUIsSamePoint(point1, point4) && QUIsSameDirection(point2, point1, point3))) {
                return point1;
            }
            if ((QUIsSamePoint(point2, point3) && QUIsSameDirection(point1, point2, point4)) ||
                (QUIsSamePoint(point2, point4) && QUIsSameDirection(point1, point2, point3))) {
                return point2;
            }
        }
        return QUInvalidPoint();
    }
    //k是焦点在line上的比例
    double k = ((point2.y - point4.y) * (point3.x - point4.x) - (point2.x - point4.x) * (point3.y - point4.y)) / xx;
    if (k >= 0 && k <= 1) {
        double x = point2.x + (point1.x - point2.x) * k;
        double y = point2.y + (point1.y - point2.y) * k;
        return CGPointMake(x, y);
    } else {
        return QUInvalidPoint();
    }
}
//判断一个点是否在形状内
//最后一个参数的含义：如果point在polygon的边框（含端点）上，那么算Inside。
BOOL QUInsidePolygon(NSArray<NSValue*> *polygon, CGPoint point)
{
    int count = 0;
    CGPoint p0 = CGPointMake(QU_MINUS_INFINITY, point.y);
    for (int i = 0; i < polygon.count; i++) {
        CGPoint p1 = [[polygon objectAtIndex:i] CGPointValue];
        CGPoint p2 = [[polygon objectAtIndex:(i + 1) % polygon.count] CGPointValue];
        Line *l = [[Line alloc] initWithBegin:p1 end:p2 color:nil];
        if (QUPointInLine(l, point, YES)) {
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
//给定一个没有洞的多边形和一条line，计算在该多边形内的Line数组，该Line数组是line被多边形边框切割形成的线段。
//返回值：
//    如果line都在/不在多边形内，返回数组包含了line本身；
//    如果部分在/不在多边形内，创建一个新的Line对象数组并返回；
//    如果line都不在/在多边形内，返回长度为0的数组。
NSArray* QUGetLineSegment(NSArray *polygon, Line *line, BOOL inside)
{
    //计算和polygon所有Frame线段的所有交点
    NSMutableArray *intersects = [[NSMutableArray alloc] init];
    for (int i = 0; i < polygon.count; i++) {
        CGPoint p1 = [[polygon objectAtIndex:i] CGPointValue];
        CGPoint p2 = [[polygon objectAtIndex:(i + 1) % polygon.count] CGPointValue];
        CGPoint intersect = QUSegmentIntersect(line.begin, line.end, p1, p2, NO);
        if (QUIsValidPoint(intersect)) {
            if (!QUIsSamePoint(intersect, line.begin) && !QUIsSamePoint(intersect, line.end)) {
                [intersects addObject:[NSValue valueWithCGPoint:intersect]];
            }
        }
    }
    //排序所有的交点，根据端点是否在形状内来确定哪些线段是在多边形内的
    int dirX = QUDirection(line.begin.x, line.end.x);
    int dirY = QUDirection(line.begin.y, line.end.y);
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
    CGPoint mid = CGPointMake((line.begin.x + p0.x) / 2, (line.begin.y + p0.y) / 2);
    BOOL lineBeginInside = QUInsidePolygon(polygon, mid);
    if (inside == lineBeginInside) {
        [sortedIntersectsMutable insertObject:[NSValue valueWithCGPoint:line.begin] atIndex:0];
    }
    //返回形状内的线段
    NSMutableArray *frameSegments = [[NSMutableArray alloc] init];
    for (int index = 0; index + 1 < sortedIntersectsMutable.count; index += 2) {
        CGPoint p1 = [[sortedIntersectsMutable objectAtIndex:index] CGPointValue];
        CGPoint p2 = [[sortedIntersectsMutable objectAtIndex:index + 1] CGPointValue];
        //TODO: 判断是否是line本身，并且返回本身。
        Line *l = [[Line alloc] initWithBegin:p1 end:p2 color:line.color];
        [frameSegments addObject:l];
    }
    return [[NSArray alloc] initWithArray:frameSegments];
}
