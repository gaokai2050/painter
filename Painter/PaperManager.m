//
//  PaperManager.m
//  Painter
//
//  Created by Michael Gao on 15/9/30.
//  Copyright © 2015年 1quuu. All rights reserved.
//

#import "PaperManager.h"

@implementation PaperManager

static PaperManager* instance;

+(PaperManager*)instance
{
    if (!instance) {
        instance = [[PaperManager alloc] init];
    }
    return instance;
}

-(id)init
{
    self = [super init];
    if (self) {
        PaperRef* p1 = [[PaperRef alloc] initWithName:@"default" displayName:@"Default"];
        _paper = [[NSArray alloc] initWithObjects:p1, nil];
    }
    return self;
}

@end
