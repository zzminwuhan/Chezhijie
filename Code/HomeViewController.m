//
//  HomeViewController.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/19.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "HomeViewController.h"

#import <SDCycleScrollView.h>

#import "HomeDetailViewController.h"

#import "MessageTableViewCell.h"

#import "HomeBtn.h"

#import "AlphaView.h"

#import "HMNewViewController.h"
#import "HDaiKuanViewController.h"
#import "HCheXianViewController.h"
#import "HGouCheViewController.h"
#import "HWeiXiuViewController.h"
#import "HYangHuViewController.h"
#import "HNianJianViewController.h"

#import "HMessageViewController.h"

#import "PhoneView.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource ,SDCycleScrollViewDelegate >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic,strong)SDCycleScrollView* cycleScrollView;

@property (nonatomic ,strong)UIView *headView;

@property (nonatomic,strong)NSMutableArray* btnsArray;

@property (nonatomic ,strong)AlphaView *headBarView;

@property (nonatomic ,strong)NSMutableArray *adList;

@property (nonatomic ,strong)NSString * jymobile;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    [self initNaviBarBtn:@"车之介"];
    
    self.dataSource = [NSMutableArray array];
    self.adList = [NSMutableArray array];
    
    [self initTableView];
    
    [self loadData];
    
    [self.view addSubview:self.headBarView];

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
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}


- (AlphaView*)headBarView {
    
    if(_headBarView == nil){
        
        _headBarView = [[AlphaView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 64)];
//        _headBarView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_headBarView];
        
        [self creatHeadBar];
    }
    
    return _headBarView;
}


- (void)creatHeadBar {
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEM_WIDTH/2 - 80, 27, 160, 30)];
    label.font = [UIFont systemFontOfSize:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"车之介";
    label.textColor = RGB(255, 255, 255);
    
    [_headBarView addSubview:label];

    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 50, 20, 50, 44)];
    [btn setImage:[UIImage imageNamed:@"messages"] forState:UIControlStateNormal];
    [_headBarView addSubview:btn];
    
    [btn addTarget:self action:@selector(btnRightItemAction) forControlEvents:UIControlEventTouchUpInside];
}


- (void)btnRightItemAction {
    
    HMessageViewController *nextVC = [[HMessageViewController alloc]init];
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}




- (UIView *)headView {
    
    if(_headView == nil){
        
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_WIDTH/2+180)];
        _headView.backgroundColor = [UIColor whiteColor];
        
        [self creatHeadView];
    }
    
    return _headView;
}


- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSDictionary *dic = self.adList[index];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:dic[@"targeturl"]]];
    
}

- (void)creatHeadView {
    
    SDCycleScrollView *cycleScrollView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_WIDTH*0.5)];
    
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    cycleScrollView.clipsToBounds = YES;
    cycleScrollView.delegate = self;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
    [_headView addSubview:cycleScrollView];
    
    self.cycleScrollView = cycleScrollView;
    
    CGFloat y1 = cycleScrollView.bottom;
    
    NSArray *titleArray = @[@"年检",@"养护",@"维修",@"车险",
                            @"购车",@"贷款",@"紧急救援",@"新闻资讯"];
    
    self.btnsArray = [NSMutableArray array];
    
    CGFloat w = SCREEM_WIDTH/4;
    CGFloat h = 90;
    CGFloat x = 0;
    CGFloat y = 0;
    for(int i=0;i<8;i++){
        
        x = (i%4)*w;
        y = y1 + (i/4)*h;
        
        HomeBtn *btn = [[HomeBtn alloc]initWithFrame:CGRectMake(x, y, w, h)];
        btn.titleLabel.font = FONT14;
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:RGB(50, 50, 50) forState:UIControlStateNormal];
        NSString *imgStr = [NSString stringWithFormat:@"home_btn0%@",@(i+1)];
        [btn setImage:[UIImage imageNamed:imgStr] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(homeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_headView addSubview:btn];
        
        [self.btnsArray addObject:btn];
        
    }
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, y1 + h*2+10, 5, 30)];
    label.backgroundColor = RGB(41, 181, 235);
    [_headView addSubview:label];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(15, y1 + h*2+10, SCREEM_WIDTH - 30, 30)];
    label2.textColor = RGB(50, 50, 50);
    label2.text = @"新闻资讯";
    label2.font = FONT15;
    [_headView addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, y1 + h*2, SCREEM_WIDTH, 0.5)];
    label3.backgroundColor = RGB(200, 200, 200);
    [_headView addSubview:label3];
    
    
    _headView.frame = CGRectMake(0, 0, SCREEM_WIDTH, y1 + h*2 + 50);
}


- (void)homeBtnAction:(HomeBtn*)btn {
    
    NSInteger tag = [self.btnsArray indexOfObject:btn];
    
    if(tag == 0){
        HNianJianViewController *nextVC = [[HNianJianViewController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else if (tag == 1){
        HYangHuViewController *nextVC = [[HYangHuViewController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else if (tag == 2){
        HWeiXiuViewController *nextVC = [[HWeiXiuViewController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else if (tag == 3){
        
        HCheXianViewController *nextVC = [[HCheXianViewController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else if (tag == 4){
        
        HGouCheViewController *nextVC = [[HGouCheViewController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else if (tag == 5){
        
        HDaiKuanViewController *nextVC = [[HDaiKuanViewController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else if (tag == 6){
        
        [PhoneView showInWindowWithPhone2:_jymobile];
    }
    else if (tag == 7){
        
        HMNewViewController *nextVC = [[HMNewViewController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView  {
    
    [self.headBarView scrollWithY:scrollView.contentOffset.y];
}





- (void)initTableView  {
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 0  - 50)];
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
    
    _tableView.separatorStyle = NO;
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
    MessageTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[MessageTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    if(_dataSource.count <= 0){
        return cell;
    }
    
   
    MessageModel *model = _dataSource[indexPath.row];
    
    [cell dataWithModel:model];
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MessageModel *model = _dataSource[indexPath.row];
    
    HomeDetailViewController *nextVC = [[HomeDetailViewController alloc]init];
    nextVC.hidesBottomBarWhenPushed = YES;
    nextVC.model = model;
    [self.navigationController pushViewController:nextVC animated:YES];
}



/*
 * 首页接口请求
 *
 */

- (void)loadData {
    
    NSString *url = HOSTAPIKEY(@"api/public/getindex");
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString * token = [UserManager getToken];
    
    [parameters setObject:token forKey:@"token"];
    
    [NetWorkManager netWorkGetURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        if([dict[@"res"] integerValue] == 1){
            
            [self adlistWithDict:dict];
            
            NSArray *newslist = dict[@"newslist"];
            
            _jymobile = DictStr(dict, @"jymobile");
    
            [self.dataSource removeAllObjects];
            
            for(NSDictionary *dic2 in newslist){
                
                MessageModel *model = [[MessageModel alloc]initWithDict:dic2];
                [_dataSource addObject:model];
            }
            
            [self.tableView reloadData];
            
        }
        else {
            
            [HUDManager alertText:dict[@"msg"]];
        }
        
        
    }];
    
}


- (void)adlistWithDict:(NSDictionary*)dict {
    
    NSArray *adlist = dict[@"adlist"];
    [self.adList removeAllObjects];
    [self.adList addObjectsFromArray:adlist];
    
    NSMutableArray *array = [NSMutableArray array];
    
    for(NSDictionary *dic in adlist){
        
        NSString *url = dic[@"imageurl"];
        [array addObject:url];
    }
    
    self.tableView.tableHeaderView = self.headView;

    self.cycleScrollView.imageURLStringsGroup = array;
}




@end
