//
//  ColorPickerView.h
//  Painter
//
//  Created by Michael Gao on 15/9/10.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColorPickerDelegate <NSObject>
@optional
- (void)colorSelected:(UIColor *)color;
@end

@interface ColorPickerView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic,retain) id <ColorPickerDelegate> pickDelegate;

@end
