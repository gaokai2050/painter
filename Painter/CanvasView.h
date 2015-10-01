//
//  CanvasView.h
//  Painter
//
//  Created by Michael Gao on 15/9/12.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Line.h"
#import "SketchPad.h"
#import "PenRef.h"

@interface CanvasView : UIView

@property (strong, nonatomic) Line *currentLine;
@property (strong, nonatomic) NSMutableArray *linesCompleted;
//@property (strong, nonatomic) UIColor *drawColor;
//@property (strong, nonatomic) PenRef *pen;

@property (strong, nonatomic) SketchPad *pad;

@end
