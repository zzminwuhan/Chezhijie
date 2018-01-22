//
//  CarModel.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/12.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BaseModel.h"

@interface CarModel : BaseModel

@property (nonatomic ,strong)NSString *Id;
@property (nonatomic ,strong)NSString *carbrand;
@property (nonatomic ,strong)NSString *carmodel;
@property (nonatomic ,strong)NSString *carnumber;
@property (nonatomic ,strong)NSString *cardate;

@property (nonatomic ,strong)NSString *contactname;
@property (nonatomic ,strong)NSString *contactmobile;
@property (nonatomic ,strong)NSString *framenumber;



- (void)detailWithDict:(NSDictionary*)dict ;

@end
