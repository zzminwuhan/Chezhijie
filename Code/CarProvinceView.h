//
//  CarProvinceView.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/28.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CarProvinceSelBlock)(NSString *province);

@interface CarProvinceView : UIView


+ (void)showInView:(UIView*)view  success:(CarProvinceSelBlock)success ;

+ (void)showInView:(UIView*)view array:(NSMutableArray*)array success:(CarProvinceSelBlock)success ;

@end
