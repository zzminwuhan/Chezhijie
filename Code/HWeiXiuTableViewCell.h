//
//  HWeiXiuTableViewCell.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/26.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ShopModel.h"

@interface HWeiXiuTableViewCell : UITableViewCell

@property (nonatomic ,copy)ActionBlock payBlock;

- (void)dataWithModel:(ShopModel*)model ;

@end
