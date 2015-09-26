//
//  ColorPickerCell.m
//  Painter
//
//  Created by Michael Gao on 15/9/10.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import "ColorPickerCell.h"

@implementation ColorPickerCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor blackColor] CGColor];
    }
    return self;
}

- (void)setColor:(UIColor*)color
{
    self.contentView.backgroundColor = color;
}

@end
