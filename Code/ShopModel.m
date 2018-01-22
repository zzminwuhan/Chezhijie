//
//  ShopModel.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/25.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "ShopModel.h"

@implementation ShopModel


- (instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [super initWithDict:dict];

    self.Id = DictStr(dict, @"id");
    self.address = DictStr(dict, @"address");
    self.imgurl = DictStr(dict, @"imgurl");
    self.imageurl = DictStr(dict, @"imageurl");
    self.mobile = DictStr(dict, @"mobile");
    self.name = DictStr(dict, @"name");
    self.price = DictStr(dict, @"price");
    
    self.url = DictStr(dict, @"url");
    self.discount = DictStr(dict, @"discount");
    
    self.desc = DictStr(dict, @"description");
    

    return self;
}


@end
