//
//  SKShareView.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/28.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "SKShareView.h"

#import "SKShare.h"

@interface SKShareView ()

@property (nonatomic ,strong)UIView *customView;


@property (nonatomic ,strong)UIButton *dateBtn;

@property (nonatomic ,copy)SKShareBlock shareBlock;

@end


@implementation SKShareView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/





+ (void)showInView:(UIView*)view  success:(SKShareBlock)success {
    
    SKShareView * popView = [[SKShareView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT)];
    popView.shareBlock = success;
    [view addSubview:popView];
    
    [popView show];
}



- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    [self creatView];
    
    return self;
}



- (void)bgTapAction {
    
    [self hide];
}

- (void)creatView {
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT)];
    bgView.backgroundColor = RGBA(0, 0, 0, 0.5);
    [self addSubview:bgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgTapAction)];
    
    [bgView addGestureRecognizer:tap];
    
    
    _customView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEM_HEIGHT, SCREEM_WIDTH, 120)];
    
    _customView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_customView];
    
    
    [self addCustomView];
}



- (void)addCustomView {
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 40)];
    btn.backgroundColor = RGB(200, 200, 200);
    [btn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [_customView addSubview:btn];
    
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSArray *array = @[@"share_btn_01",@"share_btn_02",@"share_btn_03",@"share_btn_04"];
    
    
    CGFloat x = 10;
    CGFloat w = (self.width -x*2)/4;
    
    for(int i=0;i<array.count;i++){
        
        UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(x+w*i, btn.bottom, w, _customView.height - btn.height)];
        
        [btn2 setImage:[UIImage imageNamed:array[i]] forState:UIControlStateNormal];
        [_customView addSubview:btn2];
        btn2.tag = 2000+i;
        [btn2 addTarget:self action:@selector(shareBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}



- (void)shareBtnAction:(UIButton*)btn {
    
    NSInteger tag = btn.tag - 2000;
 
    [SKShare SKShareWithTag:tag];
    
    [self hide];
    if(_shareBlock != nil){
        _shareBlock(tag);
    }
}



- (void)btnAction {
    
    [self hide];
}



- (void)show {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _customView.frame = CGRectMake(0, SCREEM_HEIGHT - _customView.height, SCREEM_WIDTH, _customView.height);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _customView.frame = CGRectMake(0, SCREEM_HEIGHT, SCREEM_WIDTH, _customView.height);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}





@end
