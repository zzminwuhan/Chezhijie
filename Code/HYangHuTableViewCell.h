//
//  HYangHuTableViewCell.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/11.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ShopModel.h"

@interface HYangHuTableViewCell : UITableViewCell

@property (nonatomic ,copy)ActionBlock payBlock;

- (void)dataWithModel:(ShopModel*)model ;

@end
