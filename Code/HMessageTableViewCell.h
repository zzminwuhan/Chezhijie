//
//  HMessageTableViewCell.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/26.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MessageModel.h"

@interface HMessageTableViewCell : UITableViewCell

- (void)dataWithModel:(MessageModel*)model ;

@end