//
//  PenManager.h
//  Painter
//
//  Created by Michael Gao on 15/9/22.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PenRef.h"

@interface PenManager : NSObject

+(PenManager*)instance;

@property (strong, nonatomic, readonly) NSArray *pens;

@end
