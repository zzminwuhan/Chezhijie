//
//  IOrderTableViewCell.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/9.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "IOrderTableViewCell.h"



@interface IOrderTableViewCell ()


@property (nonatomic ,strong)UIImageView *imgView ;

@property (nonatomic ,strong)UILabel *orderNum ;
@property (nonatomic ,strong)UILabel *orderName ;
@property (nonatomic ,strong)UILabel *date ;
@property (nonatomic ,strong)UILabel *discount ;

@property (nonatomic ,strong)UIButton *btn;

@end

@implementation IOrderTableViewCell

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
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 55, 100, 76)];
    _imgView.layer.masksToBounds = YES;
    _imgView.layer.cornerRadius = 4;
    
    [self.contentView addSubview:_imgView];
    
    _orderNum = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEM_WIDTH - 30, 40)];
    _orderNum.textColor = RGB(25, 25, 25);
    _orderNum.numberOfLines = 2;
    [self.contentView addSubview:_orderNum];
    _orderNum.font = FONT14;
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, SCREEM_WIDTH, 0.5)];
    line.backgroundColor = RGB(200, 200, 200);
    [self.contentView addSubview:line];
    
    _orderName = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right +15, 55, SCREEM_WIDTH - _imgView.right - 30, 38)];
    _orderName.textColor = RGB(25, 25, 25);
    _orderName.numberOfLines = 2;
    [self.contentView addSubview:_orderName];
    _orderName.font = FONT14;
    
    _date = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right +15, 78, SCREEM_WIDTH - _imgView.right - 30, 25)];
    _date.font = FONT11;
    _date.textColor = RGB(150, 150, 150);
    [self.contentView addSubview:_date];
    
    
    _discount = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right +15, 106, SCREEM_WIDTH - _imgView.right - 30, 25)];
    _discount.font = FONT18;
    _discount.textColor = RGB(248, 127, 126);
    [self.contentView addSubview:_discount];
    
    _btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 80, _imgView.bottom - 25, 65, 24)];
    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btn.titleLabel.font = FONT12;
    [_btn setTitle:@"联系商家" forState:UIControlStateNormal];
    [_btn setTitle:@"已完成" forState:UIControlStateSelected];
    _btn.backgroundColor = MAINCOLOR;
    
    [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    _btn.layer.masksToBounds = YES;
    _btn.layer.cornerRadius = 5;
    _btn.layer.borderWidth = 0.5;
    _btn.layer.borderColor = MAINCOLOR.CGColor;
    
    [self.contentView addSubview:_btn];
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH, 146);
}


- (void)btnAction {
    
    if(_phoneBlock != nil){
        _phoneBlock();
    }
}




- (void)dataWithModel:(OrderModel*)model   {
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.imageurl]];
    
    _orderNum.text = [NSString stringWithFormat:@"预约号：%@",model.serialnumber];//@"预约号：5678945678954567";
    _orderName.text = model.shopname;
    
    _orderName.frame = CGRectMake(_imgView.right +15, 55, SCREEM_WIDTH - _imgView.right - 30, 38);
    [_orderName sizeToFit];
    
    _date.text = [NSString stringWithFormat:@"预约时间：%@",model.startdate];
    
    
    if(model.selTag == 3){
        _discount.attributedText = [self setTitle:model.discount status:model.status];
    }
    else {
        _discount.attributedText = [self setTitle:[NSString stringWithFormat:@"￥%@",model.orderprice] status:model.status];
    }
    
}



- (NSAttributedString *)setTitle:(NSString *)title status:(NSString *)status {
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]init];
    
    NSDictionary * attributes1 = @{NSFontAttributeName:FONT14,NSForegroundColorAttributeName:RGB(247, 124, 126)};
    NSDictionary * attributes2 = @{NSFontAttributeName:FONT(9),NSForegroundColorAttributeName:RGB(247, 124, 126)};
    
    NSAttributedString *attr1 = [[NSAttributedString alloc]initWithString:title attributes:attributes1];
    NSAttributedString *attr = [[NSAttributedString alloc]initWithString:@"  " attributes:attributes1];
    NSAttributedString *attr2 = [[NSAttributedString alloc]initWithString:status attributes:attributes2];
    
    [attrStr appendAttributedString:attr1];
    [attrStr appendAttributedString:attr];
    [attrStr appendAttributedString:attr2];
    
    return attrStr;
}











@end
