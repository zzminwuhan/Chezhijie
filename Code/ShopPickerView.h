//
//  ShopPickerView.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/26.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ShopModel.h"

typedef void(^ShopSelBlock)(ShopModel *model);

@interface ShopPickerView : UIView


+ (void)showInView:(UIView*)view array:(NSMutableArray*)array success:(ShopSelBlock)success ;

@end
