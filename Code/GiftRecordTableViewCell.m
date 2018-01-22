//
//  GiftRecordTableViewCell.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/26.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "GiftRecordTableViewCell.h"


@interface GiftRecordTableViewCell ()

@property (nonatomic ,strong)UIImageView *imgView;

@property (nonatomic ,strong)UILabel *label;

@property (nonatomic ,strong)UILabel *detail;

@property (nonatomic ,strong)UILabel *date;

@property (nonatomic ,strong)UILabel *line1;

@property (nonatomic ,strong)UILabel *line2;

@property (nonatomic ,strong)UIButton *btn;

@end

@implementation GiftRecordTableViewCell

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
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right +15, 10, SCREEM_WIDTH - _imgView.right - 30, 38)];
    _label.textColor = RGB(25, 25, 25);
    _label.numberOfLines = 2;
    [self.contentView addSubview:_label];
    _label.font = FONT14;
    
    _date = [[UILabel alloc]initWithFrame:CGRectMake(_imgView.right +15, 48, SCREEM_WIDTH - _imgView.right - 30, 25)];
    _date.font = FONT11;
    _date.textColor = RGB(150, 150, 150);
    [self.contentView addSubview:_date];
    
    
    
    _line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, _imgView.bottom +10, SCREEM_WIDTH, 0.5)];
    _line1.backgroundColor = RGB(200, 200, 200);
    [self.contentView addSubview:_line1];
    
    
    _btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 80, _line1.bottom + 10, 65, 24)];
    [_btn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    _btn.titleLabel.font = FONT12;
    [_btn setTitle:@"确认收货" forState:UIControlStateNormal];

    _btn.layer.masksToBounds = YES;
    _btn.layer.cornerRadius = 5;
    _btn.layer.borderWidth = 0.5;
    _btn.layer.borderColor = MAINCOLOR.CGColor;
    
    [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:_btn];
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH, _line1.bottom + 44);
    
}

- (void)btnAction {
    
    if(_downBlock != nil){
        _downBlock();
    }
}


- (void)dataWithModel:(GiftRecordModel*)model {
    
   
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.prizeimgurl]];
    
    _label.text = model.prizename;
    
    _date.text = model.orderdate;
    
    NSInteger tag = [model.status integerValue];
    
    if(tag == 2){
        
        [_btn setTitle:@"确认收货" forState:UIControlStateNormal];
        _btn.layer.borderColor = MAINCOLOR.CGColor;
        [_btn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    }
    else if (tag == 3){
        [_btn setTitle:@"已完成" forState:UIControlStateNormal];
        _btn.layer.borderColor = RGB(200, 200, 200).CGColor;
        [_btn setTitleColor:RGB(200, 200, 200) forState:UIControlStateNormal];
    }
    else {
        [_btn setTitle:@"未发货" forState:UIControlStateNormal];
        _btn.layer.borderColor = RGB(250, 127, 124).CGColor;
        [_btn setTitleColor:RGB(250, 127, 124) forState:UIControlStateNormal];
    }
    
}

@end
