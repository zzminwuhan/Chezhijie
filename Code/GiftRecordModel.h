//
//  GiftRecordModel.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/28.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BaseModel.h"

@interface GiftRecordModel : BaseModel

@property (nonatomic ,strong)NSString *Id;
@property (nonatomic ,strong)NSString *prizeimgurl;
@property (nonatomic ,strong)NSString *prizename;
@property (nonatomic ,strong)NSString *orderdate;
@property (nonatomic ,strong)NSString *status;

@end
