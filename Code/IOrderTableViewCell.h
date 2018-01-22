//
//  IOrderTableViewCell.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/9.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "OrderModel.h"

@interface IOrderTableViewCell : UITableViewCell

@property (nonatomic ,copy)ActionBlock phoneBlock;


- (void)dataWithModel:(OrderModel*)model  ;

@end
