//
//  Line.h
//  Painter
//
//  Created by Michael Gao on 15/10/7.
//  Copyright © 2015年 1quuu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GeoDrawUtil.h"

@interface Line : NSObject

@property (nonatomic) CGPoint start;
@property (nonatomic) CGPoint end;
@property (nonatomic, strong) UIColor *color;

-(id)initWithStart:(CGPoint)start end:(CGPoint)end color:(UIColor*)color;
-(id)initWithLine:(Line*)line;

//判断一个点是否在一个线段上
-(BOOL)pointInLine:(CGPoint)point includeEndpoint:(BOOL)includeEndpoint;

@end
