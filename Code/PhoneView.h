//
//  PhoneView.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/26.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneView : UIView

@property (nonatomic ,strong)UILabel *title;


+ (void )showInWindowWithPhone:(NSString*)phone ;


+ (void )showInWindowWithPhone2:(NSString*)phone ;

@end
