//
//  NJCarView.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/10.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "NJCarView.h"


@interface NJCarView ()

@property (nonatomic ,strong)UILabel *label1;
@property (nonatomic ,strong)UILabel *label2;
@property (nonatomic ,strong)UILabel *label3;
//@property (nonatomic ,strong)UILabel *label4;


@end

@implementation NJCarView

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
    
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    img.image = [UIImage imageNamed:@"car_bg"];
    [self addSubview:img];
    
    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, self.width - 30, self.height*0.73 )];
    _label1.numberOfLines = 2;
    _label1.textColor = [UIColor whiteColor];
    [self addSubview:_label1];
    
    _label2 = [[UILabel alloc]initWithFrame:CGRectMake(15, _label1.bottom, self.width - 30, self.height*0.28 )];
    _label2.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_label2];
    _label2.textColor = [UIColor whiteColor];
    _label2.font = FONT(9);
    
    _label3 = [[UILabel alloc]initWithFrame:CGRectMake(15, _label1.bottom, self.width - 30, self.height*0.28 )];
    _label3.textAlignment = NSTextAlignmentRight;
    [self addSubview:_label3];
    _label3.textColor = [UIColor whiteColor];
    _label3.font = FONT(9);
    
}



- (void)dataWithModel:(CarModel*)model {
    
    if(model == nil){
        return;
    }
//    _label1.text = [NSString stringWithFormat:@"沪C.88888\n后四位18763"];
    
    _label2.text = [NSString stringWithFormat:@"%@：%@",model.contactname ,model.contactmobile];
    
    _label3.text = [NSString stringWithFormat:@"%@ %@",model.carbrand ,model.cardate];
    
    _label1.attributedText = [self setWithModel:model];
}


- (NSAttributedString *)setWithModel:(CarModel*)model {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;// 字体的行间距
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]init];
    
    
    NSDictionary * attributes1 = @{NSFontAttributeName:FONT16,NSForegroundColorAttributeName:[UIColor whiteColor] , NSParagraphStyleAttributeName:paragraphStyle};
    NSDictionary * attributes2 = @{NSFontAttributeName:FONT(9),NSForegroundColorAttributeName:[UIColor whiteColor] , NSParagraphStyleAttributeName:paragraphStyle};
    
    NSString * text = [NSString stringWithFormat:@"%@\n",model.carnumber];
    NSAttributedString *attr1 = [[NSAttributedString alloc]initWithString:text attributes:attributes1];
    NSString * text2 = [NSString stringWithFormat:@"后四位 %@\n",model.framenumber];
    NSAttributedString *attr2 = [[NSAttributedString alloc]initWithString:text2 attributes:attributes2];
    
    [attrStr appendAttributedString:attr1];
    [attrStr appendAttributedString:attr2];
    
    return attrStr;
}


@end
