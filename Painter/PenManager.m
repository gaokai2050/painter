//
//  PenManager.m
//  Painter
//
//  Created by Michael Gao on 15/9/22.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import "PenManager.h"
#import <UIKit/UIKit.h>

@implementation PenManager

static PenManager* instance;

+(PenManager*)instance
{
    if (!instance) {
        instance = [[PenManager alloc] init];
    }
    return instance;
}

-(id)init
{
    self = [super init];
    if (self) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"SketchPad" ofType:@"plist"];
        NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        NSArray *penList = [dic objectForKey:@"PenRefList"];
        NSMutableArray *pens = [[NSMutableArray alloc] init];
        
        for (NSDictionary *penRefDict in penList) {
            PenRef *pen = [[PenRef alloc] initWithDict:penRefDict];
            [pens addObject:pen];
        }

        _pens = [[NSArray alloc] initWithArray:pens];
    }
    return self;
}

@end
