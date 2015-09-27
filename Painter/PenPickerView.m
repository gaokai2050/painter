//
//  PenPickerView.m
//  Painter
//
//  Created by Michael Gao on 15/9/12.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import "PenPickerView.h"
#import "PenPickerCell.h"
#import "PenManager.h"

@implementation PenPickerView

static NSString* CELL_ID = @"PEN_PICKER";

- (id)initWithCoder:(NSCoder *)c
{
    self = [super initWithCoder:c];
    if (self) {
        [self internalInitialize];
    }
    return self;
}

- (void)internalInitialize
{
    self.dataSource = self;
    self.delegate = self;
    [self registerClass:[PenPickerCell class] forCellWithReuseIdentifier:CELL_ID];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[PenManager instance].pens count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PenPickerCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    [cell setPen:[[PenManager instance].pens objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PenPickerCell *cell = (PenPickerCell*)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell) {
        [_pickDelegate penSelected:[[PenManager instance].pens objectAtIndex:indexPath.row]];
    }
}

@end
