//
//  CanvasView.m
//  Painter
//
//  Created by Michael Gao on 15/9/12.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import "CanvasView.h"
#import <Foundation/Foundation.h>

@implementation CanvasView

//  It is a method of UIView called every time the screen needs a redisplay or refresh.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetBlendMode(context, kCGBlendModeMultiply);
//    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineCap(context, kCGLineCapSquare);
    
    for (LineInCanvas *line in self.linesCompleted) {
        [line drawInContext:context withRect:rect];
    }
}

- (void)undo
{
    if ([self.undoManager canUndo]) {
        [self.undoManager undo];
    }
}
- (void)redo
{
    if ([self.undoManager canRedo]) {
        [self.undoManager redo];
    }
}

- (id)initWithCoder:(NSCoder *)c
{
    self = [super initWithCoder:c];
    if (self) {
        _linesCompleted = [[NSMutableArray alloc] init];
        [self setMultipleTouchEnabled:YES];
        [self becomeFirstResponder];
    }
    return self;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.undoManager beginUndoGrouping];
    //TODO: How to handle multiple touch events?
    for (UITouch *t in touches) {
        // Create a line for the value
        CGPoint loc = [t locationInView:self];
        CGFloat penAngle = 0; //TODO: Pen Angle
        CGFloat touchDepth = 1; //TODO: 3D Touch
        [self startNewLineAt:loc penAngle:penAngle touchDepth:touchDepth];
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //TODO: How to handle multiple touch events?
#warning 主任，多点触摸这里touches数组会有多个值，分别处理就可以了，现在好像会乱
    for (UITouch *t in touches) {
        CGPoint loc = [t locationInView:self];
        CGFloat penAngle = 0; //TODO: Pen Angle
        CGFloat touchDepth = 1; //TODO: 3D Touch
        
        if (self.currentLine) {
            self.currentLine.end = loc;
            [self addLine:self.currentLine];
        }
        [self startNewLineAt:loc penAngle:penAngle touchDepth:touchDepth];
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endTouches:touches];
    [self.undoManager endUndoGrouping];
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endTouches:touches];
}
- (void)startNewLineAt:(CGPoint)point penAngle:(CGFloat)penAngle touchDepth:(CGFloat)touchDepth
{
    LineInCanvas *line = [[LineInCanvas alloc] init];
    line.pen = self.pad.pen;
    line.start = line.end = point;
    line.color = self.pad.drawColor;
    line.penAngle = penAngle;
    line.touchDepth = touchDepth;
    self.currentLine = line;
}
- (void)addLine:(LineInCanvas*)line
{
    [[self.undoManager prepareWithInvocationTarget:self] removeLine:line];
    [self.linesCompleted addObject:line];
    [self setNeedsDisplay];
}
- (void)removeLine:(LineInCanvas*)line
{
    if ([self.linesCompleted containsObject:line]) {
        [[self.undoManager prepareWithInvocationTarget:self] addLine:line];
        [self.linesCompleted removeObject:line];
        [self setNeedsDisplay];
    }
}
- (void)removeLineByEndPoint:(CGPoint)point
{
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        Line *evaluatedLine = (Line*)evaluatedObject;
        return (evaluatedLine.end.x >= point.x - 1 && evaluatedLine.end.x < point.x + 1) &&
        (evaluatedLine.end.y >= point.y - 1 || evaluatedLine.end.y < point.y + 1);
    }];
    NSArray *result = [self.linesCompleted filteredArrayUsingPredicate:predicate];
    if (result && result.count > 0) {
        [self removeLine:result[0]];
    }
}
- (void)endTouches:(NSSet *)touches
{
    [self setNeedsDisplay];
}

@end
