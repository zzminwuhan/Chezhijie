//
//  InfoCarsTableViewCell.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/9.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "InfoCarsTableViewCell.h"


@interface InfoCarsTableViewCell ()

@property (nonatomic ,strong)UILabel *title;
@property (nonatomic ,strong)UILabel *detail;

@property (nonatomic ,strong)UIButton *btn3;
@property (nonatomic ,strong)UIButton *btn2;


@end


@implementation InfoCarsTableViewCell

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
    
    CGFloat h = 84;
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH, h+10);
    
    _btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, h/2 - 20, 40, 40)];
    [_btn1 setImage:[UIImage imageNamed:@"btn_usel"] forState:UIControlStateNormal];
    [_btn1 setImage:[UIImage imageNamed:@"img_reg"] forState:UIControlStateSelected];

    [self.contentView addSubview:_btn1];
    
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(_btn1.right, h/2 - 30, SCREEM_WIDTH - _btn1.right - 20, 30)];
    _title.font = FONT14;
    _title.textColor = RGB(32, 32, 32);
    [self.contentView addSubview:_title];
    
    
    _detail = [[UILabel alloc]initWithFrame:CGRectMake(_btn1.right, h/2, SCREEM_WIDTH - _btn1.right - 20, 30)];
    _detail.font = FONT14;
    _detail.textColor = RGB(150, 150, 150);
    [self.contentView addSubview:_detail];
    
    
    _btn2 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 50, h/2 - 20, 40, 40)];
    
    [_btn2 setImage:[UIImage imageNamed:@"car_del"] forState:UIControlStateNormal];
    [self.contentView addSubview:_btn2];
    
    
    _btn3 = [[UIButton alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 90, h/2 - 20, 40, 40)];
    [_btn3 setImage:[UIImage imageNamed:@"car_edit"] forState:UIControlStateNormal];
    [self.contentView addSubview:_btn3];
    
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 100, h/2 - 25, 0.5, 50)];
    line.backgroundColor = RGB(200, 200, 200);
    [self.contentView addSubview:line];
    
    
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, h, SCREEM_WIDTH, 10)];
    line2.backgroundColor = RGB(240, 240, 240);
    [self.contentView addSubview:line2];
    
    
    [_btn2 addTarget:self action:@selector(delBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_btn3 addTarget:self action:@selector(editBtnAction) forControlEvents:UIControlEventTouchUpInside];
}



- (void)editBtnAction {
    
    if(_editBlock != nil){
        _editBlock();
    }
}


- (void)delBtnAction {
    
    if(_delBlock != nil){
        _delBlock();
    }
}



- (void)dataWithModel:(CarModel*)model{
    
    _title.text = [NSString stringWithFormat:@"%@· %@",model.carbrand,model.carnumber];
    
    _detail.text = [NSString stringWithFormat:@"%@  %@",model.carmodel,model.cardate];
    
}


@end
