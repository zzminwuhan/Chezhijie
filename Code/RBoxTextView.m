//
//  RBoxTextView.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/27.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "RBoxTextView.h"

@interface RBoxTextView ()

@property (nonatomic ,strong)UILabel *lineTop;
@property (nonatomic ,strong)UILabel *lineBottom;

@end

@implementation RBoxTextView

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
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEM_WIDTH - 30, self.height)];
    _title.textColor = RGB(50, 50, 50);
    _title.font = FONT14;
    [self addSubview:_title];
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(120, 0, SCREEM_WIDTH - 130, self.height)];
    
    _textField.textColor = RGB(50, 50, 50);
    _textField.font = FONT14;
    [self addSubview:_textField];
    
    _lineTop = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 0.5)];
    _lineTop.backgroundColor = RGB(200, 200, 200);
    [self addSubview:_lineTop];
    
}


- (void)setBottom {
    
    _lineBottom = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height , SCREEM_WIDTH, 0.5)];
    _lineBottom.backgroundColor = RGB(200, 200, 200);
    [self addSubview:_lineBottom];
}




@end
