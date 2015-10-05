//
//  PenRef.m
//  Painter
//
//  Created by Michael Gao on 15/9/22.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import "PenRef.h"

typedef CGFloat (*PenWidthCalculator)(PenRef* pen, CGFloat depth, CGFloat angle);

@interface PenRef()

@property (nonatomic) CGFloat minWidth;
@property (nonatomic) CGFloat maxWidth;
@property (nonatomic) CGFloat widthParam0;
@property (nonatomic) CGFloat widthParam1;
@property (nonatomic) CGFloat widthParam2;
@property (nonatomic) PenWidthCalculator widthSelector;

@end

CGFloat penWidthSelectorSame(PenRef* pen, CGFloat depth, CGFloat angle)
{
    // 蜡笔之类的硬质圆柱形笔，无论深浅，笔的宽度是一样的。
    return pen.minWidth;
}

CGFloat penWidthSelectorAngle(PenRef* pen, CGFloat depth, CGFloat angle)
{
    // 油画笔之类的长方形笔头，根据和水平坐标的角度决定比的宽度。
    return (pen.minWidth + pen.maxWidth) / 2 * sin(angle);
}

CGFloat penWidthSelectorRatio(PenRef* pen, CGFloat depth, CGFloat angle)
{
    // 毛笔之类的圆锥体笔头，根据深度不同，笔宽按比例计算。
    // widthParameter0 是比例参数，即“笔头的半径 / 笔头的高度”
    CGFloat w = depth * pen.widthParam0;
    return w >= pen.minWidth ? w : pen.minWidth;
}

@implementation PenRef

//-(id) initWithName:(NSString*)name displayName:(NSString*)displayName image:(UIImage*)image alpha:(CGFloat)alpha
//{
//    self = [super init];
//    if (self) {
//        self.name = name;
//        self.displayName = displayName;
//        self.image = image;
//        self.alpha = alpha;
//    }
//    return self;
//}

-(id) initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        self.name = [dict objectForKey:@"name"];
        self.displayName = [dict objectForKey:@"displayName"];
        self.image = [UIImage imageNamed:[dict objectForKey:@"image"]];
        self.alpha = [[dict objectForKey:@"alpha"] floatValue];
        self.minWidth = [[dict objectForKey:@"minWidth"] floatValue];
        self.maxWidth = [[dict objectForKey:@"maxWidth"] floatValue];
        self.widthParam0 = [[dict objectForKey:@"widthParam0"] floatValue];
        self.widthParam1 = [[dict objectForKey:@"widthParam1"] floatValue];
        self.widthParam2 = [[dict objectForKey:@"widthParam2"] floatValue];
        NSString *widthSelector = [dict objectForKey:@"widthSelector"];
        if (!widthSelector) {
            self.widthSelector = penWidthSelectorSame;
        } else if ([widthSelector isEqualToString:@"angle"]) {
            self.widthSelector = penWidthSelectorAngle;
        } else if ([widthSelector isEqualToString:@"ratio"]) {
            self.widthSelector = penWidthSelectorRatio;
        } else {
            self.widthSelector = penWidthSelectorSame;
        }
    }
    return self;
}

-(CGFloat)calculatePenWidth:(CGFloat)depth angle:(CGFloat)angle
{
    if (self.widthSelector) {
        return self.widthSelector(self, depth, angle);
    } else {
        return self.minWidth;
    }
}


@end
