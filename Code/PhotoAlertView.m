//
//  PhotoAlertView.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/24.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "PhotoAlertView.h"


@interface PhotoAlertView ()

@property (nonatomic ,strong)UIView * customView;

@property (nonatomic ,copy)ActionBlock takePhotoBlock;
@property (nonatomic ,copy)ActionBlock getphotosBlock;

@end

@implementation PhotoAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



+ (void)showInView:(UIView*)view takePhoto:(ActionBlock)block1 getPhotos:(ActionBlock)block2 {
    
    
    PhotoAlertView *alert = [[PhotoAlertView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT)];
    
    alert.takePhotoBlock = block1;
    alert.getphotosBlock = block2;
    
    [view addSubview:alert];
 
    [alert show];
}




- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    [self creatView];
    
    return self;
}



- (void)bgTap {
    
    [self hide];
}


- (void)creatView {
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT)];
    
    bgView.backgroundColor = RGBA(0, 0, 0, 0.5);
    [self addSubview:bgView];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgTap)];
    
    [bgView addGestureRecognizer:tap];
    
    
    
    _customView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEM_HEIGHT, SCREEM_WIDTH, 44*3+5)];
    
    [self addSubview:_customView];
 
    CGFloat x = 30;
    
    CGFloat h = 44;
    
    UIView * btnView = [[UIView alloc]initWithFrame:CGRectMake(x, 0, SCREEM_WIDTH-x*2, h*2)];
    
    [_customView addSubview:btnView];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH - x*2, h)];
    [btn1 setTitle:@"照片" forState:UIControlStateNormal];
    [btn1 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    btn1.titleLabel.font = FONT(14);
    btn1.backgroundColor = [UIColor whiteColor];
    [btnView addSubview:btn1];
    
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, h, SCREEM_WIDTH - x*2, h)];
    [btn2 setTitle:@"相机" forState:UIControlStateNormal];
    [btn2 setTitleColor:RGB(150, 150, 150) forState:UIControlStateNormal];
    btn2.titleLabel.font = FONT(14);
    btn2.backgroundColor = [UIColor whiteColor];
    [btnView addSubview:btn2];
    
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH-x*2, 0.5)];
    line.backgroundColor = bgView.backgroundColor;
    [btn2 addSubview:line];
    
    
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(x, h*2+5, SCREEM_WIDTH - x*2, h)];
    [btn3 setTitle:@"取消" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn3.titleLabel.font = FONT(14);
    btn3.backgroundColor = MAINCOLOR;
    [_customView addSubview:btn3];
    
    [btn1 addTarget:self action:@selector(btn1Action) forControlEvents:UIControlEventTouchUpInside];
    
    [btn2 addTarget:self action:@selector(btn2Action) forControlEvents:UIControlEventTouchUpInside];
    
    [btn3 addTarget:self action:@selector(btn3Action) forControlEvents:UIControlEventTouchUpInside];
    
    
//    btn1.layer.masksToBounds = YES;
//    btn1.layer.cornerRadius = 4;
    btnView.layer.masksToBounds = YES;
    btnView.layer.cornerRadius = 4;
    btn3.layer.masksToBounds = YES;
    btn3.layer.cornerRadius = 4;
}




- (void)btn1Action {
    
    if(_getphotosBlock != nil){
        _getphotosBlock();
    }
    
    [self hide];
}

- (void)btn2Action {
    
    if(_takePhotoBlock != nil){
        _takePhotoBlock();
    }
    
    [self hide];
}

- (void)btn3Action {
    
    [self hide];
}



- (void)hide {
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _customView.frame = CGRectMake(0, SCREEM_HEIGHT, SCREEM_WIDTH, _customView.height);
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
    
}

- (void)show {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _customView.frame = CGRectMake(0, SCREEM_HEIGHT - _customView.height, SCREEM_WIDTH, _customView.height);
    } completion:^(BOOL finished) {
        
        
    }];
    
}


@end
