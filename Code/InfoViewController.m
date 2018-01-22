//
//  InfoViewController.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/19.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "InfoViewController.h"

#import "AlphaView.h"

#import "InfoModel.h"

#import "SettingsViewController.h"

#import "InfoOrderViewController.h"
#import "InfoCarsViewController.h"

#import "PhoneView.h"

#import "PhotoAlertView.h"

#import "ZSLImagePicker.h"

#import "SKShareView.h"

@interface InfoViewController ()<UITableViewDelegate,UITableViewDataSource >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic ,strong)UIView *headView;

@property (nonatomic ,strong)AlphaView *headBarView;

@property (nonatomic ,strong)UIImageView *bgImageView;
@property (nonatomic ,strong)UIImageView *imgView;
@property (nonatomic ,strong)UILabel *label;

@property (nonatomic ,strong)UIButton *phoneBtn;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"车之介"];
    
    self.dataSource = [NSMutableArray array];
    
    [self initPhoneLabel];
    
    [self initData];

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


- (void)initData {
    
    InfoModel *model1 = [InfoModel modelTitle:@"我的订单" img:@"info_001"];
    InfoModel *model2 = [InfoModel modelTitle:@"我的车辆" img:@"info_002"];
    InfoModel *model3 = [InfoModel modelTitle:@"客服与帮助" img:@"info_003"];
    InfoModel *model4 = [InfoModel modelTitle:@"关于我们" img:@"info_004"];
    InfoModel *model5 = [InfoModel modelTitle:@"推荐" img:@"info_005"];
    
    [self.dataSource addObjectsFromArray:@[model1,model2,model3,model4,model5]];
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
    label.text = @"我的";
    label.textColor = RGB(255, 255, 255);
    
    [_headBarView addSubview:label];
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 50, 20, 50, 44)];
    [btn setImage:[UIImage imageNamed:@"settings"] forState:UIControlStateNormal];
    [_headBarView addSubview:btn];
    
    [btn addTarget:self action:@selector(btnRightItemAction) forControlEvents:UIControlEventTouchUpInside];
}


- (void)btnRightItemAction {
 
    SettingsViewController *nextVC = [[SettingsViewController alloc]init];
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}


- (void)initPhoneLabel {
    
    _phoneBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 160, 44)];
    _phoneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _phoneBtn.userInteractionEnabled = NO;
    [_phoneBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
//    [_phoneBtn setTitle:@"021-63998630" forState:UIControlStateNormal];
    _phoneBtn.titleLabel.font = FONT15;
    [_phoneBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [_phoneBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [_phoneBtn setImage:[UIImage imageNamed:@"order_phone"] forState:UIControlStateNormal];
}


- (UIView *)headView {
    
    if(_headView == nil){
        
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_WIDTH*0.72)];
        _headView.backgroundColor = [UIColor whiteColor];
        
        [self creatHeadView];
    }
    
    return _headView;
}


- (void)creatHeadView {
    
    
    _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, _headView.height)];
    
    
    [_headView addSubview:_bgImageView];
    _bgImageView.image = [UIImage imageNamed:@"info_bg"];
    
    CGFloat w1 = SCREEM_WIDTH/4;
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w1, w1)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = bgView.height/2;
    [_headView addSubview:bgView];
    
    
    CGFloat w = bgView.width - 8;
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, w, w)];
    _imgView.backgroundColor = [UIColor lightGrayColor];
    _imgView.layer.masksToBounds = YES;
    _imgView.layer.cornerRadius = _imgView.height/2;
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    _imgView.clipsToBounds = YES;
    [_headView addSubview:_imgView];
    
    CGPoint point = CGPointMake(_bgImageView.center.x, _bgImageView.center.y+15);
    bgView.center = point;
    _imgView.center = point;
    
    _imgView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgTap:)];
    [_imgView addGestureRecognizer:tap];
    
    
    CGFloat h = _headView.height - bgView.bottom;
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, bgView.bottom, SCREEM_WIDTH, h)];
    _label.textColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentCenter;
    [_headView addSubview:_label];
    
    
}


- (void)imgTap:(UITapGestureRecognizer*)sender {
    
    [PhotoAlertView showInView:self.view.window takePhoto:^{
        
        
        ZSLImagePicker *picker = [ZSLImagePicker defaultImagePicker];
        
        picker.completion = ^(NSArray *imgArray){
            
            if(imgArray.count > 0){
                
//                _selImage = imgArray[0];
//                _headView.imgView.image = _selImage;
                [self editAvatarWithImage:imgArray[0]];
            }
        };
        
        [picker takePhotoWithVC:self];
        
    } getPhotos:^{
        
        ZSLImagePicker *picker = [ZSLImagePicker defaultImagePicker];
        
        picker.completion = ^(NSArray *imgArray){
            
            if(imgArray.count > 0){
                
//                _selImage = imgArray[0];
//                _headView.imgView.image = _selImage;
                
                [self editAvatarWithImage:imgArray[0]];
            }
        };
        
        [picker pickImageWithVC:self];
    }];
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
    
    
    self.tableView.tableHeaderView = self.headView;
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
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        
    }
    
    if(_dataSource.count <= 0){
        return cell;
    }
    
    cell.frame = CGRectMake(0, 0, SCREEM_WIDTH, 50);
    
    InfoModel *model = _dataSource[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:model.imgName];
    
    cell.textLabel.text = model.title;
    
    cell.textLabel.font = FONT15;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if(indexPath.row == 2){
//        [cell addSubview:_phoneBtn];
        cell.accessoryView = _phoneBtn;
    }
    else {
        cell.accessoryView = nil;
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger tag = indexPath.row;
    
    if(tag == 0){
        InfoOrderViewController *nextVC = [[InfoOrderViewController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else if (tag == 1){
        InfoCarsViewController *nextVC = [[InfoCarsViewController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else if (tag == 2){
        
        [PhoneView showInWindowWithPhone2:_phoneBtn.titleLabel.text];
    }
    else if (tag == 3){
        
        NSString *url = [NSString stringWithFormat:@"%@api/public/about?id=1",HOST];
        
        [WKWebViewController pushVC:self title:@"关于我们" URL:url];
    }
    else if (tag == 4){
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [SKShareView showInView:window success:^(NSInteger tag) {
            
        }];
    }

}





- (void)loadData {


    NSString *url = HOSTAPIKEY(@"api/public/getmemberinfo");
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString * token = [UserManager getToken];
    
    [parameters setObject:token forKey:@"token"];
    
    [NetWorkManager netWorkGetURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        
        if([dict[@"res"] integerValue] == 1){
            
            
            NSString *face = DictStr(dict, @"face");
            NSString *mobile = DictStr(dict, @"mobile");
            NSString *kefu = DictStr(dict, @"kefu");
            
            
            [_imgView sd_setImageWithURL:[NSURL URLWithString:face]];
            _label.text = [NSString stringWithFormat:@"手机号码：%@",mobile];
            [_phoneBtn setTitle:kefu forState:UIControlStateNormal];
            
        }
        else {
            
            [HUDManager alertText:dict[@"msg"]];
        }
        
        
    }];

    
}


- (void)editAvatarWithImage:(UIImage*)image {
    
    NSString *url = HOSTAPIKEY(@"api/public/updatedata");
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    
    NSString * token = [UserManager getToken];
    
    [parameters setObject:token forKey:@"token"];
    
    [NetWorkManager netWorkPostURL:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

        NSData*imageData  = UIImageJPEGRepresentation(image, 0.8);
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@00.jpg", str];
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
        NSLog(@"发送");
        
        
    } completion:^(NSDictionary *dict) {
        
        if([dict[@"res"] integerValue] == 1){
            
            _imgView.image = image;
        }
        
        
        [HUDManager alertText:dict[@"msg"]];
    }];

}



@end
