//
//  SketchPad.h
//  Painter
//
//  Created by Michael Gao on 15/9/22.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PenRef.h"
#import "PenManager.h"

@interface SketchPad : NSObject

@property (strong, nonatomic) PenRef* pen;
@property (strong, nonatomic) UIColor* color;

@end
