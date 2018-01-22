//
//  DaiKuanViewController.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/26.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "DaiKuanViewController.h"

#import "CarTextView.h"

#import <SDCycleScrollView.h>

#import "InfoCarsViewController.h"

#import "NJCarView.h"

#import "UPDatePickerView.h"

#import "CarProvinceView.h"

#import "DGDatePicker.h"

@interface DaiKuanViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic ,strong)UIScrollView * scrollView;

@property (nonatomic ,strong)CarTextView * carBrand;
@property (nonatomic ,strong)CarTextView * carDate;
@property (nonatomic ,strong)CarTextView * carNum;
@property (nonatomic ,strong)CarTextView * contract;
@property (nonatomic ,strong)CarTextView * phone;
@property (nonatomic ,strong)CarTextView * carVIN;

@property (nonatomic,strong)SDCycleScrollView* cycleScrollView;

@property (nonatomic ,strong)NJCarView * carView;
@property (nonatomic ,strong)CarModel * carModel;

@property (nonatomic ,strong)UIButton *sureBtn;

@end

@implementation DaiKuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"贷款"];
    
    [self creatView];
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



- (NJCarView *)carView {
    
    if(_carView == nil){
        
        CGFloat w = CAR_WIDTH;
        CGFloat h = w*(228/456.f);
        
        _carView = [[NJCarView alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - w - 15, self.cycleScrollView.bottom + 10, w, h)];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, _carView.width, _carView.height)];
        
        [btn addTarget:self action:@selector(carSelAction) forControlEvents:UIControlEventTouchUpInside];
        [_carView addSubview:btn];
        
    }
    
    return _carView;
}



- (void)creatView {
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT)];
    
    [self.view addSubview:_scrollView];
    
    
    SDCycleScrollView *cycleScrollView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_WIDTH*0.5)];
    
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    cycleScrollView.clipsToBounds = YES;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
    [_scrollView addSubview:cycleScrollView];
    
    self.cycleScrollView = cycleScrollView;
    
//    NSArray *array = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1505877568574&di=972e4c8be017ddc6ea15cb78b24d25e6&imgtype=0&src=http%3A%2F%2Fpic35.nipic.com%2F20131118%2F7755667_194747088391_2.jpg"];
//    
//    self.cycleScrollView.imageURLStringsGroup = array;
    
    
    NSMutableArray *array = [NSMutableArray array];
    
    for(NSDictionary *dic in self.adList){
        
        NSString *url = dic[@"imageurl"];
        [array addObject:url];
    }
    
    self.cycleScrollView.imageURLStringsGroup = array;
    
    
    _carBrand = [[CarTextView alloc]initWithFrame:CGRectMake(0, cycleScrollView.bottom + 10, SCREEM_WIDTH, 50)];
    _carBrand.title.text = @"选择车辆：";
    _carBrand.textField.placeholder = @"请选择车辆信息";
    [_scrollView addSubview:_carBrand];
    
    _carDate = [[CarTextView alloc]initWithFrame:CGRectMake(0, _carBrand.bottom, SCREEM_WIDTH, 50)];
    _carDate.title.text = @"预约时间：";
    _carDate.textField.placeholder = @"请选择预约时间";
    [_scrollView addSubview:_carDate];
    
    
//    _carNum = [[CarTextView alloc]initWithFrame:CGRectMake(0, _carDate.bottom, SCREEM_WIDTH, 50)];
//    _carNum.title.text = @"首次上牌时间：";
//    _carNum.textField.placeholder = @"请选择车辆年份";
//    [_scrollView addSubview:_carNum];
    
    _contract = [[CarTextView alloc]initWithFrame:CGRectMake(0, _carDate.bottom, SCREEM_WIDTH, 50)];
    _contract.title.text = @"里程数：";
    _contract.textField.placeholder = @"请输入车辆行驶里程数";
    [_scrollView addSubview:_contract];
    
//    _phone = [[CarTextView alloc]initWithFrame:CGRectMake(0, _contract.bottom, SCREEM_WIDTH, 50)];
//    _phone.title.text = @"联系电话：";
//    _phone.textField.placeholder = @"请输入联系电话";
//    [_scrollView addSubview:_phone];
    
    //    _carVIN = [[CarTextView alloc]initWithFrame:CGRectMake(0, _phone.bottom, SCREEM_WIDTH, 50)];
    //    _carVIN.title.text = @"车架后四位：";
    //    _carVIN.textField.placeholder = @"请输入车架后四位";
    //    [_scrollView addSubview:_carVIN];
    
    
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15, _contract.bottom + 64, SCREEM_WIDTH - 30, 44)];
    
    btn.backgroundColor = MAINCOLOR;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 4;
    
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_scrollView addSubview:btn];
    
    self.sureBtn = btn;
    
    _scrollView.contentSize = CGSizeMake(0, btn.bottom +20);
    
    __weak typeof(self) weak = self;
    
    [_carBrand addBtnInTextField];
    
    _carBrand.clickBlock = ^(CarTextView *carTextView) {
        
        [weak carSelAction];
    };
    
    
    [_carDate addBtnInTextField];
    
    _carDate.clickBlock = ^(CarTextView *carTextView) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow ;
        
        [DPDatePickerView showInView:window success:^(NSString *date) {
            
            carTextView.textField.text = date;
        }];
    };
    
    [_carNum addBtnInTextField];
    
    _carNum.clickBlock = ^(CarTextView *carTextView) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [CarProvinceView showInView:window array:[DGDatePicker getCurrentDateArray] success:^(NSString *dateString) {
            
            weak.carNum.textField.text = dateString;
        }];
    };
    
    _scrollView.contentSize = CGSizeMake(0, btn.bottom + 20 + 64);
}


- (void)carSelAction {
    
    InfoCarsViewController *nextVC = [[InfoCarsViewController alloc]init];
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
    
    nextVC.selCarBlock = ^(CarModel *model) {
        
        self.carModel = model;
        [self.scrollView addSubview:self.carView];
        [self.carView dataWithModel:model];
        [self changeframe];
    };
}



- (void)changeframe {
    
    _carBrand.textField.hidden = YES;
    
    _carDate.frame = CGRectMake(0, self.carView.bottom, SCREEM_WIDTH, 50);
//    _carNum.frame = CGRectMake(0, _carDate.bottom, SCREEM_WIDTH, 50);
    
    _contract.frame = CGRectMake(0, _carDate.bottom, SCREEM_WIDTH, 50);
    _phone.frame = CGRectMake(0, _contract.bottom, SCREEM_WIDTH, 50);
    
    UIButton*btn = self.sureBtn;
    
    btn.frame = CGRectMake(15, _contract.bottom + 64, SCREEM_WIDTH - 30, 44);
    
    _scrollView.contentSize = CGSizeMake(0, btn.bottom + 20 + 64);
}


- (void)btnAction {
    
    [self uploadData];
}



- (void)uploadData {
    
    
    NSString * shopid = _shopModel.Id;
    NSString * startdate = _carDate.textField.text;
    NSString * carid = _carModel.Id;

//    NSString * cardate = _carNum.textField.text;
    NSString * mileage = _contract.textField.text;
    
    if(shopid == nil){
        [HUDManager alertText:@"请选择保险种类"];
        return;
    }
    
    if(carid == nil){
        [HUDManager alertText:@"请选择车辆"];
        return;
    }
    
    if(startdate.length <= 0){
        [HUDManager alertText:_carDate.textField.placeholder];
        return;
    }
    
//    if(cardate.length <= 0){
//        [HUDManager alertText:_carNum.textField.text];
//        return;
//    }
    
    if(mileage.length <= 0){
        [HUDManager alertText:_contract.textField.placeholder];
        return;
    }
    
    
    
    //    _model.cateid = @"1";
    
    
    NSString *url = HOSTAPIKEY(@"api/public/submitdkorder");
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    
    NSString *token = [UserManager getToken];
    
    [parameters setObject:token forKey:@"token"];
    
    [parameters setObject:shopid forKey:@"shopid"];
    [parameters setObject:carid forKey:@"carid"];
    [parameters setObject:startdate forKey:@"startdate"];
    [parameters setObject:mileage forKey:@"mileage"];
    
    //    [parameters setObject:cardate forKey:@"cardate"];
    
    [NetWorkManager netWorkPostURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        
        if([dict[@"res"] integerValue] == 1){
            
//            [HUDManager alertText:dict[@"msg"]];
            
            
            TipViewController * nextVC = [[TipViewController alloc]init];
            nextVC.tipTitle = @"预约成功";
            nextVC.tipText = @"预约成功";
            nextVC.tipDetail = @"您的贷款申请已提交成功\n我们会尽快联系您，请保持电话畅通！";
            
            UIBaseNavigationController *navi = [[UIBaseNavigationController alloc]initWithRootViewController:nextVC];
            
            [self presentViewController:navi animated:YES completion:nil];
        }
        else {
            
            [HUDManager alertText:dict[@"msg"]];
        }
        
    }];
}





@end
