//
//  GiftRecordTableViewCell.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/26.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GiftRecordModel.h"

@interface GiftRecordTableViewCell : UITableViewCell

@property (nonatomic ,copy)ActionBlock downBlock;

- (void)dataWithModel:(GiftRecordModel*)model  ;

@end
