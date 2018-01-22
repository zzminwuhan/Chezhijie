//
//  InfoModel.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/20.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "InfoModel.h"

@implementation InfoModel



+ (InfoModel*)modelTitle:(NSString*)title img:(NSString*)imgName {
    
    InfoModel *model = [InfoModel new];
    
    model.title = title;
    model.imgName = imgName;
    
    return model;
}

@end
