//
//  OrderModel.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/12.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BaseModel.h"

#import "CarModel.h"

@interface OrderModel : BaseModel

@property (nonatomic ,strong)NSString *Id;
@property (nonatomic ,strong)NSString *imageurl;
@property (nonatomic ,strong)NSString *serialnumber;
@property (nonatomic ,strong)NSString *shopname;
@property (nonatomic ,strong)NSString *startdate;
@property (nonatomic ,strong)NSString *orderprice;
@property (nonatomic ,strong)NSString *mobile;
@property (nonatomic ,strong)NSString *payway;
@property (nonatomic ,strong)NSString *status;
@property (nonatomic ,strong)NSString *discount;

@property (nonatomic ,strong)NSString *code;
@property (nonatomic ,strong)NSString *address;

@property (nonatomic ,strong)CarModel *car;

@property (nonatomic ,assign)NSInteger selTag;


@property (nonatomic ,strong)NSString *yhcate;
@property (nonatomic ,strong)NSString *njtype;


- (NSAttributedString *)xiaofeiCode;

- (void)detailWithDict:(NSDictionary*)dict ;

@end
