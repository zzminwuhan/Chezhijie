//
//  MessageTableViewCell.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/19.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "MessageTableViewCell.h"

@interface MessageTableViewCell ()

@property (nonatomic ,strong)UIView *customView;

@property (nonatomic ,strong)UIImageView *imgView;

@property (nonatomic ,strong)UILabel *name;

@property (nonatomic ,strong)UILabel *label;

@end

@implementation MessageTableViewCell

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
    
    CGFloat h = (SCREEM_WIDTH - 20)*(1/3.f) + 60;
    _customView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, SCREEM_WIDTH - 20, h)];
    _customView.layer.borderWidth = 0.5;
    _customView.layer.borderColor = RGB(200, 200, 200).CGColor;
    [self.contentView addSubview:_customView];
 
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH, h + 10);
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH - 20, h-60)];
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    _imgView.clipsToBounds = YES;
    [_customView addSubview:_imgView];
    
    
    _name = [[UILabel alloc]initWithFrame:CGRectMake(5, _imgView.bottom+10, SCREEM_WIDTH - 30, 20)];
    _name.font = FONT15;
    _name.textColor = RGB(50, 50, 50);
    [_customView addSubview:_name];
    
    
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(5, _imgView.bottom+35, SCREEM_WIDTH - 30, 20)];
    _label.font = FONT14;
    _label.textColor = RGB(150, 150, 150);
    [_customView addSubview:_label];

    [self dataWithModel:nil];
}


- (void)dataWithModel:(MessageModel*)model {
    
    _name.text = model.title;
    
    _label.text = model.contents;
        
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.imageurl]];
}


@end
