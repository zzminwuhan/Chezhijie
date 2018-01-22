//
//  HYangHuPopView.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/26.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "HYangHuPopView.h"

#import "UPDatePickerView.h"

@interface HYangHuPopView ()

@property (nonatomic ,strong)UIView *customView;

@property (nonatomic ,strong)UILabel *label1;
@property (nonatomic ,strong)UILabel *label2;
@property (nonatomic ,strong)UILabel *label3;
@property (nonatomic ,strong)UILabel *label4;

@property (nonatomic ,strong)ShopModel *model;

@property (nonatomic ,copy)ActionBlock successBlock;

@property (nonatomic ,strong)UILabel *label5;

@property (nonatomic ,strong)UIButton *btn1;

@property (nonatomic ,strong)UIButton *btn2;

@property (nonatomic ,strong)UIButton *selBtn;

@property (nonatomic ,strong)UIButton *dateBtn;

@end


@implementation HYangHuPopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




+ (void)showInView:(UIView*)view shopModel:(ShopModel*)model success:(ActionBlock)success {
    
    HYangHuPopView * popView = [[HYangHuPopView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT)];
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



- (void)bgTapAction {
    
    [self hide];
}

- (void)creatView {
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT)];
    bgView.backgroundColor = RGBA(0, 0, 0, 0.5);
    [self addSubview:bgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgTapAction)];
    
    [bgView addGestureRecognizer:tap];
    
    
    _customView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEM_HEIGHT, SCREEM_WIDTH, 240)];
    
    _customView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_customView];
    
    
    [self addCustomView];
}



- (void)addCustomView {
    
    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, SCREEM_WIDTH - 30, 30)];
    
    [_customView addSubview:_label1];
    
    _label2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 40, SCREEM_WIDTH - 30, 30)];
    
    [_customView addSubview:_label2];
    
    _label3 = [[UILabel alloc]initWithFrame:CGRectMake(15, 70, SCREEM_WIDTH - 30, 30)];
    
    [_customView addSubview:_label3];
    
    _label4 = [[UILabel alloc]initWithFrame:CGRectMake(15, 100, SCREEM_WIDTH - 30, 30)];
    
    [_customView addSubview:_label4];
    
    [self initDateBtn];
    
    _label5 = [[UILabel alloc]initWithFrame:CGRectMake(15, 130, SCREEM_WIDTH - 30, 30)];
    
    [_customView addSubview:_label5];
    
    
    _btn1 = [[UIButton alloc]initWithFrame:CGRectMake(80, _label5.top, 80, 30)];
    [_btn1 setTitle:@"微信" forState:UIControlStateNormal];
    [_btn1 setTitleColor:RGB(100, 100, 100) forState:UIControlStateNormal];
    [_customView addSubview:_btn1];
    
    [_btn1 setImage:[UIImage imageNamed:@"btn_usel"] forState:UIControlStateNormal];
    [_btn1 setImage:[UIImage imageNamed:@"img_reg"] forState:UIControlStateSelected];
    
    [_btn1 setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [_btn1 setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    
    _btn2 = [[UIButton alloc]initWithFrame:CGRectMake(80+_btn1.width, _label5.top, 80, 30)];
    [_btn2 setTitle:@"支付宝" forState:UIControlStateNormal];
    [_btn2 setTitleColor:RGB(100, 100, 100) forState:UIControlStateNormal];
    [_customView addSubview:_btn2];
    [_btn2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [_btn2 setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    
    [_btn2 setImage:[UIImage imageNamed:@"btn_usel"] forState:UIControlStateNormal];
    [_btn2 setImage:[UIImage imageNamed:@"img_reg"] forState:UIControlStateSelected];
    
    _btn1.titleLabel.font = FONT14;
    _btn2.titleLabel.font = FONT14;
    
    [_btn2 addTarget:self action:@selector(payBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_btn1 addTarget:self action:@selector(payBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, _customView.height - 50, SCREEM_WIDTH, 50)];
    btn.backgroundColor = MAINCOLOR;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"立即预约" forState:UIControlStateNormal];
    [_customView addSubview:btn];
    
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self payBtnAction:_btn1];
}


- (void)initDateBtn {
    
    UIButton * dateBtn = [[UIButton alloc]initWithFrame:CGRectMake(90, 100+3, 200, 24)];
    
    dateBtn.layer.masksToBounds = YES;
    dateBtn.layer.cornerRadius = 5;
    dateBtn.layer.borderWidth = 0.5;
    dateBtn.layer.borderColor = RGB(200, 200, 200).CGColor;
    [_customView addSubview:dateBtn];
    dateBtn.titleLabel.font = FONT14;
    [dateBtn setTitleColor:RGB(200, 200, 200) forState:UIControlStateNormal];
    [dateBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [dateBtn setTitle:@"请选择预约时间" forState:UIControlStateNormal];
    dateBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    self.dateBtn = dateBtn;
    
    [dateBtn addTarget:self action:@selector(datePickerSelect) forControlEvents:UIControlEventTouchUpInside];
}

- (void)datePickerSelect {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow ;
    
    [DPDatePickerView showInView:window success:^(NSString *date) {
        
        _model.startdate = date;
        [self.dateBtn setTitle:date forState:UIControlStateNormal];
    }];
}



- (void)payBtnAction:(UIButton*)btn {
    
    _selBtn.selected = NO;
    _selBtn = btn;
    _selBtn.selected = YES;
    
    if(_selBtn == _btn1){
        _model.payType = 1;
    }
    else if (_selBtn == _btn2){
        _model.payType = 2;
    }
}


- (void)btnAction {
    
    [self hide];
    
    if(_successBlock != nil){
        _successBlock();
    }
}


- (void)detailWithModel:(ShopModel*)model {
    
    _label1.attributedText = [self showTitle:@"店铺名称：" text:model.name];
    _label2.attributedText = [self showTitle:@"店铺地址：" text:model.address];
    
    NSString *price = [NSString stringWithFormat:@"￥%@",model.price];
    _label3.attributedText = [self show2Title:@"付款金额：" text:price];
    _label4.attributedText = [self showTitle:@"预约时间：" text:@""];
    _label5.attributedText = [self showTitle:@"支付方式：" text:@""];
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



- (NSAttributedString *)show2Title:(NSString *)title text:(NSString*)text {
    
    
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName:RGB(50, 50, 50),NSFontAttributeName:FONT14 };
    
    NSDictionary *attributes2 = @{NSForegroundColorAttributeName:RGB(250, 127, 124),NSFontAttributeName:FONT14 };
    
    NSAttributedString * attri1 =[[NSAttributedString alloc]initWithString:title attributes:attributes];
    
    NSAttributedString * attri2 =[[NSAttributedString alloc]initWithString:text attributes:attributes2];
    
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] init];
    
    [attriString appendAttributedString:attri1];
    [attriString appendAttributedString:attri2];
    
    return attriString ;
    
}



- (NSAttributedString *)showTitle:(NSString *)title text:(NSString*)text {
    
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName:RGB(50, 50, 50),NSFontAttributeName:FONT14 };
    
    NSDictionary *attributes2 = @{NSForegroundColorAttributeName:RGB(100, 100, 100),NSFontAttributeName:FONT14 };
    
    NSAttributedString * attri1 =[[NSAttributedString alloc]initWithString:title attributes:attributes];
    
    NSAttributedString * attri2 =[[NSAttributedString alloc]initWithString:text attributes:attributes2];
    
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] init];
    
    [attriString appendAttributedString:attri1];
    [attriString appendAttributedString:attri2];
    
    return attriString ;
    
}



@end
