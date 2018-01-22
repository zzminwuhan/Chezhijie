//
//  GiftRecordModel.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/28.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "GiftRecordModel.h"

@implementation GiftRecordModel


- (instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [super initWithDict:dict];
    
    _Id = DictStr(dict, @"id");
    _prizename = DictStr(dict, @"prizename");
    _prizeimgurl = DictStr(dict, @"prizeimgurl");
    _orderdate = DictStr(dict, @"orderdate");
    _status = DictStr(dict, @"status");
    
    
    return self;
}


@end
