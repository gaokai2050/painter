//
//  Line.h
//  Painter
//
//  Created by Michael Gao on 15/9/13.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PenRef.h"

// Line 用来代表抽象的一笔，根据笔的不同，最后绘制的图形不一定是直线

@interface Line : NSObject

@property (nonatomic) CGPoint begin;
@property (nonatomic) CGPoint end;
@property (nonatomic, retain) UIColor *color;
@property (nonatomic, readonly) CGFloat width;
@property (nonatomic, strong) PenRef *pen;
@property (nonatomic) CGFloat penAngle;
@property (nonatomic) CGFloat touchDepth;

-(void)drawInContext:(CGContextRef)context withRect:(CGRect)rect;

@end
