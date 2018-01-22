//
//  ICodeButton.m
//  AppONE
//
//  Created by yuyue on 15-11-24.
//  Copyright (c) 2015年 incredibleRon. All rights reserved.
//

#import "ICodeButton.h"


@interface ICodeButton ()

@property (nonatomic,strong)NSTimer*timer;

@property (nonatomic,assign)NSInteger count;

@property (nonatomic,strong)NSString*title;

@property (nonatomic,copy)DidClickBlock didClickBlcok;

@end

@implementation ICodeButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



+ (instancetype)viewWithFrame:(CGRect)frame text:(NSString*)text didClicked:(DidClickBlock)block {
    
    ICodeButton* btn = [[ICodeButton  alloc]initWithFrame:frame];
    
    btn.didClickBlcok = block ;
    btn.title = text ;
 
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = MAINCOLOR;
    btn.titleLabel.font = FONT(14);
    
//    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 1, CGRectGetHeight(btn.frame))];
//    line.backgroundColor = GRAY200;
//    [btn addSubview:line];
    
//    btn.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentRight ;
    
//    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}



- (id)initWithFrame:(CGRect)frame  {
    self = [super initWithFrame:frame];
    
    
    return self;
}


- (void)timeStart
{
    
    _count = 60;
    self.alpha = 0.5;
    self.userInteractionEnabled = NO;
    _title = self.titleLabel.text;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeData) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}


- (void)changeData
{
    
    if(_count>0)
    {
        _count --;

        NSString*time = [NSString stringWithFormat:@"%@重新发送",@(_count)];
        
        [self setTitle:time forState:UIControlStateNormal];
    }
    else
    {
        self.alpha = 1;
        self.userInteractionEnabled = YES;
        [_timer invalidate];
        [self setTitle:_title forState:UIControlStateNormal];
    }
    
}



- (void)btnAction:(ICodeButton*)btn {
    
    [btn timeStart];
    
    if(btn.didClickBlcok != nil){
        
        btn.didClickBlcok();
    }
}


@end
