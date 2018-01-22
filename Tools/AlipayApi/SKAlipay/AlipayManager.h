//
//  AlipayManager.h
//  Aladdin
//
//  Created by yuyue on 2017/3/15.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlipayManager : NSObject



+ (void)alipaySign:(NSString*)sign completion:(void (^)(NSDictionary* dict))handler  ;

@end
