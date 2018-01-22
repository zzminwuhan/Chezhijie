//
//  CarTextView.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/9.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "CarTextView.h"



@interface CarTextView ()

@property (nonatomic ,strong)UILabel *lineTop;
@property (nonatomic ,strong)UILabel *lineBottom;

@property (nonatomic ,copy)ActionBlock btnBlock;

@end

@implementation CarTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    
    [self creatView];
    
    return self;
}


- (void)creatView {
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEM_WIDTH - 30, self.height)];
    _title.textColor = RGB(50, 50, 50);
    _title.font = FONT14;
    [self addSubview:_title];
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(110, self.height/2 - 18, SCREEM_WIDTH - 125, 36)];
    _textField.layer.masksToBounds = YES;
    _textField.layer.cornerRadius = 4;
    _textField.layer.borderWidth = 0.5;
    _textField.layer.borderColor = RGB(200, 200, 200).CGColor;
    
    _textField.textColor = RGB(50, 50, 50);
    _textField.font = FONT(12);
    [self addSubview:_textField];
    
//    _lineTop = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 0.5)];
//    _lineTop.backgroundColor = RGB(200, 200, 200);
//    [self addSubview:_lineTop];
    
    _leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 36)];
    
    _textField.leftView = _leftView;
    _textField.leftViewMode = UITextFieldViewModeAlways;
    
    
}


- (void)addBtnInTextField {
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, _textField.width, self.textField.height)];
    
    [_textField addSubview:btn];
    
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
}


- (void)btnAction {
    
    if(_clickBlock != nil){
        _clickBlock(self);
    }
}



- (void)addProvinceBtnBlock:(ActionBlock)btnBlock {
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(8, 8, 36, 20)];
    btn.backgroundColor = RGB(113, 128, 147);
    [self.leftView addSubview:btn];
    btn.titleLabel.font = FONT12;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 3;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"沪" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"province_mark"] forState:UIControlStateNormal];
    self.btnBlock = btnBlock;
    
    [btn addTarget:self action:@selector(pBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.provinceBtn = btn;
    
    
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -btn.imageView.frame.size.width, 0, btn.imageView.frame.size.width)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, btn.titleLabel.bounds.size.width, 0, -btn.titleLabel.bounds.size.width)];
    
}

- (void)pBtnAction {
    
    if(_btnBlock != nil){
        _btnBlock();
    }
}

@end
