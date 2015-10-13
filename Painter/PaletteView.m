//
//  PaletteView.m
//  Painter
//
//  Created by Michael Gao on 15/9/12.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import "PaletteView.h"

@interface PaletteView()
@property (nonatomic) CGImageRef backgroundImage;
@end

@implementation PaletteView

-(id)initWithCoder:(NSCoder *)c
{
    self = [super initWithCoder:c];
    if (self) {
        [self initPolygon];
        _backgroundColor = [UIColor whiteColor];
        _paletteColor = [UIColor grayColor];
        _userPickedColor = [UIColor blackColor];
        _linesCompleted = [[NSMutableArray alloc] init];
        [self setMultipleTouchEnabled:YES];
        [self becomeFirstResponder];
    }
    return self;
}
-(void)initPolygon
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"SketchPad" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    NSDictionary *palette = [dic objectForKey:@"Palette"];
    
    NSArray *framePointList = [palette objectForKey:@"Frame"];
    NSMutableArray *framePoints = [[NSMutableArray alloc] init];
    for (NSString *p in framePointList) {
        CGPoint point = CGPointFromString(p);
        [framePoints addObject:[NSValue valueWithCGPoint:point]];
    }
    Polygon *frame = [[Polygon alloc] initWithFrame:framePoints];
    
    NSArray *holeList = [palette objectForKey:@"Holes"];
    NSMutableArray *holes = [[NSMutableArray alloc] init];
    for (NSArray *h in holeList) {
        NSMutableArray *hole = [[NSMutableArray alloc] init];
        for (NSString *p in h) {
            CGPoint point = CGPointFromString(p);
            [hole addObject:[NSValue valueWithCGPoint:point]];
        }
        [holes addObject:[[Polygon alloc] initWithFrame:hole]];
    }
    NSArray *hole = [[NSArray alloc] initWithArray:holes];
    
    _palette = [[PolygonWithHoles alloc] initWithFrame:frame holes:hole];
}
-(void)dealloc
{
    if (_backgroundImage) {
        CGImageRelease(_backgroundImage);
    }
}
-(CGImageRef)backgroundImage
{
    if (!_backgroundImage) {
        UIImage* image = [UIImage imageNamed:@"palette.png"];
        _backgroundImage = image.CGImage;
    }
    return _backgroundImage;
}
-(void)colorSelected:(UIColor *)color {
    _userPickedColor = color;
}

-(void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //画调色板的边框
    //CGContextDrawImage(context, rect, self.backgroundImage);
    [self drawPolygon:_palette.frame inContext:context withColor:_paletteColor];
    for (Polygon* hole in _palette.holes) {
        [self drawPolygon:hole inContext:context withColor:_backgroundColor];
    }

    //画调色的笔墨
    CGContextBeginTransparencyLayer(context, NULL);
    CGContextSetBlendMode(context, kCGBlendModeMultiply);
    CGContextSetLineCap(context, kCGLineCapRound);
    for (LineInPalette *line in self.linesCompleted) {
        [line drawInContext:context withRect:rect];
    }
    CGContextEndTransparencyLayer(context);
}
-(void)drawPolygon:(Polygon*)polygon inContext:(CGContextRef)context withColor:(UIColor*)color
{
    CGContextSaveGState(context);
    [color set];
//    CGContextSetStrokeColorWithColor(context, color.CGColor);
//    CGContextSetFillColorWithColor(context, color.CGColor);
    CGPoint p1 = [polygon pointAtIndex:0];
    CGContextMoveToPoint(context, p1.x, p1.y);
    for (int i = 0; i < polygon.pointCount; i++) {
        CGPoint p2 = [polygon pointAtIndex:((i+1) % polygon.pointCount)];
        CGContextAddLineToPoint(context, p2.x, p2.y);
        p1 = p2;
    }
//    CGContextStrokePath(context);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.undoManager beginUndoGrouping];
    //Ignore multiple touch events.
    for (UITouch *t in touches) {
        // Create a line for the value
        CGPoint loc = [t locationInView:self];
        [self startNewLineAt:loc];
        break;
    }
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //Ignore multiple touch events.
    for (UITouch *t in touches) {
        CGPoint loc = [t locationInView:self];
        if (self.currentLine) {
            self.currentLine.end = loc;
            NSLog(@"Current Line end in touchesMoved, (%.1f,%.1f)-(%.1f,%.1f)", self.currentLine.start.x, self.currentLine.start.y, self.currentLine.end.x, self.currentLine.end.y);
            NSArray *lineInsideArray = [_palette getLines:self.currentLine inside:YES];
            NSLog(@"After getLineInside, get %d lines.", lineInsideArray.count);
            for (Line *lineInside in lineInsideArray) {
                NSLog(@"  ----(%.1f,%.1f)-(%.1f,%.1f)", lineInside.start.x, lineInside.start.y, lineInside.end.x, lineInside.end.y);
                if (lineInside == self.currentLine) {
                    [self addLine:self.currentLine];
                } else {
                    [self addLine:[[LineInPalette alloc] initWithLine:lineInside]];
                }
            }
        }
        [self startNewLineAt:loc];
        break;
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endTouches:touches];
    [self.undoManager endUndoGrouping];
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endTouches:touches];
}
-(void)startNewLineAt:(CGPoint)point
{
    LineInPalette *line = [[LineInPalette alloc] init];
    line.start = line.end = point;
    if (_userPickedColor) {
        line.color = _userPickedColor;
    }
    self.currentLine = line;
}
-(void)addLine:(LineInPalette*)line
{
    [[self.undoManager prepareWithInvocationTarget:self] removeLine:line];
    [self.linesCompleted addObject:line];
    [self setNeedsDisplay];
}
-(void)removeLine:(LineInPalette*)line
{
    if ([self.linesCompleted containsObject:line]) {
        [[self.undoManager prepareWithInvocationTarget:self] addLine:line];
        [self.linesCompleted removeObject:line];
        [self setNeedsDisplay];
    }
}
-(void)endTouches:(NSSet *)touches
{
    [self setNeedsDisplay];
}

@end
