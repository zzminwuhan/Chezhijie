//
//  HCCollectionView.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/25.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "HCCollectionView.h"

#import "HCCollectionViewCell.h"


@interface HCCollectionView ()


@end


@implementation HCCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    [self creatView];
    
    return self;
}



- (void)creatView {
    
    //确定是水平滚动，还是垂直滚动
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //    flowLayout.delegate = self;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width,self.height) collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    
    self.collectionView.alwaysBounceVertical = NO;
    self.collectionView.alwaysBounceHorizontal = NO;
    //注册Cell，必须要有
    [self.collectionView registerClass:[HCCollectionViewCell class] forCellWithReuseIdentifier:@"HCCollectionViewCell"];
    
    
    [self addSubview:self.collectionView];
    
    
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
}



#pragma mark - UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if([self.dataSource respondsToSelector:@selector(collectionView:numberOfItems:)]){
        NSLog(@"用户定义了myFunction方法");
      return  [self.dataSource collectionView:self.collectionView numberOfItems:section];

    }
    else{
        NSLog(@"用户没有定义myFunction方法");
        return 0;
    }
    
}



//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"HCCollectionViewCell";
    HCCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    [cell borderWithIndexPath:indexPath];
    
    if([self.dataSource respondsToSelector:@selector(collectionCell:cellForItemAtIndexPath:)]){
        NSLog(@"用户定义了myFunction方法");
        [self.dataSource collectionCell:cell cellForItemAtIndexPath:indexPath];
        
    }
    
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(self.width/3, self.height/3);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if([self.delegate respondsToSelector:@selector(collectionCell:cellForItemAtIndexPath:)]){
        NSLog(@"用户定义了myFunction方法");
        [self.delegate collectionCell:nil didSelectItemAtIndexPath:indexPath];
        
    }
}




@end
