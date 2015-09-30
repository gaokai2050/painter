//
//  PaperRef.h
//  Painter
//
//  Created by Michael Gao on 15/9/30.
//  Copyright © 2015年 1quuu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaperRef : NSObject

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* displayName;

-(id) initWithName:(NSString*)name displayName:(NSString*)displayName;

@end
