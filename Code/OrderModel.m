//
//  OrderModel.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/12.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel


- (instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [super initWithDict:dict];
    
    
    self.Id = DictStr(dict, @"id");
    self.imageurl = DictStr(dict, @"imageurl");
    self.serialnumber = DictStr(dict, @"serialnumber");
    self.shopname = DictStr(dict, @"shopname");
    self.startdate = DictStr(dict, @"startdate");
    
    self.orderprice = DictStr(dict, @"orderprice");
    self.mobile = DictStr(dict, @"mobile");
    self.payway = DictStr(dict, @"payway");
    self.status = DictStr(dict, @"status");
    
    self.discount = DictStr(dict, @"discount");
    
    return self;
}



- (void)detailWithDict:(NSDictionary*)dict {
    
    _car = [[CarModel alloc]initWithDict:dict];
    
    _code = DictStr(dict, @"code");
    _address = DictStr(dict, @"address");
    
    _yhcate = DictStr(dict, @"yhcate");
    _njtype = DictStr(dict, @"njtype");
    
//    self.orderprice = DictStr(dict, @"orderprice");
//    self.mobile = DictStr(dict, @"mobile");
//    self.payway = DictStr(dict, @"payway");
//    self.status = DictStr(dict, @"status");
//    self.discount = DictStr(dict, @"discount");
//    
//    self.Id = DictStr(dict, @"id");
//    self.imageurl = DictStr(dict, @"imageurl");
//    self.serialnumber = DictStr(dict, @"serialnumber");
//    self.shopname = DictStr(dict, @"shopname");
//    self.startdate = DictStr(dict, @"startdate");
    
}



- (NSAttributedString *)xiaofeiCode {
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]init];
    
    
//    NSDictionary * attributes1 = @{NSFontAttributeName:FONT14,NSForegroundColorAttributeName:RGB(248, 127, 126)};
    
    NSDictionary * attributes = @{NSFontAttributeName:FONT14,NSForegroundColorAttributeName:RGB(50, 50, 50)};
    NSDictionary * attributes2 = @{NSFontAttributeName:FONT10,NSForegroundColorAttributeName:RGB(247, 124, 126)};
    
    NSAttributedString *attr1 = [[NSAttributedString alloc]initWithString:@"消费码：" attributes:attributes];
    NSAttributedString *attr2 = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@  ",self.code] attributes:attributes];
    
    NSAttributedString *attr3 = [[NSAttributedString alloc]initWithString:self.status attributes:attributes2];
    
    [attrStr appendAttributedString:attr1];
    [attrStr appendAttributedString:attr2];
    [attrStr appendAttributedString:attr3];
    
    return attrStr;
}


@end
