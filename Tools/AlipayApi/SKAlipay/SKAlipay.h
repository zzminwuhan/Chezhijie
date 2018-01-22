//
//  SKAlipay.h
//  AiShang
//
//  Created by yuyue on 16/12/7.
//  Copyright © 2016年 incredibleRon. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "Order.h"

@interface SKAlipay : NSObject


/**
 *处理支付宝 通过URL启动第三方应用时传递的数据
 
 *需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用
 @param url 启动第三方应用的URL
 
 */
+  (void)handleOpenURL:(NSURL *)url ;



+ (Order *)orderWithtradeNO:(NSString *)tradeNO money:(NSString *)money name:(NSString*)name detail:(NSString*)detail  ;


+ (void)aliSDKPay:(Order *)newOrder  completion:(void (^)(NSDictionary* dict))handler ;


/**
 *处理支付宝 本地签名
 

 @param dict 签名所需数据
 @param handler 支付完成回调 Block
 
 */

+ (void)aliPayWithDict:(NSDictionary *)dict completion:(void (^)(NSDictionary* dict))handler ;


@end
