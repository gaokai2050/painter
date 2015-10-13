//
//  Polygon.h
//  Painter
//
//  Created by Michael Gao on 15/10/7.
//  Copyright © 2015年 1quuu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Line.h"
#import "GeoDrawUtil.h"

// 多边形
@interface Polygon : NSObject
// 多边形内部的洞，每个洞是一个NSArray对象，包含了洞的边框的坐标，顺时针方向
// NSArray of NSArray of NSValue(CGPoint)
//@property (nonatomic, strong) NSArray *holes;
//根据边框的坐标来初始化，边框包含多边形的所有顶点，按照顺时针顺序
// NSArray of NSValue(CGPoint)
-(id)initWithFrame:(NSArray*)frame;
//多边形的顶点数量
-(int)pointCount;
//多边形的第n个顶点，所有顶点按照顺时针顺序
-(CGPoint)pointAtIndex:(int)index;
//给定一条Line，计算在多边形内/外的Line，可能会切割成多条Line。
//NSArray of Line
-(NSArray*)getLines:(Line*)line inside:(BOOL)inside;
//判断一个点是否在形状内。在边框上的点判定为在形状内。
-(BOOL)pointInside:(CGPoint)point;
@end

//包含洞的多边形
@interface PolygonWithHoles : NSObject
// 多边形外部边框
@property (nonatomic, strong) Polygon *frame;
// 多边形内部的洞，每个洞是一个Polygon对象
// NSArray of Polygon
@property (nonatomic, strong) NSArray *holes;
// 根据边框和洞来初始化
-(id)initWithFrame:(Polygon*)frame holes:(NSArray*)holes;
//给定一条Line，计算在多边形内/外的Line，可能会切割成多条Line。
//NSArray of Line
-(NSArray*)getLines:(Line*)line inside:(BOOL)inside;
//判断一个点是否在形状内。在边框上的点判定为在形状内，在洞的边框上的点判定为不在形状内。
-(BOOL)pointInside:(CGPoint)point;
@end
