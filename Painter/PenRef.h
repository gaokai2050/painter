//
//  PenRef.h
//  Painter
//
//  Created by Michael Gao on 15/9/22.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PenRef : NSObject

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* displayName;
@property (strong, nonatomic) UIImage* image; // Image used in PenPickerView
@property (nonatomic) CGFloat alpha;

//-(id) initWithName:(NSString*)name displayName:(NSString*)displayName image:(UIImage*)image alpha:(CGFloat)alpha;
-(id) initWithDict:(NSDictionary*)dict;

-(CGFloat)calculatePenWidth:(CGFloat)depth angle:(CGFloat)angle;

@end
