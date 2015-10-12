//
//  Line.h
//  Painter
//
//  Created by Michael Gao on 15/10/7.
//  Copyright © 2015年 1quuu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Line : NSObject

@property (nonatomic) CGPoint begin;
@property (nonatomic) CGPoint end;
@property (nonatomic, strong) UIColor *color;

-(id)initWithBegin:(CGPoint)begin end:(CGPoint)end color:(UIColor*)color;
-(id)initWithLine:(Line*)line;

@end
