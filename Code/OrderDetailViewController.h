//
//  OrderDetailViewController.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/10.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BaseViewController.h"

#import "OrderModel.h"

@interface OrderDetailViewController : BaseViewController

@property (nonatomic ,assign)NSInteger selTag;

@property (nonatomic ,strong)OrderModel *model;

@end
