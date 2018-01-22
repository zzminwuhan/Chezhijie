//
//  HCarPopView.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/27.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "HCarPopView.h"

@interface HCarPopView ()<UIGestureRecognizerDelegate>

@property (nonatomic ,strong)UIView *customView;

@property (nonatomic ,strong)UILabel *label1;
@property (nonatomic ,strong)UILabel *label2;
@property (nonatomic ,strong)UILabel *label3;

@property (nonatomic ,strong)UITextField *textField1;
@property (nonatomic ,strong)UITextField *textField2;
@property (nonatomic ,strong)UITextField *textField3;


@property (nonatomic ,strong)ShopModel *model;

@property (nonatomic ,copy)ActionBlock successBlock;


@end


@implementation HCarPopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



+ (void)showInView:(UIView*)view shopModel:(ShopModel*)model success:(ActionBlock)success {
    
    HCarPopView * popView = [[HCarPopView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT)];
    popView.successBlock = success;
    popView.model = model;
    [view addSubview:popView];
    
    model.payType = 1;
    
    [popView detailWithModel:model];
    
    [popView show];
}



- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    [self creatView];
    
    return self;
}

#pragma mark - 让视图消失的方法
//解决手势冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint point = [touch locationInView:self];
    
    if (point.y < _customView.top) {
        return YES;
    }
    return NO;
}

- (void)bgTapAction {
    
    [self hide];
}

- (void)creatView {
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT)];
    bgView.backgroundColor = RGBA(0, 0, 0, 0.5);
    [self addSubview:bgView];
    
    
    
    
    _customView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEM_HEIGHT, SCREEM_WIDTH, 200)];
    
    _customView.backgroundColor = [UIColor whiteColor];
    
    
    
    
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT)];
    
    scrollView.contentSize = CGSizeMake(SCREEM_WIDTH, SCREEM_HEIGHT);
    [self addSubview:scrollView];
    [scrollView addSubview:_customView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgTapAction)];
    tap.delegate = self;
    [scrollView addGestureRecognizer:tap];
    
    [self addCustomView];
}



- (void)addCustomView {
    
    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, SCREEM_WIDTH - 30, 30)];
    
    [_customView addSubview:_label1];
    
    _label2 = [[UILabel alloc]initWithFrame:CGRectMake(30, 50, SCREEM_WIDTH - 30, 30)];
    
    [_customView addSubview:_label2];
    
    _label3 = [[UILabel alloc]initWithFrame:CGRectMake(30, 90, SCREEM_WIDTH - 30, 30)];
    
    [_customView addSubview:_label3];
    
    _label1.text = @"姓名：";
    _label2.text = @"联系方式：";
    _label3.text = @"城市：";
    
    _label1.font = FONT14;
    _label1.textColor = RGB(50, 50, 50);
    
    _label2.font = FONT14;
    _label2.textColor = RGB(50, 50, 50);
    
    _label3.font = FONT14;
    _label3.textColor = RGB(50, 50, 50);
    
    CGFloat x = 120;
    _textField1 = [[UITextField alloc]initWithFrame:CGRectMake(x, 13, SCREEM_WIDTH - x - 40, 24)];
    
    
    [_customView addSubview:_textField1];
    
    _textField2 = [[UITextField alloc]initWithFrame:CGRectMake(x, 53, SCREEM_WIDTH - x - 40, 24)];
    
    
    [_customView addSubview:_textField2];
    
    _textField3 = [[UITextField alloc]initWithFrame:CGRectMake(x, 93, SCREEM_WIDTH - x - 40, 24)];
    
    
    [_customView addSubview:_textField3];
    
    [self setTextField:_textField1 placeholder:@"请输入姓名"];
    [self setTextField:_textField2 placeholder:@"请输入联系方式"];
    [self setTextField:_textField3 placeholder:@"请输入购车城市"];
    
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, _customView.height - 50, SCREEM_WIDTH, 50)];
    btn.backgroundColor = MAINCOLOR;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"立即预约" forState:UIControlStateNormal];
    [_customView addSubview:btn];
    
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)setTextField:(UITextField *)textField placeholder:(NSString*)placeholder {
    
    textField.placeholder = placeholder;
    
    textField.layer.masksToBounds = YES;
    textField.layer.cornerRadius = 5;
    textField.layer.borderWidth = 0.5;
    textField.layer.borderColor = RGB(200, 200, 200).CGColor;
    
    textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.font = FONT14;
}


    

- (void)btnAction {
    
    _model.contactname = _textField1.text;
    _model.contactmobile = _textField2.text;
    _model.city = _textField3.text;
    
    if(_model.contactname.length <= 0){
        [HUDManager alertText:_textField1.placeholder];
        return;
    }
    
    if(_model.contactmobile.length <= 0){
        [HUDManager alertText:_textField2.placeholder];
        return;
    }
    
    if(_model.city.length <= 0){
        [HUDManager alertText:_textField3.placeholder];
        return;
    }
    
    [self hide];
    
    if(_successBlock != nil){
        _successBlock();
    }
}


- (void)detailWithModel:(ShopModel*)model {
    
    _textField1.text = model.contactname;
    _textField2.text = model.contactmobile;
    _textField3.text = model.city;
}

- (void)show {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _customView.frame = CGRectMake(0, SCREEM_HEIGHT - _customView.height, SCREEM_WIDTH, _customView.height);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _customView.frame = CGRectMake(0, SCREEM_HEIGHT, SCREEM_WIDTH, _customView.height);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}






@end
