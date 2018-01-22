//
//  ConfMacro.h
//  MBDemo
//
//  Created by yuyue on 2017/5/5.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#ifndef ConfMacro_h
#define ConfMacro_h



//服务器地址


#define HOST @"http://www.chezhijie.com.cn/"

#define HOSTAPIKEY(key) [HOST stringByAppendingString:key]

typedef void (^ActionBlock)();

#define DictStr(dict ,key) [NSString stringWithFormat:@"%@",(dict[key]==nil?@"":dict[key])]


// 颜色
#define GRAYCOLOR (RGB(240, 240, 240))

#define MAINCOLOR (RGB(41, 181, 235))


#endif /* ConfMacro_h */
