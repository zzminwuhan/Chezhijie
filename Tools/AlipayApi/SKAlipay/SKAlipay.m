//
//  SKAlipay.m
//  AiShang
//
//  Created by yuyue on 16/12/7.
//  Copyright © 2016年 incredibleRon. All rights reserved.
//

#import "SKAlipay.h"

#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "APAuthV2Info.h"

#import "SKShareText.h"

#define ApiURL @"http://118.178.94.156:8103/"



@implementation SKAlipay





+  (void)handleOpenURL:(NSURL *)url {
    
    //    跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        NSLog(@"result = %@",resultDic);
        
    }];
    
}





+ (void)aliSDKPay:(Order *)newOrder  completion:(void (^)(NSDictionary* dict))handler

{
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = ALIpartner;
    NSString *seller = ALIseller;
    
    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAOld8LLK3DmrEZWhEfNkb/QDBKphLimOmf5gHkBTl49/FDQEV7lqSspLpow1EfcWeLxjSOY1YEFKdUsyoPbadGSmrhQBc5SOyis7nDO9Y7ERUzkwZvYfm7dzAO4hbD8SdRJGYfA0dJuTxOlQONNidZV7T+FfQf1/L3bj2pPzLX6PAgMBAAECgYEAvJ8UTL8Qr3/or6NHqg2VO4ow/DGeKTK8n1E7Qk0OZIqXXs/fw9r45nes/whqI+fC4KnzIzcjPMKc+ZHLbpr1lVV3lCVu44UW43VsiyPLzWuSjp5NJqVtsnZSJnHNW3UkfIr0Z3oC8fY87GO5DywZeLaXC/zYSL/7qCyTEoNJ8IECQQD+713y/hPJCTKdK4hRc+M5ifzc48boKJVI6ClgACeRm3Z/0PZWW56qDwMz0bJ78/VD5JHN/j9mGBhOgBfDUslBAkEA6leCBDfSYTqYr4dsuUCvcU0WwuQaMiCLsu0A6jZZdZvwMEjoIQo7whnoD28mynaQfD1pHUQBaI47c9JzOaEDzwJAa+gtwBjDjyiRf+1ZOgDvgP9jRKw1GTd0WPPL75KhLQS818U/P7ZwJlNMa7aq8cSFYENzY9nmQ/SW9UNKy6ZTAQJBAJobNftEImuiNyqnak5hRX7C7Ub47mkskfH2ffWIDEiVZdy69TxVGHtKwhr0Q5Q9aELrt6ZxRGPXtS0zpmathm0CQEY9thwLHR4GlGqrAYxHLWSaWDQjJNRCi4j0mOYg588O6X32eH15FNnTkXBGErT7RVgNU7dbv7NSuDVhk4ZPeMU=";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||[seller length] == 0 ||[privateKey length] == 0)
    {
        
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    
    order.tradeNO = newOrder.tradeNO; //订单ID（由商家自行制定）
    order.productName = newOrder.productName;   //商品标题
    order.productDescription = newOrder.productDescription;  //商品描述
    order.amount = newOrder.amount ;  //商品价格
    order.notifyURL = [NSString stringWithFormat:@"%@apipay/sdk_callback_url.aspx",ApiURL];// @"http://140.206.70.194:8069/apipay/sdk_callback_url.aspx"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = AliappScheme ;
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    
    
    
    NSString *signedString = [signer signString:orderSpec];
    
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


+ (NSString*)getOrder:(NSArray*)arr
{
    NSString*order = @"";
    for(int i=0 ; i<arr.count;i++)
    {
        order = [order stringByAppendingFormat:@"%@",arr[i][@"Order_number"]];
        if(i !=(arr.count-1))
        {
            order = [order stringByAppendingFormat:@"_"];
        }
    }
    return order;
}


+ (Order *)orderWithtradeNO:(NSString *)tradeNO money:(NSString *)money name:(NSString*)name detail:(NSString*)detail   {
    
    Order * order = [[Order alloc] init];
    
    order.tradeNO = tradeNO ;
    
    NSNumber * price = [NSNumber numberWithFloat:[money floatValue]];
    
    order.amount = [NSString stringWithFormat:@"%@",price];
    
    if(name == nil && name.length<=0){
        
        order.productName = @"商品标题";
    }
    else {
        order.productName = name ;
    }
    
    if(detail == nil && detail.length<=0){
        order.productDescription = @"商品详情";
    }
    else {
        order.productDescription = detail;
    }
    
    return order ;
}




+ (void)aliPayWith:(NSString *)orderString completion:(void (^)(NSDictionary* dict))handler {
    
    
    NSString *appScheme =  AliappScheme ;
    
    
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"reslut = %@",resultDic);
        
        if([resultDic[@"resultStatus"] integerValue]==9000)
        {
            handler(resultDic);
        }
        
    }];
    
}



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
//
            
//            [SKAlipay showMsg:[NSString stringWithFormat:@"dict = %@",dict]];
            
        }];
        
    }
    
    
}



+ (void)showMsg:(NSString *)msg {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:@"OK", nil];
    
    [alert show];
    
}






@end
