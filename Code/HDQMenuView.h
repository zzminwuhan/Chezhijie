//
//  HDQMenuView.h
//  TongHuaLi
//
//  Created by 李加建 on 2017/7/15.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDQMenuView : UIView

@property (nonatomic ,copy)void (^BtnSelWithTag)(NSInteger tag);

@property (nonatomic ,strong)NSArray *titleArray;

@end
