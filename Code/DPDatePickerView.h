//
//  DPDatePickerView.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/31.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DateSelBlock)(NSString *date);

@interface DPDatePickerView : UIView

+ (void)showInView:(UIView*)view  success:(DateSelBlock)success ;

@end
