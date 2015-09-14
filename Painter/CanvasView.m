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
    
    CGContextSetLineWidth(context, 5.0);
    CGContextSetLineCap(context, kCGLineCapRound);
    for (Line *line in self.linesCompleted) {
        [[line color] set];
        CGContextMoveToPoint(context, [line begin].x, [line begin].y);
        CGContextAddLineToPoint(context, [line end].x, [line end].y);
        CGContextStrokePath(context);
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
        
        _drawColor = [UIColor blackColor];
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
        Line *newLine = [[Line alloc] init];
        [newLine setBegin:loc];
        [newLine setEnd:loc];
        [newLine setColor:_drawColor];
        _currentLine = newLine;
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //TODO: How to handle multiple touch events?
    for (UITouch *t in touches) {
        [self.currentLine setColor:_drawColor];
        CGPoint loc = [t locationInView:self];
        [self.currentLine setEnd:loc];
            
        if (self.currentLine) {
            [self addLine:self.currentLine];
        }
        Line *newLine = [[Line alloc] init];
        [newLine setBegin:loc];
        [newLine setEnd:loc];
        [newLine setColor:_drawColor];
        self.currentLine = newLine;
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

- (void)addLine:(Line*)line
{
    [[self.undoManager prepareWithInvocationTarget:self] removeLine:line];
    [self.linesCompleted addObject:line];
    [self setNeedsDisplay];
}
- (void)removeLine:(Line*)line
{
    if ([self.linesCompleted containsObject:line]) {
        [[self.undoManager prepareWithInvocationTarget:self] addLine:line];
        [self.linesCompleted removeObject:line];
        [self setNeedsDisplay];
    }
}
//TODO: What's this?
- (void)removeLineByEndPoint:(CGPoint)point
{
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        Line *evaluatedLine = (Line*)evaluatedObject;
        //        return (evaluatedLine.end.x == point.x && evaluatedLine.end.y == point.y) ||
        //               (evaluatedLine.end.x == point.x - 1.0f && evaluatedLine.end.y == point.y - 1.0f) ||
        //               (evaluatedLine.end.x == point.x + 1.0f && evaluatedLine.end.y == point.y + 1.0f);
        return (evaluatedLine.end.x <= point.x-1 || evaluatedLine.end.x > point.x+1) &&
        (evaluatedLine.end.y <= point.y-1 || evaluatedLine.end.y > point.y+1);
    }];
    NSArray *result = [self.linesCompleted filteredArrayUsingPredicate:predicate];
    if (result && result.count > 0) {
        [self.linesCompleted removeObject:result[0]];
    }
}
- (void)endTouches:(NSSet *)touches
{
    [self setNeedsDisplay];
}

@end
