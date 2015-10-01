//
//  PenRef.m
//  Painter
//
//  Created by Michael Gao on 15/9/22.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import "PenRef.h"

@implementation PenRef

-(id) initWithName:(NSString*)name displayName:(NSString*)displayName image:(UIImage*)image alpha:(CGFloat)alpha
{
    self = [super init];
    if (self) {
        self.name = name;
        self.displayName = displayName;
        self.image = image;
        self.alpha = alpha;
    }
    return self;
}

-(id) initWithDict:(NSDictionary*)dict
{
    self = [super init];
    if (self) {
        self.name = [dict objectForKey:@"name"];
        self.displayName = [dict objectForKey:@"displayName"];
        self.image = [UIImage imageNamed:[dict objectForKey:@"image"]];
        self.alpha = [[dict objectForKey:@"alpha"] floatValue];
    }
    return self;
}

@end
