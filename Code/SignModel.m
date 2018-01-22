//
//  SignModel.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/28.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "SignModel.h"

@implementation SignModel


- (instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [super initWithDict:dict];
    
    self.issign = DictStr(dict, @"issign");
    self.number = DictStr(dict, @"number");
    self.surplus = DictStr(dict, @"surplus");
    
    return self;
}


@end
