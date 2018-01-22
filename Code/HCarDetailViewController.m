//
//  HCarDetailViewController.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/27.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "HCarDetailViewController.h"

#import "ShopHeadView.h"

#import "MessageTableViewCell.h"

#import "HomeDetailViewController.h"

#import "HWeiXiuPopView.h"

#import "HYangHuPopView.h"

#import "AlipayManager.h"

#import "SKWX.h"


#import "CarShopHeadView.h"

#import "HCarPopView.h"

#import <WebKit/WebKit.h>

@interface HCarDetailViewController ()<UITableViewDelegate,UITableViewDataSource ,WKNavigationDelegate >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic ,strong)ShopHeadView *headView;

@property (nonatomic ,strong)CarShopHeadView *carheadView;

@property (nonatomic ,strong)NSArray *carTypeArray;

@property (nonatomic ,strong)WKWebView *webView;

@end

@implementation HCarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self initNaviBarBtn:_model.name];
    
    self.dataSource = [NSMutableArray array];
    
    [self initTableView];
    
    [self initFootView];
    
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



- (CarShopHeadView*)carheadView {
    
    if(_carheadView == nil){
        
        _carheadView = [[CarShopHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 50)];
    }
    return _carheadView;
}




- (WKWebView*)webView {
    
    
    if(_webView == nil){
        
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 200)];
        _webView.userInteractionEnabled = NO;
        _webView.navigationDelegate = self;
        [_webView setOpaque:NO];
        
    }
    
    return _webView;
}


- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    [webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id data, NSError * _Nullable error) {
        CGFloat height = [data floatValue];
        //ps:js可以是上面所写，也可以是document.body.scrollHeight;在WKWebView中前者offsetHeight获取自己加载的html片段，高度获取是相对准确的，但是若是加载的是原网站内容，用这个获取，会不准确，改用后者之后就可以正常显示，这个情况是我尝试了很多次方法才正常显示的
        CGRect webFrame = webView.frame;
        webFrame.size.height = height;
        webView.frame = webFrame;
        
        self.tableView.tableFooterView = self.webView;
    }];
    
}



- (void)webViewLoad {
    
    
    NSURLRequest *req = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:_model.url]];
    
    [self.webView loadRequest:req];
    
    self.tableView.tableFooterView = self.webView;
}



- (void)initFootView {
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEM_HEIGHT - 64 - 50, SCREEM_WIDTH, 50)];
    btn.backgroundColor = MAINCOLOR;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"立即询价" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
}


- (void)btnAction {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [HCarPopView showInView:window shopModel:_model success:^{
        
        [self buycarUploadData];
    }];
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
    _tableView.backgroundColor = GRAYCOLOR;
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefreshing)];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefreshing)];
    
    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
    
    [footer endRefreshingWithNoMoreData];
    
    
    _tableView.mj_footer = footer;
    
    _tableView.tableHeaderView = self.carheadView;
    
    [self.carheadView dataWithModel:_model];
    
    
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


- (void)loadData {
    
    NSString *url = HOSTAPIKEY(@"api/public/goodsdetail");
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setObject:_model.Id forKey:@"goodsid"];
    
//    [parameters setObject:_model.cateid forKey:@"cateid"];
    
    [NetWorkManager netWorkGetURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        [_tableView.mj_header endRefreshing];
        
        if([dict[@"res"] integerValue] == 1){
            
            self.carTypeArray = [DictStr(dict, @"type") componentsSeparatedByString:@","];
            
            self.carheadView.carTypeArray = self.carTypeArray;
            
            _model.url = DictStr(dict, @"url");
            
            _tableView.tableHeaderView = self.carheadView;
            
//            NSArray *array = dict[@"newslist"];
//            
//            for(NSDictionary *dic1 in array){
//                
//                MessageModel *model = [[MessageModel alloc]initWithDict:dic1];
//                
//                [_dataSource addObject:model];
//            }
//            
//            [_tableView reloadData];
            
            if(dict[@"url"] != nil){
                
                [self webViewLoad];
            }
            
            
        }
        else {
            
            [HUDManager alertText:dict[@"msg"]];
        }
        
    }];
    
}



- (void)buycarUploadData {
    
    NSString *url = HOSTAPIKEY(@"api/public/submitgcorder");
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    
    NSString *token = [UserManager getToken];
    
    [parameters setObject:token forKey:@"token"];
    [parameters setObject:_model.Id forKey:@"goodsid"];
    
    [parameters setObject:_model.contactname forKey:@"contactname"];
    [parameters setObject:_model.contactmobile forKey:@"contactmobile"];
    [parameters setObject:_model.city forKey:@"city"];
    
    if(_model.type != nil){
        
        [parameters setObject:_model.type forKey:@"type"];
    }
    
    
    [NetWorkManager netWorkPostURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        
        if([dict[@"res"] integerValue] == 1){
            
//            _model.serialnumber = DictStr(dict, @"serialnumber");
            
            
            TipViewController * nextVC = [[TipViewController alloc]init];
            nextVC.tipTitle = @"询价成功";
            nextVC.tipText = @"询价成功";
            nextVC.tipDetail = @"稍后有专业的汽车顾问为您服务\n请保持电话畅通！";
            
            UIBaseNavigationController *navi = [[UIBaseNavigationController alloc]initWithRootViewController:nextVC];
            
            [self presentViewController:navi animated:YES completion:nil];
        }
        
        [HUDManager alertText:dict[@"msg"]];
    }];
}





@end
