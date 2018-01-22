//
//  SKShare.m
//  AiShang
//
//  Created by yuyue on 16/12/7.
//  Copyright © 2016年 incredibleRon. All rights reserved.
//

#import "SKShare.h"

//#import "SinaSDK.h"

#import "TencentSDK.h"

#import "SKAlipay.h"

#import "SKWX.h"

@implementation SKShare





+ (void)initSDK {
    
//    [SinaSDK shareSinaSDK];
    [TencentSDK shareTencentSDK];
    [SKWX shareSdkWX];
}



+  (void)handleOpenURL:(NSURL *)url  {
    
//    [[SinaSDK shareSinaSDK] handleOpenURL:url];
    
    [[TencentSDK shareTencentSDK] handleOpenURL:url];
    
    [SKAlipay  handleOpenURL:url];
    
    [[SKWX shareSdkWX] handleOpenURL:url];
}



+ (void)SKShareWB {
    
    
//    [[SinaSDK shareSinaSDK] wbShare];
}



+ (void)SKShareQQ {
    
    [[TencentSDK shareTencentSDK] tencentShareQQ];
    
}

+ (void)SKShareZone {
    
    [[TencentSDK shareTencentSDK] tencentShareZone];
    
}


+ (void)SKShareShareSession {
    
    [[SKWX shareSdkWX] wxShareSession];
}


+ (void)SKShareTimeline {
    
    [[SKWX shareSdkWX] wxShareTimeline];
}



+ (void)SKShareWithTag:(NSInteger)tag {
    
    if(tag == 1){
        [SKShare SKShareQQ];
    }
    else if (tag == 3) {
        [SKShare SKShareTimeline];
    }
    else if (tag == 2) {
        [SKShare SKShareShareSession];
    }
    else if (tag == 0) {
        [SKShare SKShareZone];
    }
    
}


+ (void)SKShareWithTag2:(NSInteger)tag {
    
    if(tag == 0){
        
        [SKShare SKShareWB];
    }
    else if (tag == 1) {
        
        [SKShare SKShareZone];
    }
    else if (tag == 2) {
        
        [SKShare SKShareQQ];
    }
    else if (tag == 3) {
        
        [SKShare SKShareShareSession];
    }
    else if (tag == 4){
        
        [SKShare SKShareTimeline];

    }
    
}



@end
