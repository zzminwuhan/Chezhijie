//
//  InfoCarsViewController.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/25.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BaseViewController.h"

#import "CarModel.h"

@interface InfoCarsViewController : BaseViewController

@property (nonatomic ,copy)void (^selCarBlock)(CarModel* model);

@end
