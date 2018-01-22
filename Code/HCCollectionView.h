//
//  HCCollectionView.h
//  QKParkTime
//
//  Created by 李加建 on 2017/9/25.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HCCollectionViewCell.h"

@protocol HCCollectionViewDelegate <NSObject>

- (void)collectionCell:(HCCollectionViewCell*)cell didSelectItemAtIndexPath:(NSIndexPath *)indexPath ;

@end


@protocol HCCollectionViewDataSource <NSObject>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItems:(NSInteger)section;

- (void)collectionCell:(HCCollectionViewCell*)cell cellForItemAtIndexPath:(NSIndexPath *)indexPath ;

@end


@interface HCCollectionView : UIView <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout >

@property (strong, nonatomic)UICollectionView *collectionView;

@property (nonatomic ,assign) CGSize layoutSize;

@property (nonatomic ,assign) CGFloat layoutWidth;

@property (nonatomic ,weak) id<HCCollectionViewDelegate> delegate;

@property (nonatomic ,weak) id<HCCollectionViewDataSource> dataSource;

@end
