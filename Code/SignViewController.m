//
//  SignViewController.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/19.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "SignViewController.h"

#import <SDCycleScrollView.h>

#import "SignView.h"

#import "GiftRecordViewController.h"

#import "SignPopView.h"

@interface SignViewController ()<UITableViewDelegate,UITableViewDataSource ,SDCycleScrollViewDelegate >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic ,strong)UIView *headView;

@property (nonatomic ,strong)SignView *signView;

@property (nonatomic,strong)SDCycleScrollView* cycleScrollView;
@property (nonatomic ,strong)NSMutableArray *adList;

@property (nonatomic,strong)ShopModel *model;


@end

@implementation SignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"签到"];
    [self initLeftItem];
    [self initRightItem];
    
    _model = [ShopModel new];
    
    self.adList = [NSMutableArray array];
    
    _dataSource = [NSMutableArray array];
    
    [self initTableView];
    
    [self loadData];
    
    [self loadBanner];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)initLeftItem {
    
    
    [self setLeftBarWithCustomView:nil];
}


- (void)initRightItem {
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    [btn setTitle:@"礼品记录" forState:UIControlStateNormal];
    btn.titleLabel.font = FONT12;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightItemAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self setRightBarWithCustomView:btn];
}


- (void)rightItemAction {
 
    GiftRecordViewController *nextVC = [[GiftRecordViewController alloc]init];
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}




- (UIView*)headView {
    
    if(_headView == nil){
        
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT - 64)];
        _headView.backgroundColor = [UIColor whiteColor];
        
        [self creatHeadView];
    }
    
    return _headView;
}



- (void)creatHeadView {
    
    SDCycleScrollView *cycleScrollView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_WIDTH*0.5)];
    
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    cycleScrollView.clipsToBounds = YES;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
    [_headView addSubview:cycleScrollView];
    
    self.cycleScrollView = cycleScrollView;
 
    
    CGFloat y = cycleScrollView.bottom+20;
    
    SignView *signView = [[SignView alloc]initWithFrame:CGRectMake(3, y, SCREEM_WIDTH - 6, (SCREEM_WIDTH - 6)*0.70)];
    
    [_headView addSubview:signView];
    
    signView.signBlock = ^{
        [self signAction];
    };
    
    signView.winBlock = ^{
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [SignPopView showInView:window shopModel:_model success:^{
            
            [self winAction];
        }];
    };
    
    self.signView = signView;
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, signView.bottom+20, SCREEM_WIDTH, 5)];
    line.backgroundColor = RGB(240, 240, 240);
    [_headView addSubview:line];
    
    _headView.frame = CGRectMake(0, 0, SCREEM_WIDTH, line.bottom+160);
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, line.bottom, SCREEM_WIDTH - 30, 40)];
    label.font = FONT14;
    label.textColor = RGB(50, 50, 50);
    label.text = @"签到规则说明";
    [_headView addSubview:label];
    
    NSArray *array = @[@"连续签到15天获取奖励",
                       @"签到15天后系统重置可再次连续签到15天获取奖品",
                       @"获取礼品后请及时填写收货地址",
                       @"平台将在7个工作日内进行发货"];
    
    for(int i=0;i<array.count;i++){
        
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15, label.bottom+30*i, SCREEM_WIDTH, 30)];
        btn.titleLabel.font = FONT(12*(SCREEM_WIDTH/375));
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:RGB(100, 100, 100) forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
        [_headView addSubview:btn];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 7, 16, 16)];
        label.text = [NSString stringWithFormat:@"%@",@(i+1)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT(12*(SCREEM_WIDTH/375));
        label.backgroundColor = RGB(237, 189, 68);
        label.textColor = [UIColor whiteColor];
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = label.height/2;
        [btn addSubview:label];
    }
    
}



- (void)initTableView  {
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 50)];
    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
    if([_tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if([_tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [_tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.backgroundColor = [UIColor whiteColor];
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefreshing)];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefreshing)];
    
    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
    
    [footer endRefreshingWithNoMoreData];
    
    
    _tableView.mj_footer = footer;
    
//    _tableView.separatorStyle = NO;
    _tableView.tableHeaderView = self.headView;
}


- (void)headRefreshing {
    
    [_dataSource removeAllObjects];
    
    [_tableView.mj_header endRefreshing];
    
    [self loadData];
    
    [self loadBanner];
}


- (void)footRefreshing {
    
    [_tableView.mj_footer endRefreshing];
    
    [self loadData];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    if(_dataSource.count <= 0){
        return cell;
    }
    
    
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}


- (void)loadData {
    
    NSString *url = HOSTAPIKEY(@"api/public/loglist");
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString * token = [UserManager getToken];
    
    [parameters setObject:token forKey:@"token"];
    
    NSInteger pageCount = 15;
    NSInteger maxCount = _dataSource.count;
    NSInteger totalPage =  (maxCount + pageCount -1) / pageCount + 1;
    
    [parameters setObject:@(totalPage) forKey:@"pn"];
    [parameters setObject:@(pageCount) forKey:@"ps"];
    
    
    [NetWorkManager netWorkGetURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        [_tableView.mj_header endRefreshing];
        
        if([dict[@"res"] integerValue] == 1){
            
            
            NSArray *array = dict[@"elements"];
            
            [_dataSource removeAllObjects];
            
            for(NSDictionary *dic1 in array){
                
                SignModel *model = [[SignModel alloc]initWithDict:dic1];
                
                [_dataSource addObject:model];
            }
            
//            [_tableView reloadData];
//            
//            [RefleshManager tableView:_tableView count:array.count maxCount:pageCount];
            
            [self.signView dataWithArray:_dataSource];
            [self.signView dataWithDict:dict];
            
        }
        else {
            
            [HUDManager alertText:dict[@"msg"]];
        }
        
        
    }];

}

//广告
- (void)loadBanner {
    
    NSString *url = HOSTAPIKEY(@"api/public/adlist");
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString * token = [UserManager getToken];
    
    [parameters setObject:token forKey:@"token"];
    
    NSInteger pageCount = 999;
    NSInteger maxCount = 0;
    NSInteger totalPage =  (maxCount + pageCount -1) / pageCount + 1;
    
    [parameters setObject:@(totalPage) forKey:@"pn"];
    [parameters setObject:@(pageCount) forKey:@"ps"];
    
    [parameters setObject:@(6) forKey:@"type"];
    
    [NetWorkManager netWorkGetURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        
        if([dict[@"res"] integerValue] == 1){
            
            NSArray *adlist = dict[@"elements"];
            [self.adList removeAllObjects];
            [self.adList addObjectsFromArray:adlist];
            
            NSMutableArray *array = [NSMutableArray array];
            
            for(NSDictionary *dic in adlist){
                
                NSString *url = dic[@"imageurl"];
                [array addObject:url];
            }
            
            self.cycleScrollView.imageURLStringsGroup = array;
            
        }
        //        else {
        //
        //            [HUDManager alertText:dict[@"msg"]];
        //        }
    }];
    
    
}



- (void)signAction {
    
    NSString *url = HOSTAPIKEY(@"api/public/sign");
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *token = [UserManager getToken];
    
    [parameters setObject:token forKey:@"token"];
    
    [NetWorkManager netWorkPostURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        
        if([dict[@"res"] integerValue] == 1){
            
            NSString * canreceive = DictStr(dict, @"canreceive");
            
            if([canreceive boolValue] == YES){
                
            }
            else {
                
                [self loadData];
            }
            
        }
        
        
        [HUDManager alertText:dict[@"msg"]];
    }];
    
}



- (void)winAction {
    
    
    NSString *url = HOSTAPIKEY(@"api/public/SubmitPrizeOrder");
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    
    NSString *token = [UserManager getToken];
    
    [parameters setObject:token forKey:@"token"];
    
    [parameters setObject:_model.contactname forKey:@"name"];
    [parameters setObject:_model.contactmobile forKey:@"mobile"];
    [parameters setObject:_model.city forKey:@"address"];
    

    
    [NetWorkManager netWorkPostURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        
        if([dict[@"res"] integerValue] == 1){
            
            
        }
        
        [HUDManager alertText:dict[@"msg"]];
    }];

}




@end
