//
//  PaletteView.h
//  Painter
//
//  Created by Michael Gao on 15/9/12.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Polygon.h"
#import "ColorPickerView.h"
#import "LineInPalette.h"

@interface PaletteView : UIView <ColorPickerDelegate>

@property (strong, nonatomic) Polygon *palette;
@property (strong, nonatomic) UIColor *userPickedColor;
@property (strong, nonatomic) LineInPalette *currentLine;
@property (strong, nonatomic) NSMutableArray *linesCompleted;

@property (strong, nonatomic) UIColor *backgroundColor;
@property (strong, nonatomic) UIColor *paletteColor;

@end
