//
//  MainViewController.h
//  Painter
//
//  Created by Michael Gao on 15/9/12.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SketchPad.h"
#import "ColorPickerView.h"
#import "PaletteView.h"
#import "PenPickerView.h"
#import "CanvasView.h"

@interface MainViewController : UIViewController <ColorPickerDelegate>

@property (strong, nonatomic) SketchPad *pad;

@property (weak, nonatomic) IBOutlet CanvasView *canvas;
@property (weak, nonatomic) IBOutlet ColorPickerView *colorPicker;
@property (weak, nonatomic) IBOutlet PaletteView *palette;
@property (weak, nonatomic) IBOutlet PenPickerView *penPicker;

@end
