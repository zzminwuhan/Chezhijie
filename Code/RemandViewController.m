//
//  RemandViewController.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/19.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "RemandViewController.h"

#import <SDCycleScrollView.h>

#import "MLTextView.h"

@interface RemandViewController ()<UITableViewDelegate,UITableViewDataSource >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic ,strong)UIView *headView;

@property (nonatomic ,strong)MLTextView *textView;
@property (nonatomic ,strong)UITextField *name;
@property (nonatomic ,strong)UITextField *phone;

@property (nonatomic,strong)SDCycleScrollView* cycleScrollView;
@property (nonatomic ,strong)NSMutableArray *adList;


@end

@implementation RemandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"需求"];
    [self initLeftItem];
    [self initRightItem];
    
    self.adList = [NSMutableArray array];
    
    [self initTableView];
    
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
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    btn.titleLabel.font = FONT12;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightItemAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self setRightBarWithCustomView:btn];
}


- (void)rightItemAction {
    
    [self loadData];
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
    
    
#pragma label 提示
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, cycleScrollView.bottom , SCREEM_WIDTH - 30, 40)];
    label.font = FONT10;
    label.textColor = [UIColor redColor];
    label.text = @"填写您的需求，平台会有专业人事和您取得联系";
    [_headView addSubview:label];
    
    
    _textView = [[MLTextView alloc]initWithFrame:CGRectMake(15, label.bottom, SCREEM_WIDTH - 30, 130)];
    _textView.placeholder.text = @"需求描述";
    _textView.layer.masksToBounds = YES;
    _textView.layer.cornerRadius = 5;
    _textView.layer.borderWidth = 1;
    _textView.layer.borderColor = RGB(220, 220, 220).CGColor;
    _textView.textView.font = FONT14;
    _textView.placeholder.font = FONT14;
    [_headView addSubview:_textView];
    
    
    CGFloat y = _textView.bottom + 20;
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(15, y , SCREEM_WIDTH - 30, 40)];
    label2.font = FONT14;
    label2.textColor = RGB(50, 50, 50);
    label2.text = @"联系人";
    [_headView addSubview:label2];
    
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(15, y + 60, SCREEM_WIDTH - 30, 40)];
    label3.font = FONT14;
    label3.textColor = RGB(50, 50, 50);
    label3.text = @"联系电话";
    [_headView addSubview:label3];
    
    
    _name = [[UITextField alloc]initWithFrame:CGRectMake(120, label2.top, SCREEM_WIDTH - 130, 40)];
    _name.layer.masksToBounds = YES;
    _name.layer.cornerRadius = 5;
    _name.layer.borderWidth = 1;
    _name.layer.borderColor = RGB(220, 220, 220).CGColor;
    _name.placeholder = @"请输入联系人";
    _name.font = FONT(13);
    [_headView addSubview:_name];
    
    _name.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    _name.leftViewMode = UITextFieldViewModeAlways;
    
    
    _phone = [[UITextField alloc]initWithFrame:CGRectMake(120, label3.top, SCREEM_WIDTH - 130, 40)];
    _phone.layer.masksToBounds = YES;
    _phone.layer.cornerRadius = 5;
    _phone.layer.borderWidth = 1;
    _phone.layer.borderColor = RGB(220, 220, 220).CGColor;
    _phone.placeholder = @"请输入联系电话";
    _phone.font = FONT(13);
    [_headView addSubview:_phone];
    
    _phone.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    _phone.leftViewMode = UITextFieldViewModeAlways;
    
}



- (void)initTableView  {
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64  - 50)];
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
    
    self.tableView.tableHeaderView = self.headView;
    
}


- (void)headRefreshing {
    
    [_dataSource removeAllObjects];
    
    [_tableView.mj_header endRefreshing];
    
//    [self loadData];
    
    [self loadBanner];
}


- (void)footRefreshing {
    
    [_tableView.mj_footer endRefreshing];
    
//    [self loadData];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _dataSource.count;
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


- (void)loadData {
    
    NSString * contactname = _name.text;
    NSString * contactmobile  = _phone.text;
    NSString * description  = _textView.textView.text;
    
    
    if(contactname.length <= 0){
        [HUDManager alertText:_name.placeholder];
        return;
    }
    
    if(contactmobile.length <= 0){
        [HUDManager alertText:_phone.placeholder];
        return;
    }
    if(description.length <= 0){
        
        [HUDManager alertText:@"请输入需求描述"];
        return;
    }
    
    NSString *url = HOSTAPIKEY(@"api/public/pubdemand");
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString *token = [UserManager getToken];
    
    [parameters setObject:token forKey:@"token"];
    [parameters setObject:contactname forKey:@"contactname"];
    [parameters setObject:contactmobile forKey:@"contactmobile"];
    [parameters setObject:description forKey:@"description"];
    
    [NetWorkManager netWorkPostURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        
        if([dict[@"res"] integerValue] == 1){
            
            
            _name.text = @"";
            _phone.text = @"";
            _textView.textView.text = @"";
            [_textView textViewDidChange:_textView.textView];
            
            TipViewController * nextVC = [[TipViewController alloc]init];
            nextVC.tipTitle = @"提交成功";
            nextVC.tipText = @"提交成功";
            nextVC.tipDetail = @"稍后有专业的汽车顾问为您服务\n请保持电话畅通！";
            
            UIBaseNavigationController *navi = [[UIBaseNavigationController alloc]initWithRootViewController:nextVC];
            
            [self presentViewController:navi animated:YES completion:nil];
        }
        
        
        [HUDManager alertText:dict[@"msg"]];
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
    
    [parameters setObject:@(5) forKey:@"type"];
    
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
