//
//  HCheXianViewController.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/24.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "HCheXianViewController.h"

#import <SDCycleScrollView.h>

#import "HCCollectionView.h"

#import "CheXianEditViewController.h"

#import "ShopModel.h"

@interface HCheXianViewController ()<UITableViewDelegate,UITableViewDataSource ,HCCollectionViewDelegate,HCCollectionViewDataSource>

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic ,strong)UIView *headView;
@property (nonatomic ,strong)UIView *footView;

@property (nonatomic ,strong)HCCollectionView * collectionView;

@property (nonatomic,strong)SDCycleScrollView* cycleScrollView;
@property (nonatomic ,strong)NSMutableArray *adList;

@end

@implementation HCheXianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNaviBarBtn:@"车险"];
    
//    NSArray *array = @[@{@"image":@"safety_001",@"title":@"太平洋保险"},
//                       @{@"image":@"safety_002",@"title":@"中国平安保险"},
//                       @{@"image":@"safety_003",@"title":@"中国人寿保险"},
//                       @{@"image":@"safety_004",@"title":@"太平人寿"},
//                       @{@"image":@"safety_005",@"title":@"华安保险"},
//                       @{@"image":@"safety_006",@"title":@"华夏保险"},
//                       @{@"image":@"safety_007",@"title":@"大地财产保险"},
//                       @{@"image":@"safety_008",@"title":@"中华保险"},
//                       @{@"image":@"safety_009",@"title":@"阳光保险"}];
    
    self.adList = [NSMutableArray array];
    
    self.dataSource = [NSMutableArray array] ;//arrayWithArray:array];
    
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

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}




- (UIView *)headView {
    
    if(_headView == nil){
        
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_WIDTH/2+180)];
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
    
    
    CGFloat y = cycleScrollView.bottom;
    _headView.frame = CGRectMake(0, 0, SCREEM_WIDTH, y);
    
}


- (UIView*)footView {
    
    if(_footView == nil){
        
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_WIDTH)];
        [self creatHCCollect];
    }
    return _footView;
}


- (void)creatHCCollect {
    
    HCCollectionView *collectionView = [[HCCollectionView alloc]initWithFrame:CGRectMake(10, 15, SCREEM_WIDTH-20, SCREEM_WIDTH-20)];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView.collectionView reloadData];
    
    [_footView addSubview:collectionView];
    
    self.collectionView = collectionView;
}


- (void)collectionCell:(HCCollectionViewCell *)cell didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //    [self cellSelWithTag:indexPath.row];
    ShopModel *model = _dataSource[indexPath.row];
    
    CheXianEditViewController *nextVC = [[CheXianEditViewController alloc]init];
    nextVC.hidesBottomBarWhenPushed = YES;
    nextVC.shopModel = model;
    nextVC.adList = self.adList;
    [self.navigationController pushViewController:nextVC animated:YES];
    
}

- (void)collectionCell:(HCCollectionViewCell *)cell cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
//    NSDictionary *dic = _dataSource[indexPath.row];
    
    ShopModel *model = _dataSource[indexPath.row];
    
//    cell.imgView.image = [UIImage imageNamed:dic[@"image"]];
    cell.imgView.contentMode = UIViewContentModeScaleAspectFill;
    
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.imgurl]];
    
    cell.title.text = model.name;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItems:(NSInteger)section {
    
    return _dataSource.count;
}






-  (void)initTableView  {
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 0)];
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
    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = self.footView;
}


- (void)headRefreshing {
    
    [_dataSource removeAllObjects];
    
    [_tableView.mj_header endRefreshing];
    
    [self loadData];
    
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
    
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}




- (void)loadData {
    
    NSString *url = HOSTAPIKEY(@"api/public/shoplist");
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString * token = [UserManager getToken];
    
    [parameters setObject:token forKey:@"token"];
    
    NSInteger pageCount = 999;
    NSInteger maxCount = 0;
    NSInteger totalPage =  (maxCount + pageCount -1) / pageCount + 1;
    
    [parameters setObject:@(totalPage) forKey:@"pn"];
    [parameters setObject:@(pageCount) forKey:@"ps"];
    
    [parameters setObject:@(4) forKey:@"type"];
    
    
    [NetWorkManager netWorkGetURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        
        if([dict[@"res"] integerValue] == 1){
            
            
            NSArray *array = dict[@"elements"];
            
            NSLog(@"%@",array);
            
            [self.dataSource removeAllObjects];
            
            for(NSDictionary *dic in array){
                
                ShopModel *model = [[ShopModel alloc]initWithDict:dic];
                [_dataSource addObject:model];
            }
            
            [self.collectionView.collectionView reloadData];
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
    
    [parameters setObject:@(3) forKey:@"type"];
    
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



@end
