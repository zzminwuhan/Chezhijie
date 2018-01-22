//
//  CarShopHeadView.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/27.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ShopModel.h"

@interface CarShopHeadView : UIView

@property (nonatomic ,strong)NSArray *carTypeArray;

- (void)dataWithModel:(ShopModel*)model ;



@end
