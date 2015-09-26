//
//  ColorPickerView.m
//  Painter
//
//  Created by Michael Gao on 15/9/10.
//  Copyright (c) 2015年 1quuu. All rights reserved.
//

#import "ColorPickerView.h"
#import "ColorPickerCell.h"

@implementation ColorPickerView

static NSString* CELL_ID = @"COLOR_PICKER";
static NSArray* COLORS = nil;

//- (void)awakeFromNib
//{
//    [super awakeFromNib];
//    [self internalInitialize];
//}
- (id)initWithCoder:(NSCoder *)c
{
    self = [super initWithCoder:c];
    if (self) {
        [self internalInitialize];
    }
    return self;
}
//- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout // the designated initializer
//{
//    self = [super initWithFrame:frame collectionViewLayout:layout];
//    if (self) {
//        [self internalInitialize];
//    }
//    return self;
//}
- (void)internalInitialize
{
    if (!COLORS) {
        COLORS = [[NSArray alloc] initWithObjects:[UIColor blackColor], [UIColor redColor], [UIColor blueColor], [UIColor yellowColor], [UIColor whiteColor], [UIColor greenColor], nil];
    }
    self.dataSource = self;
    self.delegate = self;
    [self registerClass:[ColorPickerCell class] forCellWithReuseIdentifier:CELL_ID];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [COLORS count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ColorPickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    if (!cell) {
        cell = [[ColorPickerCell alloc] init];
        cell.layer.borderWidth = 1;
        cell.layer.borderColor = [[UIColor blackColor] CGColor];
    }
    [cell setColor:COLORS[indexPath.row] ];
    return cell;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ColorPickerCell *cell = (ColorPickerCell*)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell) {
        [_pickDelegate colorSelected:cell.contentView.backgroundColor];
    }
}

@end
