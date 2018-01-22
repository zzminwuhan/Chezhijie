//
//  AlipayManager.m
//  Aladdin
//
//  Created by yuyue on 2017/3/15.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import "AlipayManager.h"


#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "APAuthV2Info.h"

#import "SKShareText.h"

#define ApiURL @"http://118.178.94.156:8103/"

#import "Order.h"


@implementation AlipayManager


/*
 *! @brief 处理支付宝通过URL启动App时传递的数据
 * 需要在 application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用。
 * @param url 支付宝启动第三方应用时传递过来的URL
 
 */
+  (void)handleOpenURL:(NSURL *)url {
    
    //    跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        NSLog(@"result = %@",resultDic);
        
    }];
    
}



/**
 *  支付接口
 *
 *  @param dict       订单信息
 *
 *  @param compltionBlock 支付结果回调Block
 */
+ (void) aliPayWithDict:(NSDictionary *)dict completion:(void (^)(NSDictionary* dict))handler {
    
    
    Order *order = [[Order alloc] init];
    order.partner = dict[@"partner"];
    order.seller = dict[@"seller"];
    
    order.tradeNO = dict[@"tradeNO"]; //订单ID（由商家自行制定）
    order.productName = dict[@"productName"];   //商品标题
    order.productDescription = dict[@"productDescription"];  //商品描述
    order.amount = dict[@"amount"]; ;  //商品价格
    order.notifyURL = dict[@"notifyURL"];
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //    order.service = dict[@"service"];
    //    order.paymentType = dict[@"payment_type"];
    //    order.inputCharset = dict[@"_input_charset"];
    //    order.itBPay = dict[@"it_b_pay"];
    //    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme =  @"aladdin2017" ;
    
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    NSString * privateKey ;
    privateKey = dict[@"privateKey"];
    
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    
    NSString *signedString = [signer signString:orderSpec];
    
    
    //    NSString *signedString = dict[@"sign"];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    NSLog(@"reslut = %@",signedString);
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            NSLog(@"reslut = %@",resultDic);
            
            if([resultDic[@"resultStatus"] integerValue]==9000)
            {
                handler(resultDic);
            }
           
            
        }];
        
    }
    
    
}


+ (void)alipaySign:(NSString*)sign completion:(void (^)(NSDictionary* dict))handler {
    
    
    NSString *appScheme =  @"chezhijie" ;
    
    [[AlipaySDK defaultService] payOrder:sign fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        
        NSLog(@"reslut = %@",resultDic);
        
        if([resultDic[@"resultStatus"] integerValue]==9000)
        {
            handler(resultDic);
        }
        
        
    }];
}







@end
