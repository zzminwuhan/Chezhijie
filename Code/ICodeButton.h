//
//  ICodeButton.h
//  AppONE
//
//  Created by yuyue on 15-11-24.
//  Copyright (c) 2015年 incredibleRon. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^DidClickBlock)(void);

@interface ICodeButton : UIButton


+ (instancetype)viewWithFrame:(CGRect)frame text:(NSString*)text didClicked:(DidClickBlock)block  ;

- (void)timeStart;

@end
