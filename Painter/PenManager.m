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
        PenRef* p1 = [[PenRef alloc] initWithName:@"crayon" displayName:@"Crayon" image:[UIImage imageNamed:@"crayon.jpg"]];
        PenRef* p2 = [[PenRef alloc] initWithName:@"paint" displayName:@"Paint" image:[UIImage imageNamed:@"paint-brush.jpg"]];
        PenRef* p3 = [[PenRef alloc] initWithName:@"water" displayName:@"Water" image:[UIImage imageNamed:@"water-color-paint-brush.jpg"]];
        _pens = [[NSArray alloc] initWithObjects:p1, p2, p3, nil];
    }
    return self;
}

@end
