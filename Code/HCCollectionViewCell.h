//
//  HCCollectionViewCell.h
//  QKParkTime
//
//  Created by 李加建 on 2017/9/25.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface HCCollectionViewCell : UICollectionViewCell

@property (nonatomic ,strong)UIImageView *imgView;

@property (nonatomic ,strong)UILabel *title;

- (void)borderWithIndexPath:(NSIndexPath*)indexpath ;

@end
