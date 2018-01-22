//
//  HCarPopView.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/27.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ShopModel.h"

@interface HCarPopView : UIView

+ (void)showInView:(UIView*)view shopModel:(ShopModel*)model success:(ActionBlock)success ;

@end
