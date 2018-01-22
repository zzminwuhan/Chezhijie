//
//  CategoryModel.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/15.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [super initWithDict:dict];
    
    self.Id = DictStr(dict, @"id");
    self.name = DictStr(dict, @"name");
    
    return self;
}

@end
