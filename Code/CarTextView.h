//
//  CarTextView.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/9.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CarTextView;

typedef void(^TextViewClick)(CarTextView *carTextView);

@interface CarTextView : UIView

@property (nonatomic ,strong)UILabel *title;

@property (nonatomic ,strong)UITextField *textField;

@property (nonatomic ,strong)UIView *leftView;

@property (nonatomic ,strong)UIButton *provinceBtn;

@property (nonatomic ,copy)TextViewClick clickBlock;

- (void)addBtnInTextField  ;


- (void)addProvinceBtnBlock:(ActionBlock)btnBlock ;

@end
