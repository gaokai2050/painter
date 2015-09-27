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

- (id)initWithCoder:(NSCoder *)c
{
    self = [super initWithCoder:c];
    if (self) {
        _userPickedColor = [UIColor blackColor];
    }
    return self;
}
- (void)dealloc
{
    if (_backgroundImage) {
        CGImageRelease(_backgroundImage);
    }
}
- (CGImageRef)backgroundImage
{
    if (!_backgroundImage) {
        UIImage* image = [UIImage imageNamed:@"palette.png"];
        _backgroundImage = image.CGImage;
    }
    return _backgroundImage;
}
- (void)colorSelected:(UIColor *)color {
    _userPickedColor = color;
    self.backgroundColor = color;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
//    NSLog(@"%@ (%.2f,%.2f)-(%.2f,%.2f)", @"PaletteView.drawRect", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, rect, self.backgroundImage);
    
    CGRect drawRect = CGRectMake(20, 20, 100, 100);
//    CGRect drawRect2 = CGRectMake(30, 30, 90, 90);
    CGRect drawRect2 = CGRectMake(30, 30, 60, 60);
//    CGContextBeginTransparencyLayerWithRect(context, drawRect, NULL);
    if (_userPickedColor) {
        CGFloat bgRed, bgGreen, bgBlue, bgAlpha;
        [_userPickedColor getRed:&bgRed green:&bgGreen blue:&bgBlue alpha:&bgAlpha];
        CGContextSetRGBFillColor(context, bgRed, bgGreen, bgBlue, bgAlpha);
        CGContextFillRect(context, drawRect2);
    }
//    CGContextEndTransparencyLayer(context);
}

@end
