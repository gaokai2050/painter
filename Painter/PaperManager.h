//
//  PaperManager.h
//  Painter
//
//  Created by Michael Gao on 15/9/30.
//  Copyright © 2015年 1quuu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PaperRef.h"

@interface PaperManager : NSObject

+(PaperManager*)instance;

@property (strong, nonatomic, readonly) NSArray* paper;

@end
