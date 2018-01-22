//
//  YangHuHeadView.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/10.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "YangHuHeadView.h"

#import "PhoneView.h"

@interface YangHuHeadView ()

@property (nonatomic ,strong)UIImageView *imgView;

@property (nonatomic ,strong)UILabel *label;

@property (nonatomic ,strong)UILabel *orderNum ;
@property (nonatomic ,strong)UILabel *orderName ;
@property (nonatomic ,strong)UILabel *date ;
@property (nonatomic ,strong)UILabel *discount ;

@property (nonatomic ,strong)UILabel * label1;
@property (nonatomic ,strong)UILabel * label2;
@property (nonatomic ,strong)UILabel * label3;
@property (nonatomic ,strong)UILabel * label4;
@property (nonatomic ,strong)UILabel * label5;
@property (nonatomic ,strong)UILabel * label6;

@property (nonatomic ,strong)NSString * mobile;

@property (nonatomic ,strong)UILabel * label7;

@end

@implementation YangHuHeadView

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
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEM_WIDTH/2 - 35, 35, 70, 70)];
    imgView.image = [UIImage imageNamed:@"tipvc"];
    
    [self addSubview:imgView];
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, imgView.bottom+10, SCREEM_WIDTH, 40)];
    _label.textAlignment = NSTextAlignmentCenter;
    //    _label.numberOfLines = 3;
    _label.text = @"支付成功";
    _label.font = FONT18;
    _label.textColor = RGB(50, 50, 50);
    
    [self addSubview:_label];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, _label.bottom+10, SCREEM_WIDTH, 0.5)];
    line.backgroundColor = RGB(200, 200, 200);
    [self addSubview:line];
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(15, line.bottom + 15, 100, 76)];
    _imgView.layer.masksToBounds = YES;
    _imgView.layer.cornerRadius = 4;
    
    [self addSubview:_imgView];
    
    //    _orderNum = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEM_WIDTH - 30, 40)];
    //    _orderNum.textColor = RGB(25, 25, 25);
    //    _orderNum.numberOfLines = 2;
    //    [self addSubview:_orderNum];
    //    _orderNum.font = FONT14;
    //
    //    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, SCREEM_WIDTH, 0.5)];
    //    line.backgroundColor = RGB(200, 200, 200);
    //    [self addSubview:line];
    
    _orderName = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right +15, line.bottom + 15, SCREEM_WIDTH - _imgView.right - 30, 38)];
    _orderName.textColor = RGB(25, 25, 25);
    _orderName.numberOfLines = 2;
    [self addSubview:_orderName];
    _orderName.font = FONT14;
    
    _date = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right +15, line.bottom + 38, SCREEM_WIDTH - _imgView.right - 30, 25)];
    _date.font = FONT11;
    _date.textColor = RGB(150, 150, 150);
    [self addSubview:_date];
    
    
    _discount = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right +15, line.bottom + 66, SCREEM_WIDTH - _imgView.right - 30, 25)];
    _discount.font = FONT18;
    _discount.textColor = RGB(248, 127, 126);;
    [self addSubview:_discount];
    
    
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, _imgView.bottom+15, SCREEM_WIDTH, 10)];
    line2.backgroundColor = RGB(240, 240, 240);
    [self addSubview:line2];
    
    [self creatLabel];
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH, _label5.bottom + 30);
    
}



- (void)btnAction {
    
    [PhoneView showInWindowWithPhone:_mobile];
}


- (void)creatLabel {
    
    
    CGFloat y = _imgView.bottom +25;
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 55, y, 50, 44)];
    [btn setImage:[UIImage imageNamed:@"order_phone"] forState:UIControlStateNormal];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(15, y+44*0, SCREEM_WIDTH - 30, 44)];
    _label1.textColor = RGB(50, 50, 50);
    _label1.font = FONT14;
    [self addSubview:_label1];
    
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, _label1.bottom, SCREEM_WIDTH, 0.5)];
    line1.backgroundColor = RGB(200, 200, 200);
    [self addSubview:line1];
    
    
    _label2 = [[UILabel alloc]initWithFrame:CGRectMake(15, y+44*1, SCREEM_WIDTH - 30, 44)];
    _label2.textColor = RGB(50, 50, 50);
    _label2.font = FONT14;
    [self addSubview:_label2];
    
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, _label2.bottom, SCREEM_WIDTH, 0.5)];
    line2.backgroundColor = RGB(200, 200, 200);
    [self addSubview:line2];
    
    
    _label7 = [[UILabel alloc]initWithFrame:CGRectMake(15, y+44*2, SCREEM_WIDTH - 30, 44)];
    _label7.textColor = RGB(50, 50, 50);
    _label7.font = FONT14;
    [self addSubview:_label7];
    
    UILabel *line7 = [[UILabel alloc]initWithFrame:CGRectMake(0, _label7.bottom, SCREEM_WIDTH, 0.5)];
    line7.backgroundColor = RGB(200, 200, 200);
    [self addSubview:line7];
    
    _label3 = [[UILabel alloc]initWithFrame:CGRectMake(15, y+44*3, SCREEM_WIDTH - 30, 44)];
    _label3.textColor = RGB(50, 50, 50);
    _label3.font = FONT14;
    [self addSubview:_label3];
    
    UILabel *line3 = [[UILabel alloc]initWithFrame:CGRectMake(0, _label3.bottom, SCREEM_WIDTH, 0.5)];
    line3.backgroundColor = RGB(200, 200, 200);
    [self addSubview:line3];
    
    _label4 = [[UILabel alloc]initWithFrame:CGRectMake(15, y+44*4, SCREEM_WIDTH - 30, 44)];
    _label4.textColor = RGB(50, 50, 50);
    _label4.font = FONT14;
    [self addSubview:_label4];
    
    UILabel *line4 = [[UILabel alloc]initWithFrame:CGRectMake(0, _label4.bottom, SCREEM_WIDTH, 0.5)];
    line4.backgroundColor = RGB(200, 200, 200);
    [self addSubview:line4];
    
    _label5 = [[UILabel alloc]initWithFrame:CGRectMake(15, y+44*5, SCREEM_WIDTH - 30, 44)];
    _label5.textColor = RGB(50, 50, 50);
    _label5.font = FONT14;
    [self addSubview:_label5];
    
    UILabel *line5 = [[UILabel alloc]initWithFrame:CGRectMake(0, _label5.bottom, SCREEM_WIDTH, 0.5)];
    line5.backgroundColor = RGB(200, 200, 200);
    [self addSubview:line5];
    
    
    
}





- (void)dataWithModel:(OrderModel*)model {
    
    _mobile = model.mobile;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.imageurl]];
    
    _orderNum.text = [NSString stringWithFormat:@"预约号：%@",model.serialnumber];
    _orderName.text = model.shopname;
    
    _orderName.frame = CGRectMake(_imgView.right +15, _imgView.top, SCREEM_WIDTH - _imgView.right - 30, 38);
    [_orderName sizeToFit];
    
    _date.text = [NSString stringWithFormat:@"%@",model.address];
    _discount.text = [NSString stringWithFormat:@"￥%@",model.orderprice];
    
    _label1.text = [NSString stringWithFormat:@"订单号：%@",model.serialnumber];
    _label2.attributedText = [model xiaofeiCode];// [NSString stringWithFormat:@"消费码：%@",model.code];
    _label3.text = [NSString stringWithFormat:@"预约时间：%@",model.startdate];
    _label4.text = [NSString stringWithFormat:@"付款方式：%@",model.payway];
    _label5.text = [NSString stringWithFormat:@"车辆信息："];
    
    _label7.text = [NSString stringWithFormat:@"分类：%@",model.yhcate];
    
}


@end
