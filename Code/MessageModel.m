//
//  MessageModel.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/12.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel



- (instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [super initWithDict:dict];


    self.Id = DictStr(dict, @"id");
    self.title = DictStr(dict, @"title");
    self.imageurl = DictStr(dict, @"imageurl");
    self.contents = DictStr(dict, @"contents");
    self.date = DictStr(dict, @"date");
    self.url = DictStr(dict, @"url");
    self.content = DictStr(dict, @"content");
    
    
    return self;
}

@end
