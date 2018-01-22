//
//  CarEditViewController.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/9.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BaseViewController.h"

#import "CarModel.h"

@interface CarEditViewController : BaseViewController

@property (nonatomic ,strong)CarModel *model;

@property (nonatomic ,copy)ActionBlock successBlock; 

@end
