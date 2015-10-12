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

// 包含洞的多边形
@interface Polygon : NSObject

// 多边形外部边框的坐标，顺时针方向
// NSArray of NSValue(CGPoint)
@property (nonatomic, strong) NSArray *framePoints;

// 多边形内部的洞，每个洞是一个NSArray对象，包含了洞的边框的坐标，顺时针方向
// NSArray of NSArray of NSValue(CGPoint)
@property (nonatomic, strong) NSArray *holes;

-(id)initWithFrame:(NSArray*)framePoints holes:(NSArray*)holes;

//给定一条Line，计算在多边形内的Line。对于有洞的多边形，可能会切割成多条Line。
//如果line都在多边形内，返回line本身；如果部分在多边形内，创建一个新的Line对象并返回；如果line都不在多边形内，返回nil。
//NSArray of Line
-(NSArray*)getLineInside:(Line*)line;

//判断一个点是否在形状内。在边框上的点判定为在形状内，在洞的边框上的点判定为不在形状内。
-(BOOL)inside:(CGPoint)point;

@end
