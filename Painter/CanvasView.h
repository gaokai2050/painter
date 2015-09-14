//
//  CanvasView.h
//  Painter
//
//  Created by Michael Gao on 15/9/12.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Line.h"

@interface CanvasView : UIView

@property (nonatomic) Line *currentLine;
@property (nonatomic) NSMutableArray *linesCompleted;
@property (nonatomic) UIColor *drawColor;

@end
