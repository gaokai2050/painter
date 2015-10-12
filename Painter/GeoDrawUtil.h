//
//  GeoDrawUtil.h
//  Painter
//
//  Created by Michael Gao on 15/10/11.
//  Copyright © 2015年 1quuu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Line.h"

//返回表示无效点的CGPoint结构
CGPoint QUInvalidPoint();
//判断一个点是否不是无效点
BOOL QUIsValidPoint(CGPoint point);
//判断一个点是否是无效点
BOOL QUIsInvalidPoint(CGPoint point);
//判断两个浮点数是否相同（在一定误差范围内，目前误差是0.001）
BOOL QUIsSameFloat(CGFloat float1, CGFloat float2);
//判断两个点是否重合
BOOL QUIsSamePoint(CGPoint point1, CGPoint point2);
//求两个点沿着正交坐标系的方向，正方向返回1，反方向返回-1，同样位置返回0。
int QUDirection(CGFloat from, CGFloat to);
//判断一条直线上的三个点是否是同一个方向，即point2是否在point1和point3为顶点的矩形中
BOOL QUIsSameDirection(CGPoint point1, CGPoint point2, CGPoint point3);
//判断一个点是否在一个线段上
BOOL QUPointInLine(Line *line, CGPoint point, BOOL includeEndpoint);
//求两个线段的交点。
//如果两条线平行：
//    如果存在类似P1==P3并且P2->P1->P4是一个方向的情况，根据最后一个参数确定是返回重合的交点还是返回QUInvalidPoint
//    否则，返回QUInvalidPoint
//如果无交点，返回QUInvalidPoint
//返回交点
CGPoint QUSegmentIntersect(CGPoint point1, CGPoint point2, CGPoint point3, CGPoint point4, BOOL isParallelConnectValid);
//求两条直线的交点，交点可以不在给定四个点所代表的线段上。
//如果两条线平行：
//    如果存在类似P1==P3并且P2->P1->P4是一个方向的情况，根据最后一个参数确定是返回重合的交点还是返回QUInvalidPoint
//    否则，返回QUInvalidPoint
//如果无交点，返回QUInvalidPoint
//返回交点
CGPoint QULineIntersect(CGPoint point1, CGPoint point2, CGPoint point3, CGPoint point4, BOOL isParallelConnectValid);
//判断一个点是否在形状内
//最后一个参数的含义：如果point在polygon的边框（含端点）上，那么算Inside。
BOOL QUInsidePolygon(NSArray<NSValue*> *polygon, CGPoint point);
//给定一个没有洞的多边形和一条line，计算在该多边形内的Line数组，该Line数组是line被多边形边框切割形成的线段。
//返回值：
//    如果line都在/不在多边形内，返回数组包含了line本身；
//    如果部分在/不在多边形内，创建一个新的Line对象数组并返回；
//    如果line都不在/在多边形内，返回长度为0的数组。
NSArray* QUGetLineSegment(NSArray *polygon, Line *line, BOOL inside);

