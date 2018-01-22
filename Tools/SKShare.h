//
//  SKShare.h
//  AiShang
//
//  Created by yuyue on 16/12/7.
//  Copyright © 2016年 incredibleRon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKShare : NSObject

+ (void)initSDK;

+ (void)handleOpenURL:(NSURL *)url  ;

+ (void)SKShareWB ;

+ (void)SKShareQQ ;

+ (void)SKShareZone ;

+ (void)SKShareShareSession ;

+ (void)SKShareTimeline  ;


+ (void)SKShareWithTag:(NSInteger)tag  ;


+ (void)SKShareWithTag2:(NSInteger)tag ;

@end
