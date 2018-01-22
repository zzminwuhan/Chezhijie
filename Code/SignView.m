//
//  SignView.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/20.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "SignView.h"

#import <UIButton+WebCache.h>

@interface SignView ()

@property (nonatomic ,strong)SignBtn *winBtn;

@end


@implementation SignView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    [self creatView];
    
    return self;
}



- (void)creatView {
    
    self.btnsArray = [NSMutableArray array];
    
    CGFloat x = 1;
    CGFloat h = (self.height - x*3)/4;
    CGFloat w = (self.width - x*4)/5;
        
    for(int i=0;i<15;i++){
        
        SignBtn * btn = [[SignBtn alloc]initWithFrame:CGRectZero];
        
        [self addSubview:btn];
        
        btn.mark.text = [NSString stringWithFormat:@"%@",@(i+1)];
        btn.userInteractionEnabled = NO;
        
        [self.btnsArray addObject:btn];
        
        if(i <= 4){
            
            btn.frame = CGRectMake((x+w)*i, 0, w, h);
        }
        else if (i == 5){
            btn.frame = CGRectMake((x+w)*4, (h+x)*1, w, h);
        }
        else if (i == 6){
            btn.frame = CGRectMake((x+w)*4, (h+x)*2, w, h);
        }
        else if (i >= 7 && i<=11){
        
            btn.frame = CGRectMake((x+w)*(11-i), (h+x)*3, w, h);
        }
        else if (i == 12){
         
            btn.frame = CGRectMake((x+w)*0, (h+x)*2, w, h);
        }
        else if (i == 13){
            btn.frame = CGRectMake((x+w)*0, (h+x)*1, w, h);
        }
        else if (i == 14){
            
            btn.frame = CGRectMake((x+w)*1, (h+x)*1, (w+x)*2+w, (h+x)+h);
            
            
            CGFloat w = btn.height *0.6;
            CGFloat x = btn.width/2 - w/2;
            CGFloat y = btn.height/2 - w/2;
            
            btn.label.textColor = RGB(248, 127, 126);
            
            [btn setImageEdgeInsets:UIEdgeInsetsMake(y-5, x, y+5, x)];
            
            [btn setBackgroundImage:[UIImage imageNamed:@"sign_bg"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            
//            [btn setBackgroundImage:[UIImage imageNamed:@"sign_win_bg"] forState:UIControlStateNormal];
            
            [self creatWinBtnWithBtn:btn];

            
            btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
            btn.imageView.clipsToBounds = YES;
        }
        
        CGFloat scale = 0.7;
        btn.label.frame = CGRectMake(0, btn.height*scale, btn.width, btn.height *(1-scale));
        btn.label.text = [NSString stringWithFormat:@"还剩%@天",@(14-i)];
        
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}



- (void)creatWinBtnWithBtn:(UIButton*)btn {
    
    _winBtn = [[SignBtn alloc]initWithFrame:btn.frame];
    
    [_winBtn setBackgroundImage:[UIImage imageNamed:@"sign_win_bg"] forState:UIControlStateNormal];

    [_winBtn setImage:[UIImage imageNamed:@"sign_win"] forState:UIControlStateNormal];
    
    _winBtn.mark.text = [NSString stringWithFormat:@"%@",@(15)];
    
    _winBtn.label.center = CGPointMake(_winBtn.width/2, _winBtn.height/2+5);
    _winBtn.label.textColor = RGB(248, 127, 126);
    [self addSubview:_winBtn];
    
    [_winBtn addTarget:self action:@selector(winBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    _winBtn.hidden = YES;
    
}

- (void)winBtnAction {
    
    if(_winBlock != nil){
        _winBlock();
    }
}


- (void)btnAction:(SignBtn*)btn {
    
    NSInteger tag = [_btnsArray indexOfObject:btn];
    
    if(tag == 14){
        
    }
    else {
        
        if(_signBlock != nil){
            _signBlock();
        }
    }
}



- (void)dataWithArray:(NSMutableArray*)array {
    
    for(int i=0;i<array.count;i++){
        
        SignBtn *btn = _btnsArray[i];
        
        SignModel *model = array[i];
        btn.userInteractionEnabled = NO;
        [btn dataWithModel:model];
    }
    
    int sel = -1;
    for(int i=0;i<array.count;i++){
        
        SignModel *model = array[i];
        
        if([model.issign boolValue] == NO){
            sel = i;
            break;
        }
       
    }
    
    if(sel <= 14 && sel >=0){
        
        SignBtn *btn = _btnsArray[sel];
        btn.userInteractionEnabled = YES;
    }
   
    
    if(sel == -1){
        _winBtn.hidden = NO;
    }
    
}


- (void)dataWithDict:(NSDictionary*)dict {
    
    NSString *prizename = DictStr(dict, @"prizename");
    NSString *prizeimgurl = DictStr(dict, @"prizeimgurl");
    
    SignBtn *btn = _btnsArray[14];
    
    btn.label.text = prizename;
//    btn.label.textColor = RGB(248, 127, 126);
    
    _winBtn.label.text = prizename;
    
    [btn sd_setImageWithURL:[NSURL URLWithString:prizeimgurl] forState:UIControlStateNormal];
}




@end
