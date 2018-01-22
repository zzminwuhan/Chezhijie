//
//  HDQMenuView.m
//  TongHuaLi
//
//  Created by 李加建 on 2017/7/15.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import "HDQMenuView.h"


@interface HDQMenuView ()

@property (nonatomic ,strong)NSMutableArray *btnArray;
@property (nonatomic ,strong)UIButton *selBtn;

@property (nonatomic ,strong)UILabel *line ;

@end

@implementation HDQMenuView

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
    
    return self;
}



- (void)setTitleArray:(NSArray *)titleArray {
    
    _titleArray = titleArray;
 
    [self creatView];
}



- (void)creatView {
    
    _btnArray = [NSMutableArray array];
    CGFloat width = SCREEM_WIDTH/_titleArray.count;
    
    for(int i=0;i<_titleArray.count;i++){
        
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(width*i, 0, width, self.height)];
        
        [btn setTitleColor:RGB(50, 50, 50) forState:UIControlStateNormal];
        [btn setTitleColor:MAINCOLOR forState:UIControlStateSelected];
        btn.titleLabel.font = FONT(14);
        [btn setTitle:_titleArray[i] forState:UIControlStateNormal];
//        [btn setTitleEdgeInsets:UIEdgeInsetsMake(RECTPX(31), 0, RECTPX(23), 0)];
        
        [self addSubview:btn];
        [_btnArray addObject:btn];
        
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height - 0.5, SCREEM_WIDTH, 0.5)];
    line.backgroundColor = GRAY200;
    [self addSubview:line];
    
    
    UIButton *btn = _btnArray[0];
    
    _line = [[UILabel alloc]initWithFrame:CGRectMake(btn.left + 30, self.height - 2, btn.width - 60, 2)];
    _line.backgroundColor = MAINCOLOR;
    [self addSubview:_line];
    
}



- (void)btnAction:(UIButton*)btn {
    
    _selBtn.selected = NO;
    _selBtn = btn;
    _selBtn.selected = YES;
    
    NSInteger tag = [_btnArray indexOfObject:btn];
    
    if(_BtnSelWithTag != nil){
        _BtnSelWithTag(tag);
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _line.frame = CGRectMake(btn.left + 30, self.height - 2, btn.width - 60, 2);
    }];
    
}




@end
