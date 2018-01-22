//
//  BrandView.h
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/15.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BrandModel.h"

typedef void(^SelBrandModel)(BrandModel *model);

@interface BrandView : UIView <UITableViewDelegate,UITableViewDataSource  >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic ,copy)SelBrandModel selModel;

@property (nonatomic ,strong)UILabel *label;

- (void)setAttr:(NSString *)attr ;

@end
