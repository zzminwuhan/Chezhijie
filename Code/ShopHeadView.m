//
//  ShopHeadView.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/26.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "ShopHeadView.h"


@interface ShopHeadView ()

@property (nonatomic ,strong)UIImageView *imgView;

@property (nonatomic ,strong)UILabel *title;
@property (nonatomic ,strong)UILabel *address;
@property (nonatomic ,strong)UILabel *price;

@end

@implementation ShopHeadView

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
    
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_WIDTH*0.56)];
    _imgView.clipsToBounds = YES;
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_imgView];
    
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(15, _imgView.bottom +10, SCREEM_WIDTH - 30, 20)];
    _title.font = FONT14;
    _title.textColor = RGB(50, 50, 50);
    [self addSubview:_title];
    
    
    _address = [[UILabel alloc]initWithFrame:CGRectMake(15, _imgView.bottom +30, SCREEM_WIDTH - 30, 20)];
    _address.font = FONT14;
    _address.textColor = RGB(150, 150, 150);
    [self addSubview:_address];
    
    
    _price = [[UILabel alloc]initWithFrame:CGRectMake(15, _imgView.bottom +20, SCREEM_WIDTH - 30, 20)];
    _price.textAlignment = NSTextAlignmentRight;
    _price.font = FONT14;
    _price.textColor = RGB(250, 127, 124);
    [self addSubview:_price];
    
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, _imgView.bottom +60, SCREEM_WIDTH, 10)];
    line.backgroundColor = RGB(240, 240, 240);
    [self addSubview:line];
    
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(15, line.bottom, SCREEM_WIDTH - 30, 40)];
    label.text = @"图文详情";
    label.font = FONT14;
    label.textColor = RGB(50, 50, 50);
    [self addSubview:label];
    
    
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, line.bottom+5, 5, 30)];
    line2.backgroundColor = MAINCOLOR;
    [self addSubview:line2];
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH, label.bottom);
    
}




- (void)dataWithModel:(ShopModel*)model {
    
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.imgurl]];
    
    _title.text = model.name;
    
    
    
    _address.text = model.address;
    
    
    if([model.cateid integerValue] == 3){
        _price.text = [NSString stringWithFormat:@"%@",model.discount];
    }
    else {
        _price.text = [NSString stringWithFormat:@"￥%@",model.price];
    }
    
}


@end
