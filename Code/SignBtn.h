//
//  SignBtn.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/20.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SignModel.h"

@interface SignBtn : UIButton

@property (nonatomic ,strong)UILabel *mark;

@property (nonatomic ,strong)UILabel *label;


- (void)dataWithModel:(SignModel*)model ;


@end
