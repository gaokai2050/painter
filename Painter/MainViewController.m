//
//  MainViewController.m
//  Painter
//
//  Created by Michael Gao on 15/9/12.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController

- (id)init {
    self = [super initWithNibName:@"MainViewController" bundle:nil];
    if (self) {
        _pad = [[SketchPad alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _colorPicker.pickDelegate = self;
    _penPicker.pickDelegate = self;
}

- (void)colorSelected:(UIColor *)color {
    [_palette colorSelected:color];
    _canvas.drawColor = color;
    _pad.color = color;
}

-(void)penSelected:(PenRef *)pen {
    _pad.pen = pen;
}

@end
