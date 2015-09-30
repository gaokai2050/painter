//
//  PaperRef.m
//  Painter
//
//  Created by Michael Gao on 15/9/30.
//  Copyright © 2015年 1quuu. All rights reserved.
//

#import "PaperRef.h"

@implementation PaperRef

-(id) initWithName:(NSString*)name displayName:(NSString*)displayName
{
    self = [super init];
    if (self) {
        self.name = name;
        self.displayName = displayName;
    }
    return self;
}

@end
