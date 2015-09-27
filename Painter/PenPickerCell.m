//
//  PenPickerCell.m
//  Painter
//
//  Created by Michael Gao on 15/9/22.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import "PenPickerCell.h"

@interface PenPickerCell()
@property (strong, nonatomic) UIImageView *image;
@end

@implementation PenPickerCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _image = [[UIImageView alloc] initWithFrame:self.frame];
        if (_image) {
            [self.contentView addSubview:_image];
        } else {
            // How to release self object?
            return nil;
        }
    }
    return self;
}

- (void)setPen:(PenRef*)pen
{
    _pen = pen;
    if (!(_pen && _pen.image)) {
        NSLog(@"[WARNING] Pen or Pen's image is nil");
    }
    _image.image = _pen ? _pen.image : nil;
}

@end
