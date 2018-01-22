//
//  HWeiXiuTableViewCell.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/26.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "HWeiXiuTableViewCell.h"


@interface HWeiXiuTableViewCell ()

@property (nonatomic ,strong)UIImageView *imgView;

@property (nonatomic ,strong)UILabel *label;

@property (nonatomic ,strong)UILabel *detail;

@property (nonatomic ,strong)UILabel *date;

@property (nonatomic ,strong)UILabel *line1;

@property (nonatomic ,strong)UILabel *line2;

@property (nonatomic ,strong)UIButton *btn;

@end

@implementation HWeiXiuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.selectionStyle = NO;
    
    [self creatView];
    
    return self;
}



- (void)creatView {
    
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 100, 76)];
    _imgView.layer.masksToBounds = YES;
    _imgView.layer.cornerRadius = 4;
    
    [self.contentView addSubview:_imgView];
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right +15, 10, SCREEM_WIDTH - _imgView.right - 30, 30)];
    _label.textColor = RGB(25, 25, 25);
    [self.contentView addSubview:_label];
    _label.font = FONT14;
    
    _date = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right +15, 40, SCREEM_WIDTH - _imgView.right - 30, 20)];
    _date.font = FONT11;
    _date.textColor = RGB(150, 150, 150);
    [self.contentView addSubview:_date];
    
    
    _detail = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right +15, 60, SCREEM_WIDTH - _imgView.right - 30, 25)];
    _detail.font = FONT18;
    _detail.textColor = RGB(250, 127, 124);
    [self.contentView addSubview:_detail];
    
    
    _line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, _imgView.bottom +10, SCREEM_WIDTH, 0.5)];
    _line1.backgroundColor = RGB(200, 200, 200);
    [self.contentView addSubview:_line1];
    
    
    _btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 80, 60, 65, 25)];
    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btn.titleLabel.font = FONT12;
    [_btn setTitle:@"预约" forState:UIControlStateNormal];
    _btn.backgroundColor = MAINCOLOR;
    _btn.layer.masksToBounds = YES;
    _btn.layer.cornerRadius = 5;
    _btn.layer.borderWidth = 0.5;
    _btn.layer.borderColor = MAINCOLOR.CGColor;
    
    [self.contentView addSubview:_btn];
    
    [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH, _line1.bottom );
}

- (void)btnAction {
    
    if(_payBlock != nil){
        _payBlock();
    }
}



- (void)dataWithModel:(ShopModel*)model {
    
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.imgurl]];
    
    _label.text = model.name;
    
    _detail.text = [NSString stringWithFormat:@"%@",model.discount];
    
    _date.text = model.address;
}


@end
