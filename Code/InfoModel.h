//
//  InfoModel.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/20.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BaseModel.h"

@interface InfoModel : BaseModel

@property (nonatomic ,strong)NSString *title;
@property (nonatomic ,strong)NSString *imgName;


+ (InfoModel*)modelTitle:(NSString*)title img:(NSString*)imgName ;

@end
