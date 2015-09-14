//
//  PaletteView.m
//  Painter
//
//  Created by Michael Gao on 15/9/12.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import "PaletteView.h"

@implementation PaletteView

- (id)initWithCoder:(NSCoder *)c
{
    self = [super initWithCoder:c];
    if (self) {
        _userPickedColor = [UIColor blackColor];
    }
    return self;
}
- (void)colorSelected:(UIColor *)color {
    _userPickedColor = color;
    self.backgroundColor = color;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
