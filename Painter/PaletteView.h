//
//  PaletteView.h
//  Painter
//
//  Created by Michael Gao on 15/9/12.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorPickerView.h"

@interface PaletteView : UIView <ColorPickerDelegate>

@property (strong, nonatomic) UIColor *userPickedColor;

@end
