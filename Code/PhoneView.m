//
//  PhoneView.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/26.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "PhoneView.h"

@interface PhoneView ()

@property (nonatomic ,strong)NSString *phone ;

@property (nonatomic ,strong)UILabel *label ;

@property (nonatomic ,strong)UIView *customView;

@end

@implementation PhoneView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (void )showInWindowWithPhone:(NSString*)phone {
    
    PhoneView * phoneView = [[PhoneView alloc]initWithFrame:SCREEM ];
    phoneView.phone = phone;
    
    phoneView.label.text = phone;
    
    [[UIApplication sharedApplication].keyWindow addSubview:phoneView];
    
    [phoneView showAnnimation];
}

+ (void )showInWindowWithPhone2:(NSString*)phone {
    
    PhoneView * phoneView = [[PhoneView alloc]initWithFrame:SCREEM ];
    phoneView.phone = phone;
    
    phoneView.label.text = phone;
    phoneView.title.text = @"呼叫客服";
    
    [[UIApplication sharedApplication].keyWindow addSubview:phoneView];
    
    [phoneView showAnnimation];
}




- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    [self creatView];
    
    return self;
}


- (void)creatView {
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT)];
    bgView.backgroundColor = RGBA(0, 0, 0, 0.5);
    [self addSubview:bgView];
    
    UIView *popView = [[UIView alloc]init];
    
    popView.frame = CGRectMake(SCREEM_WIDTH/2-120, SCREEM_HEIGHT/2-80, 240, 160);
//    popView.endFrame = CGRectMake(RECTPX(135), RECTPX(460), RECTPX(480), RECTPX(320));
    popView.layer.cornerRadius = 5;
    popView.layer.masksToBounds = YES;
    popView.backgroundColor = [UIColor whiteColor];
    [self addSubview:popView];
    
    self.customView = popView;
    
    
    CGFloat popWidth = popView.width;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, popWidth, 40)];
    label.backgroundColor = MAINCOLOR;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = FONT(15);
    label.textColor = [UIColor whiteColor];
    label.text = @"联系商家";
    [popView addSubview:label];
    self.title = label;
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, popWidth, 80)];
    label2.backgroundColor = [UIColor whiteColor];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = FONT(15);
    label2.textColor = MAINCOLOR ;
//    label2.text = @"400 8971 2341";
    [popView addSubview:label2];
    
    self.label = label2;
    
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 120, popWidth/2, 40)];
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    [btn1 setTitleColor:RGB(150, 150, 150) forState:UIControlStateNormal];
    btn1.titleLabel.font = FONT(14);
    [popView addSubview:btn1];
    
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(popWidth/2, 120, popWidth/2, 40)];
    [btn2 setTitle:@"确定" forState:UIControlStateNormal];
    [btn2 setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    btn2.titleLabel.font = FONT(14);
    [popView addSubview:btn2];
    
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 120, popWidth, 0.5)];
    line1.backgroundColor = GRAY200;
    [popView addSubview:line1];
    
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(popWidth/2, 120-0.25, 0.5, 40)];
    line2.backgroundColor = GRAY200;
    [popView addSubview:line2];
    
    [btn1 addTarget:self action:@selector(btn3Action) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(btn4Action) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btn3Action {
    
    NSLog(@"del");
    
    [self removeFromSuperview];
}

- (void)btn4Action {

    NSString* str=[[NSString alloc]initWithFormat:@"telprompt:%@",self.phone];
    NSLog(@"str======%@",self.phone);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
 
    
    [self removeFromSuperview];
}



- (void)showAnnimation {
    
    
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    NSArray *animArr = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                         [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    
    popAnimation.duration = 0.4;
    popAnimation.values = animArr;
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.customView.layer addAnimation:popAnimation forKey:nil];
}




@end
