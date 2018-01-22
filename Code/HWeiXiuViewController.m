//
//  HWeiXiuViewController.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/24.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "HWeiXiuViewController.h"

#import "HWeiXiuTableViewCell.h"

#import "CategoryView.h"

#import "ShopDetailViewController.h"

#import "HWeiXiuPopView.h"

#import "SuccessViewController.h"

@interface HWeiXiuViewController ()<UITableViewDelegate,UITableViewDataSource ,UISearchBarDelegate>

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic ,strong)UISearchBar *searchBar;
@property (nonatomic ,strong)NSString *keyword;

@property (nonatomic ,strong)CategoryView *categoryView;

@property (nonatomic ,strong)CategoryModel *leftModel;
@property (nonatomic ,strong)CategoryModel *rightModel;

@property (nonatomic ,strong)NSMutableArray *leftArray;
@property (nonatomic ,strong)NSMutableArray *rightArray;

@property (nonatomic ,strong)ShopModel *model;

@end

@implementation HWeiXiuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"维修"];
    
    self.dataSource = [NSMutableArray array];
    self.leftArray = [NSMutableArray array];
    self.rightArray = [NSMutableArray array];
    
//    [self initRightItem];
    
    [self initSearchBar];
    
    [self initTableView];
    
//    [self loadleftCate];
    
    [self loadData];
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


- (void)initRightItem {
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    [btn setImage:[UIImage imageNamed:@"more_cate"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightItemAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self setRightBarWithCustomView:btn];
}


- (void)rightItemAction {
    
    self.categoryView.isShow = !self.categoryView.isShow;
    
}


- (CategoryView*)categoryView {
    
    if(_categoryView == nil){
        
        _categoryView = [[CategoryView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT - 64)];
        
        [self.view addSubview:_categoryView];
        
        __weak typeof(self) weak = self;
        _categoryView.leftSelectBlock = ^(NSInteger index) {
            
            weak.leftModel = weak.leftArray[index];
            [weak loadRightCate];
        };
        
        _categoryView.rightSelectBlock = ^(NSInteger index) {
            
            weak.rightModel = weak.rightArray[index];
            [weak loadData];
        };
        
    }
    return _categoryView;
}




- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}



- (void)initSearchBar {
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 40)];
    _searchBar.placeholder = @"搜索";
    _searchBar.delegate = self;
    
    
    _searchBar.showsCancelButton = YES;
    
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    NSLog(@"cancel");
    
    _searchBar.text = @"";
    
    _keyword = searchBar.text;
    
    [self.view endEditing:YES];
    
    [self.dataSource removeAllObjects];
    
    [self loadData];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    _keyword = searchBar.text;
    
    [self.view endEditing:YES];
    
    [self.dataSource removeAllObjects];
    
    [self loadData];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];
}




- (void)initTableView  {
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 0  - 64)];
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
    _tableView.backgroundColor = GRAYCOLOR;
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefreshing)];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefreshing)];
    
    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
    
    [footer endRefreshingWithNoMoreData];
    
    
    _tableView.mj_footer = footer;
    
//    _tableView.separatorStyle = NO;
    
    self.tableView.tableHeaderView = self.searchBar;
    
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
    
    
    return _dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWeiXiuTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[HWeiXiuTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    if(_dataSource.count <= 0){
        return cell;
    }

    ShopModel *model = _dataSource[indexPath.row];
    
    [cell dataWithModel:model];
    
    
    cell.payBlock = ^{
        
        _model = model;
        
        [HWeiXiuPopView showInView:self.navigationController.view shopModel:_model success:^{
            
            [self weixiuUploadData];
        }];
    };
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ShopModel *model = _dataSource[indexPath.row];
    model.cateType = @"3";
    ShopDetailViewController *nextVC = [[ShopDetailViewController alloc]init];
    nextVC.hidesBottomBarWhenPushed = YES;
    nextVC.model = model;
    [self.navigationController pushViewController:nextVC animated:YES];
}




- (void)loadData {
    
    NSString *url = HOSTAPIKEY(@"api/public/shoplist");
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString * token = [UserManager getToken];
    
    [parameters setObject:@"3" forKey:@"type"];
    
    NSInteger pageCount = 10;
    NSInteger maxCount = _dataSource.count;
    NSInteger totalPage =  (maxCount + pageCount -1) / pageCount + 1;
    
    [parameters setObject:@(totalPage) forKey:@"pn"];
    [parameters setObject:@(pageCount) forKey:@"ps"];
    [parameters setObject:token forKey:@"token"];
    
//    if(_rightModel != nil){
//        
//        [parameters setObject:_rightModel.Id forKey:@"cateid"];
//    }
    
    if(_keyword.length > 0){
        
        [parameters setObject:_keyword forKey:@"keyword"];
    }
    
    
    [NetWorkManager netWorkGetURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        [_tableView.mj_header endRefreshing];
        
        if([dict[@"res"] integerValue] == 1){
            
            
            NSArray *array = dict[@"elements"];
            
            for(NSDictionary *dic1 in array){
                
                ShopModel *model = [[ShopModel alloc]initWithDict:dic1];
//                model.cateid = _rightModel.Id;
                [_dataSource addObject:model];
            }
            
            [_tableView reloadData];
            
            [RefleshManager tableView:_tableView count:array.count maxCount:pageCount];
        }
        else {
            
            [HUDManager alertText:dict[@"msg"]];
        }
        
        
    }];
    
}


- (void)loadleftCate {
    
    
    NSString *url = HOSTAPIKEY(@"api/public/catelist");
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    //    NSString * token = [UserManager getToken];
    
    [parameters setObject:@"3" forKey:@"type"];
    
    NSInteger pageCount = 999;
    NSInteger maxCount = 0;//_dataSource.count;
    NSInteger totalPage =  (maxCount + pageCount -1) / pageCount + 1;
    
    [parameters setObject:@(totalPage) forKey:@"pn"];
    [parameters setObject:@(pageCount) forKey:@"ps"];
    
    [parameters setObject:@(0) forKey:@"parentid"];
    
    
    [NetWorkManager netWorkGetURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        [_tableView.mj_header endRefreshing];
        
        if([dict[@"res"] integerValue] == 1){
            
            
            NSArray *array = dict[@"elements"];
            
            [self.leftArray removeAllObjects];
            
            for(NSDictionary *dic1 in array){
                
                CategoryModel *model = [[CategoryModel alloc]initWithDict:dic1];
                
                [self.leftArray addObject:model];
            }
            
            self.categoryView.leftArray = self.leftArray;
            
            if(_leftModel == nil && self.leftArray.count > 0){
                _leftModel = self.leftArray[0];
                
                [self loadRightCate];
            }
        }
        else {
            
            [HUDManager alertText:dict[@"msg"]];
        }
        
        
    }];
    
}


- (void)loadRightCate {
    
    NSString *url = HOSTAPIKEY(@"api/public/catelist");
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    //    NSString * token = [UserManager getToken];
    
    [parameters setObject:@"3" forKey:@"type"];
    
    NSInteger pageCount = 999;
    NSInteger maxCount = 0;//_dataSource.count;
    NSInteger totalPage =  (maxCount + pageCount -1) / pageCount + 1;
    
    [parameters setObject:@(totalPage) forKey:@"pn"];
    [parameters setObject:@(pageCount) forKey:@"ps"];
    
    
    if(_leftModel != nil){
        
        [parameters setObject:_leftModel.Id forKey:@"parentid"];
    }
    
    
    [NetWorkManager netWorkGetURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        [_tableView.mj_header endRefreshing];
        
        if([dict[@"res"] integerValue] == 1){
            
            
            NSArray *array = dict[@"elements"];
            
            [self.rightArray removeAllObjects];
            
            for(NSDictionary *dic1 in array){
                
                CategoryModel *model = [[CategoryModel alloc]initWithDict:dic1];
                
                [self.rightArray addObject:model];
            }
            
            self.categoryView.rightArray = self.rightArray;
            
        }
        else {
            
            [HUDManager alertText:dict[@"msg"]];
        }
        
        
    }];
    
}



- (void)weixiuUploadData {
    
    
    if(_model.startdate.length <= 0){
        [HUDManager alertText:@"请选择预约时间"];
        return;
    }
    
    NSString *url = HOSTAPIKEY(@"api/public/submitwxorder");
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    
    NSString *token = [UserManager getToken];
    
    [parameters setObject:token forKey:@"token"];
    [parameters setObject:_model.Id forKey:@"shopid"];
    
    [parameters setObject:_model.startdate forKey:@"startdate"];
    
    
    [NetWorkManager netWorkPostURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        
        if([dict[@"res"] integerValue] == 1){
            
            _model.serialnumber = DictStr(dict, @"serialnumber");
            
            SuccessViewController *nextVC = [[SuccessViewController alloc]init];
            nextVC.hidesBottomBarWhenPushed = YES;
            nextVC.shopModel = _model;
            nextVC.selTag = 3;
            [self.navigationController pushViewController:nextVC animated:YES];
        }
        
        [HUDManager alertText:dict[@"msg"]];
    }];
}





@end
