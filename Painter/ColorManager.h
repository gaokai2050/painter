//
//  ColorManager.h
//  Painter
//
//  Created by Michael Gao on 15/10/1.
//  Copyright © 2015年 1quuu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ColorManager : NSObject

+(ColorManager*)instance;

@property (strong, nonatomic, readonly) NSArray* color;

@end
