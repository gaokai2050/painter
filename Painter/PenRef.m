//
//  PenRef.m
//  Painter
//
//  Created by Michael Gao on 15/9/22.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import "PenRef.h"

@implementation PenRef

-(id) initWithName:(NSString*)name displayName:(NSString*)displayName image:(UIImage*)image
{
    self = [super init];
    if (self) {
        self.name = name;
        self.displayName = displayName;
        self.image = image;
    }
    return self;
}

@end
