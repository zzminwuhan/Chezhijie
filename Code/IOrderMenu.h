//
//  IOrderMenu.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/9.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IOrderMenu : UIView

@property (nonatomic ,copy)void (^BtnSelWithTag)(NSInteger tag);

@property (nonatomic ,strong)NSArray *titleArray;

@end
