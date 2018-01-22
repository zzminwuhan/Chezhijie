//
//  CheXianEditViewController.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/10.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BaseViewController.h"

#import "ShopModel.h"

@interface CheXianEditViewController : BaseViewController

@property (nonatomic ,strong)ShopModel *shopModel;

@property (nonatomic ,strong)NSMutableArray *adList;

@end
