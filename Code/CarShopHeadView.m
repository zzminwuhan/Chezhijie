//
//  CarShopHeadView.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/27.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "CarShopHeadView.h"


@interface CarShopHeadView ()

@property (nonatomic ,strong)UIImageView *imgView;

@property (nonatomic ,strong)UILabel *title;
@property (nonatomic ,strong)UILabel *address;
@property (nonatomic ,strong)UILabel *price;

@property (nonatomic ,strong)UILabel *tipLabel;

@property (nonatomic ,strong)UILabel *tipLabel2;

@property (nonatomic ,strong)NSMutableArray *btnsArray;

@property (nonatomic ,strong)ShopModel *shopModel;

@property (nonatomic ,strong)UIButton *selBtn;

@end


@implementation CarShopHeadView

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
    
    
    _btnsArray = [NSMutableArray array];
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_WIDTH*0.56)];
    _imgView.clipsToBounds = YES;
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_imgView];
    
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(15, _imgView.bottom +10, SCREEM_WIDTH - 30, 20)];
    _title.font = FONT14;
    _title.textColor = RGB(50, 50, 50);
    [self addSubview:_title];
    
    
    _address = [[UILabel alloc]initWithFrame:CGRectMake(15, _imgView.bottom + 35, SCREEM_WIDTH - 30, 20)];
    _address.font = FONT12;
    _address.textColor = RGB(150, 150, 150);
    _address.numberOfLines = 0;
    [self addSubview:_address];
    
    
    _price = [[UILabel alloc]initWithFrame:CGRectMake(15, _imgView.bottom +10, SCREEM_WIDTH - 30, 20)];
    _price.textAlignment = NSTextAlignmentRight;
    _price.font = FONT15;
    _price.textColor = RGB(250, 127, 124);
    [self addSubview:_price];
    
    
    [self addTiplabel2];
    
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(15, _imgView.bottom +60, SCREEM_WIDTH - 30, 40)];
    label.text = @"图文详情";
    label.font = FONT14;
    label.textColor = RGB(50, 50, 50);
    [self addSubview:label];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(-15, -10, SCREEM_WIDTH, 10)];
    line.backgroundColor = RGB(240, 240, 240);
    [label addSubview:line];
    
    
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(-15, line.bottom+10, 5, 20)];
    line2.backgroundColor = MAINCOLOR;
    [label addSubview:line2];
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH, label.bottom);
    
    self.tipLabel = label;
    
}



- (void)addTiplabel2 {
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(15, _imgView.bottom +60, SCREEM_WIDTH - 30, 40)];
    label.text = @"选择车辆信息";
    label.font = FONT14;
    label.textColor = RGB(50, 50, 50);
    [self addSubview:label];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(-15, -10, SCREEM_WIDTH, 10)];
    line.backgroundColor = RGB(240, 240, 240);
    [label addSubview:line];
    
    
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(-15, line.bottom+10, 5, 20)];
    line2.backgroundColor = MAINCOLOR;
    [label addSubview:line2];
    
    self.tipLabel2 = label;
}





- (void)dataWithModel:(ShopModel*)model {
    
    _shopModel = model;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.imageurl]];
    
    _title.text = model.name;
    
    _price.text = [NSString stringWithFormat:@"%@",model.price];
    
    _address.text = [NSString stringWithFormat:@"%@",model.desc];;
    
    [_address sizeToFit];
    
    self.tipLabel2.frame = CGRectMake(15, _address.bottom +20, SCREEM_WIDTH - 30, 40);
    
    self.tipLabel.frame = CGRectMake(15, _tipLabel2.bottom +20, SCREEM_WIDTH - 30, 40);
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH, self.tipLabel.bottom);
}




- (void)setCarTypeArray:(NSArray *)carTypeArray {
    
    _carTypeArray = carTypeArray;
    
    CGFloat h = 40;
    CGFloat y = h*_carTypeArray.count;
    
    self.tipLabel.frame = CGRectMake(15, _tipLabel2.bottom +20 + y, SCREEM_WIDTH - 30, 40);
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH, self.tipLabel.bottom);
    
    for(UIButton *btn in _btnsArray ){
        [btn removeFromSuperview];
    }
    
    [_btnsArray removeAllObjects];
    
    for(int i= 0;i<_carTypeArray.count ;i++){
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, _tipLabel2.bottom +h*i, SCREEM_WIDTH, h)];
        
        [btn setTitle:_carTypeArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:RGB(100, 100, 100) forState:UIControlStateNormal];
        btn.titleLabel.font = FONT12;
        
        [btn setImage:[UIImage imageNamed:@"mark_nor"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"mark_sel"] forState:UIControlStateSelected];
        
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, SCREEM_WIDTH - 40, 0, -(SCREEM_WIDTH - 40))];
        
        [self addSubview:btn];
        
        [_btnsArray addObject:btn];
        
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
}


- (void)btnAction:(UIButton *)btn {

    _selBtn.selected = NO;
    _selBtn = btn;
    _selBtn.selected = YES;
    
    _shopModel.type = _selBtn.titleLabel.text;
    
}

@end
