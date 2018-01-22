//
//  InfoCarsTableViewCell.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/9.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CarModel.h"

@interface InfoCarsTableViewCell : UITableViewCell

@property (nonatomic ,copy)ActionBlock editBlock;
@property (nonatomic ,copy)ActionBlock delBlock;

@property (nonatomic ,strong)UIButton *btn1;


- (void)dataWithModel:(CarModel*)model ;

@end
