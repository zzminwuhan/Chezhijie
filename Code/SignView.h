//
//  SignView.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/20.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SignBtn.h"

@interface SignView : UIView

@property (nonatomic ,strong)NSMutableArray *btnsArray;

@property (nonatomic ,copy)ActionBlock signBlock;

@property (nonatomic ,copy)ActionBlock winBlock;

- (void)dataWithArray:(NSMutableArray*)array ;

- (void)dataWithDict:(NSDictionary*)dict ;

@end
