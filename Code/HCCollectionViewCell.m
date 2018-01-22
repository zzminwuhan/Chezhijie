//
//  HCCollectionViewCell.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/25.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "HCCollectionViewCell.h"


@interface HCCollectionViewCell ()

@property (nonatomic ,strong)CALayer * layerTop;
@property (nonatomic ,strong)CALayer * layerLeft;
@property (nonatomic ,strong)CALayer * layerBottom;
@property (nonatomic ,strong)CALayer * layerRight;




@end


@implementation HCCollectionViewCell



- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    [self setLayerBorder];
    
    return self;
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
}



- (void)setLayerBorder {
    
    CGFloat max = 1;
    UIColor *color = RGB(200, 200, 200);
    
    self.layerTop = [CALayer layer];
    self.layerTop.backgroundColor = color.CGColor;
    self.layerTop.frame = CGRectMake(0, 0, self.width, max);
    
    self.layerLeft = [CALayer layer];
    self.layerLeft.backgroundColor = color.CGColor;
    self.layerLeft.frame = CGRectMake(0, 0, max, self.height);
    
    self.layerBottom = [CALayer layer];
    self.layerBottom.backgroundColor = color.CGColor;
    self.layerBottom.frame = CGRectMake(0, self.height - max, self.width, max);
    
    self.layerRight = [CALayer layer];
    self.layerRight.backgroundColor = color.CGColor;
    self.layerRight.frame = CGRectMake(self.width - max, 0, max, self.height);
    
    
    [self.contentView.layer addSublayer:self.layerTop];
    [self.contentView.layer addSublayer:self.layerLeft];
    [self.contentView.layer addSublayer:self.layerBottom];
    [self.contentView.layer addSublayer:self.layerRight];
    
    
    CGFloat w = self.height/4;
    CGFloat h = self.height*0.2;
    CGFloat y = self.height/2 - w/2;
    CGFloat x = self.width/2 - w/2;
    
    CGRect rect1 = CGRectMake(0, y+w, self.width, h);
    CGRect rect2 = CGRectMake(x, y - h/2, w, w);
    
    _imgView = [[UIImageView alloc]initWithFrame:rect2];
//    _imgView.backgroundColor = [UIColor redColor];
    [self addSubview:_imgView];
    
    
    _title = [[UILabel alloc]initWithFrame:rect1];
    _title.textColor = RGB(50, 50, 50);
    _title.font = FONT14;
    _title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_title];
}



- (void)borderWithIndexPath:(NSIndexPath*)indexpath {
    
    
    NSInteger row = indexpath.row/3;
    
    if(row < 1){
        
        if(indexpath.row == 0){
            [self fullBorder];
        }
        else {
         
            [self leftBorder];
        }
    }
    else {
        
        NSInteger yu = indexpath.row%3;
        
        if(yu == 0){
            [self topBorder];
        }
        else {
            [self otherBorder];
        }
    }
    
}


- (void)fullBorder {
    
    self.layerTop.hidden = NO;
    self.layerLeft.hidden = NO;
    self.layerBottom.hidden = NO;
    self.layerRight.hidden = NO;
}

- (void)leftBorder {
 
    self.layerTop.hidden = NO;
    self.layerLeft.hidden = YES;
    self.layerBottom.hidden = NO;
    self.layerRight.hidden = NO;
}

- (void)topBorder {
 
    self.layerTop.hidden = YES;
    self.layerLeft.hidden = NO;
    self.layerBottom.hidden = NO;
    self.layerRight.hidden = NO;
}

- (void)otherBorder {
    
    self.layerTop.hidden = YES;
    self.layerLeft.hidden = YES;
    self.layerBottom.hidden = NO;
    self.layerRight.hidden = NO;
}





@end
