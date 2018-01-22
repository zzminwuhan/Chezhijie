//
//  MessageModel.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/12.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BaseModel.h"

@interface MessageModel : BaseModel

@property (nonatomic ,strong) NSString * Id;
@property (nonatomic ,strong) NSString * title;
@property (nonatomic ,strong) NSString * imageurl;
@property (nonatomic ,strong) NSString * contents;
@property (nonatomic ,strong) NSString * content;
@property (nonatomic ,strong) NSString * date;
@property (nonatomic ,strong) NSString * url;


@end
