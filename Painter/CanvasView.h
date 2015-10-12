//
//  CanvasView.h
//  Painter
//
//  Created by Michael Gao on 15/9/12.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineInCanvas.h"
#import "SketchPad.h"
#import "PenRef.h"

@interface CanvasView : UIView

@property (strong, nonatomic) SketchPad *pad;
@property (strong, nonatomic) LineInCanvas *currentLine;
@property (strong, nonatomic) NSMutableArray *linesCompleted;

@end
