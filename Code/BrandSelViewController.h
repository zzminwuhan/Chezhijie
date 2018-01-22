//
//  BrandSelViewController.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/15.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BaseViewController.h"

#import "BrandModel.h"


@interface BrandSelViewController : BaseViewController

@property (nonatomic ,strong)BrandModel * brandModel;
@property (nonatomic ,strong)BrandModel * model;

@property (nonatomic ,copy)void (^selBrandBlock)(BrandModel * brand ,BrandModel *model);

@end
