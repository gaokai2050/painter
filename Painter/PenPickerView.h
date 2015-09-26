//
//  PenPickerView.h
//  Painter
//
//  Created by Michael Gao on 15/9/12.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PenRef.h"

@protocol PenPickerDelegate <NSObject>
@optional
- (void)penSelected:(PenRef *)pen;
@end

@interface PenPickerView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic,retain) id <PenPickerDelegate> pickDelegate;

@end
