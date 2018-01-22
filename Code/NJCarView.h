//
//  NJCarView.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/10.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CarModel.h"

#define CAR_WIDTH (230*(SCREEM_WIDTH/375.f))

@interface NJCarView : UIView


- (void)dataWithModel:(CarModel*)model ;

@end
