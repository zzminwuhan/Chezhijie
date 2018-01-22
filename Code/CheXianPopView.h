//
//  CheXianPopView.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/11/2.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ShopModel.h"

@interface CheXianPopView : UIView


+ (void)showInView:(UIView*)view shopModel:(ShopModel*)model success:(ActionBlock)success ;

@end
