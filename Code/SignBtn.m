//
//  SignBtn.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/20.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "SignBtn.h"

@implementation SignBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    [self setBackgroundImage:[UIImage imageNamed:@"sign_bg_n"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"sign_btn_n"] forState:UIControlStateNormal];
    
    [self setBackgroundImage:[UIImage imageNamed:@"sign_bg_s"] forState:UIControlStateSelected];
    [self setImage:[UIImage imageNamed:@"sign_btn_s"] forState:UIControlStateSelected];
    
    
    [self creatView];
    
    return self;
}


- (void)creatView {
    
    _mark = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    _mark.textAlignment = NSTextAlignmentCenter;
    _mark.font = FONT10;
    _mark.textColor = RGB(153, 109, 22);
    [self addSubview:_mark];
    
    CGFloat scale = 0.7;
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height*scale, self.width, self.height *(1-scale))];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = FONT(9*(SCREEM_WIDTH/375));
    _label.textColor = RGB(153, 109, 22);
    [self addSubview:_label];
    
    CGFloat www = self.width *0.78 /2;
    [self setImageEdgeInsets:UIEdgeInsetsMake(self.height/2 - www, self.width/2 - www, self.height/2 - www, self.width/2 - www)];
    
    
}



- (void)dataWithModel:(SignModel*)model {
    
    self.selected = [model.issign boolValue];
}


@end
