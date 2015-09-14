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
        _userPickedColor = [UIColor blackColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _colorPicker.pickDelegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)colorSelected:(UIColor *)color {
    _userPickedColor = color;
    [_palette colorSelected:color];
    _canvas.drawColor = color;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
