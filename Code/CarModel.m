//
//  CarModel.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/12.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "CarModel.h"

@implementation CarModel


- (instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [super initWithDict:dict];
    
    
    self.Id = DictStr(dict, @"id");
    self.carbrand = DictStr(dict, @"carbrand");
    self.carmodel = DictStr(dict, @"carmodel");
    self.carnumber = DictStr(dict, @"carnumber");
    self.cardate = DictStr(dict, @"cardate");
    
    self.contactname = DictStr(dict, @"contactname");
    self.contactmobile = DictStr(dict, @"contactmobile");
    self.framenumber = DictStr(dict, @"framenumber");
    
    return self;
}


- (void)detailWithDict:(NSDictionary*)dict {
    
    
    self.carbrand = DictStr(dict, @"carbrand");
    self.carmodel = DictStr(dict, @"carmodel");
    self.carnumber = DictStr(dict, @"carnumber");
    self.cardate = DictStr(dict, @"cardate");
    
    self.contactname = DictStr(dict, @"contactname");
    self.contactmobile = DictStr(dict, @"contactmobile");
    self.framenumber = DictStr(dict, @"framenumber");
    
}



@end
