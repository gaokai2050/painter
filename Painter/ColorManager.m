//
//  ColorManager.m
//  Painter
//
//  Created by Michael Gao on 15/10/1.
//  Copyright © 2015年 1quuu. All rights reserved.
//

#import "ColorManager.h"

@implementation ColorManager

static ColorManager* instance;

+(ColorManager*)instance
{
    if (!instance) {
        instance = [[ColorManager alloc] init];
    }
    return instance;
}

-(id)init
{
    self = [super init];
    if (self) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"SketchPad" ofType:@"plist"];
        NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        NSArray *colorList = [dic objectForKey:@"ColorList"];
        NSMutableArray *color = [[NSMutableArray alloc] init];
        
        [colorList enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop) {
            NSDictionary *colorDict = obj;
            CGFloat r = [[colorDict objectForKey:@"r"] floatValue];
            CGFloat g = [[colorDict objectForKey:@"g"] floatValue];
            CGFloat b = [[colorDict objectForKey:@"b"] floatValue];
            UIColor *c = [[UIColor alloc] initWithRed:r green:g blue:b alpha:1.0];
            [color addObject:c];
        }];
        
        _color = [[NSArray alloc] initWithArray:color];
    }
    return self;
}

@end
