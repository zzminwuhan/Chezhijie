//
//  DGDatePicker.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/15.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DGDatePicker : UIView  <UITableViewDelegate,UITableViewDataSource  >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic ,strong)NSString *selStr;

@property (nonatomic ,copy)void (^SelDateString)(NSString * dateString);

- (void)show ;


+ (NSMutableArray *)getCurrentDateArray;

@end
