//
//  UPDatePickerView.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/26.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DPDatePickerView.h"

//typedef void(^DateSelBlock)(NSString *date);


@interface UPDatePickerView : UIView


+ (void)showInView:(UIView*)view  success:(DateSelBlock)success ;

@end
