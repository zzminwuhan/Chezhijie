//
//  ShopModel.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/25.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BaseModel.h"

@interface ShopModel : BaseModel

@property (nonatomic ,strong)NSString *Id;
@property (nonatomic ,strong)NSString *address;
@property (nonatomic ,strong)NSString *imgurl;
@property (nonatomic ,strong)NSString *imageurl;

@property (nonatomic ,strong)NSString *mobile;
@property (nonatomic ,strong)NSString *name;
@property (nonatomic ,strong)NSString *price;

@property (nonatomic ,strong)NSString *cateid;

@property (nonatomic ,strong)NSString *cateType;

@property (nonatomic ,strong)NSString *url;
@property (nonatomic ,strong)NSString *discount;

@property (nonatomic ,strong)NSString *zhonglei;

@property (nonatomic ,strong)NSString *startdate;

@property (nonatomic ,strong)NSString *serialnumber;
@property (nonatomic ,assign)NSInteger payType;

#pragma mark 汽车商品属性
@property (nonatomic ,strong)NSString *carname;
@property (nonatomic ,strong)NSString * desc;

@property (nonatomic ,strong)NSString *type;
@property (nonatomic ,strong)NSString *contactname;
@property (nonatomic ,strong)NSString *contactmobile;
@property (nonatomic ,strong)NSString *city;

@end
