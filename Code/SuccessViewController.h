//
//  SuccessViewController.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/26.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BaseViewController.h"

#import "ShopModel.h"

#import "OrderModel.h"

@interface SuccessViewController : BaseViewController

@property (nonatomic ,strong)ShopModel *shopModel;

@property (nonatomic ,strong)OrderModel *model;

@property (nonatomic ,assign)NSInteger selTag;

@end
