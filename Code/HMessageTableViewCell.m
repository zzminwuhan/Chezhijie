//
//  HMessageTableViewCell.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/26.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "HMessageTableViewCell.h"



@interface HMessageTableViewCell ()

@property (nonatomic ,strong)UILabel *label;

@property (nonatomic ,strong)UILabel *detail;

@property (nonatomic ,strong)UILabel *date;

@property (nonatomic ,strong)UILabel *line1;

@property (nonatomic ,strong)UILabel *line2;

@property (nonatomic ,strong)UIButton *btn;

@end

@implementation HMessageTableViewCell

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
    
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, SCREEM_WIDTH - 30, 20)];
    _label.textColor = RGB(25, 25, 25);
    _label.font = FONT14;
    [self.contentView addSubview:_label];
    
    
    _detail = [[UILabel alloc]initWithFrame:CGRectMake(15, 40, SCREEM_WIDTH - 30, 20)];
    _detail.font = FONT12;
    _detail.numberOfLines = 0;
    _detail.textColor = RGB(150, 150, 150);
    [self.contentView addSubview:_detail];
    
    
    _line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, _detail.bottom +10, SCREEM_WIDTH, 0.5)];
    _line1.backgroundColor = RGB(200, 200, 200);
    [self.contentView addSubview:_line1];
    
    _date = [[UILabel alloc]initWithFrame:CGRectMake(15, _line1.bottom +5, SCREEM_WIDTH - 30, 20)];
    _date.font = FONT11;
    _date.textColor = RGB(150, 150, 150);
    [self.contentView addSubview:_date];
    
    _line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, _date.bottom + 5 , SCREEM_WIDTH, 10)];
    _line2.backgroundColor = RGB(240, 240, 240);
    [self.contentView addSubview:_line2];
    
    _btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 80, _line1.bottom, 70, 30)];
    [_btn setTitleColor:RGB(150, 150, 150) forState:UIControlStateNormal];
    _btn.titleLabel.font = FONT12;
    [_btn setTitle:@"查看详情" forState:UIControlStateNormal];
    [_btn setImage:[UIImage imageNamed:@"mark_right"] forState:UIControlStateNormal];
    
    UIButton *btn = _btn;
    
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -btn.imageView.frame.size.width-10, 0, btn.imageView.frame.size.width)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, btn.titleLabel.frame.size.width, 0, -btn.titleLabel.frame.size.width)];
    
    [self.contentView addSubview:_btn];
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH, _line2.bottom);
}



- (void)dataWithModel:(MessageModel*)model {
    
    _label.text = model.title;
    
    _detail.text = model.content;
    
    _date.text = model.date;
    
    _detail.frame = CGRectMake(15, 40, SCREEM_WIDTH - 30, 20);
    [_detail sizeToFit];
    
    _line1.frame = CGRectMake(0, _detail.bottom +10, SCREEM_WIDTH, 0.5);
    
    _date.frame = CGRectMake(15, _line1.bottom +5, SCREEM_WIDTH - 30, 20);
    
    _btn.frame = CGRectMake(SCREEM_WIDTH - 80, _line1.bottom, 70, 30);
    
    _line2.frame = CGRectMake(0, _date.bottom +5, SCREEM_WIDTH, 10);
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH, _line2.bottom);
}


@end
