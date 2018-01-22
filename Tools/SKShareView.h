//
//  SKShareView.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/28.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SKShareBlock)(NSInteger tag);

@interface SKShareView : UIView


+ (void)showInView:(UIView*)view  success:(SKShareBlock)success ;

@end
