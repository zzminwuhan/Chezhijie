//
//  CheXianEditViewController.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/10.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "CheXianEditViewController.h"

#import "CarTextView.h"

#import <SDCycleScrollView.h>

#import "InfoCarsViewController.h"

#import "NJCarView.h"

#import "UPDatePickerView.h"

#import "CheXianPopView.h"

@interface CheXianEditViewController ()<SDCycleScrollViewDelegate>

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

@implementation CheXianEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"车险"];
    
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
    
    
    NSMutableArray *array = [NSMutableArray array];
    
    for(NSDictionary *dic in self.adList){
        
        NSString *url = dic[@"imageurl"];
        [array addObject:url];
    }
    
    self.cycleScrollView.imageURLStringsGroup = array;
    
    
    _carBrand = [[CarTextView alloc]initWithFrame:CGRectMake(0, cycleScrollView.bottom + 10, SCREEM_WIDTH, 50)];
    _carBrand.title.text = @"选择车辆：";
    _carBrand.textField.placeholder = @"请选择车辆";
    [_scrollView addSubview:_carBrand];

    
    _carNum = [[CarTextView alloc]initWithFrame:CGRectMake(0, _carBrand.bottom, SCREEM_WIDTH, 50)];
    _carNum.title.text = @"保险种类：";
    _carNum.textField.placeholder = @"请选择保险种类(多选)";
    [_scrollView addSubview:_carNum];
    
    _contract = [[CarTextView alloc]initWithFrame:CGRectMake(0, _carNum.bottom, SCREEM_WIDTH, 50)];
    _contract.title.text = @"联系人：";
    _contract.textField.placeholder = @"请输入联系人姓名";
    [_scrollView addSubview:_contract];
    
    _phone = [[CarTextView alloc]initWithFrame:CGRectMake(0, _contract.bottom, SCREEM_WIDTH, 50)];
    _phone.title.text = @"联系电话：";
    _phone.textField.placeholder = @"请输入联系电话";
    [_scrollView addSubview:_phone];
    
//    _carVIN = [[CarTextView alloc]initWithFrame:CGRectMake(0, _phone.bottom, SCREEM_WIDTH, 50)];
//    _carVIN.title.text = @"车架后四位：";
//    _carVIN.textField.placeholder = @"请输入车架后四位";
//    [_scrollView addSubview:_carVIN];
    
    _carDate = [[CarTextView alloc]initWithFrame:CGRectMake(0, _phone.bottom, SCREEM_WIDTH, 50)];
    _carDate.title.text = @"预约时间：";
    _carDate.textField.placeholder = @"请选择预约时间";
    [_scrollView addSubview:_carDate];
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15, _carDate.bottom + 64, SCREEM_WIDTH - 30, 44)];
    
    btn.backgroundColor = MAINCOLOR;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 4;
    
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_scrollView addSubview:btn];
    
    self.sureBtn = btn;
    
    _scrollView.contentSize = CGSizeMake(0, btn.bottom +20);
    
    
//    _carNum.textField.text = _shopModel.name;
    
    __weak typeof(self) weak = self;
    
    [_carBrand addBtnInTextField];
    
    _carBrand.clickBlock = ^(CarTextView *carTextView) {
        
        InfoCarsViewController *nextVC = [[InfoCarsViewController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        [weak.navigationController pushViewController:nextVC animated:YES];
        
        nextVC.selCarBlock = ^(CarModel *model) {
            weak.carModel = model;
            [weak.scrollView addSubview:weak.carView];
            [weak.carView dataWithModel:model];
            [weak changeframe];
        };
    };
    
    [_carNum addBtnInTextField];
    
    _carNum.clickBlock = ^(CarTextView *carTextView) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [CheXianPopView showInView:window shopModel:weak.shopModel success:^{
            
            weak.carNum.textField.text = weak.shopModel.zhonglei;
        }];
        
    };
    
    [_carDate addBtnInTextField];
    
    _carDate.clickBlock = ^(CarTextView *carTextView) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow ;
        
        [DPDatePickerView showInView:window success:^(NSString *date) {
            
            carTextView.textField.text = date;
        }];
    };
    
    _scrollView.contentSize = CGSizeMake(0, btn.bottom + 20 + 64);
}


- (void)changeframe {
    

    _carBrand.textField.hidden = YES;
    
    _carNum.frame = CGRectMake(0, self.carView.bottom, SCREEM_WIDTH, 50);
    
    _contract.frame = CGRectMake(0, _carNum.bottom, SCREEM_WIDTH, 50);
    _phone.frame = CGRectMake(0, _contract.bottom, SCREEM_WIDTH, 50);
    _carDate.frame = CGRectMake(0, _phone.bottom, SCREEM_WIDTH, 50);
    
    UIButton*btn = self.sureBtn;
    
    btn.frame = CGRectMake(15, _carDate.bottom + 64, SCREEM_WIDTH - 30, 44);
    
    _scrollView.contentSize = CGSizeMake(0, btn.bottom + 20 + 64);
    
    
}


- (void)btnAction {
    
    [self uploadData];
}



- (void)uploadData {
    
    
    NSString * shopid = _shopModel.Id;
    NSString * startdate = _carDate.textField.text;
    NSString * carid = _carModel.Id;
    NSString * zhonglei = _shopModel.zhonglei;
    
    NSString * contactname = _contract.textField.text;
    NSString * contactmobile = _phone.textField.text;
    
    if(carid == nil){
        [HUDManager alertText:@"请选择车辆"];
        return;
    }

    if(zhonglei == nil){
        [HUDManager alertText:@"请选择保险种类"];
        return;
    }
    
    if(contactname.length <= 0){
        [HUDManager alertText:_contract.textField.placeholder];
        return;
    }
    
    if(contactmobile.length <= 0){
        [HUDManager alertText:_phone.textField.placeholder];
        return;
    }
    
    if(startdate.length <= 0){
        [HUDManager alertText:_carDate.textField.placeholder];
        return;
    }
    
//    _model.cateid = @"1";
    
    
    NSString *url = HOSTAPIKEY(@"api/public/submitcxorder");
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    
    NSString *token = [UserManager getToken];
    
    [parameters setObject:token forKey:@"token"];
    
    [parameters setObject:shopid forKey:@"shopid"];
    [parameters setObject:carid forKey:@"carid"];
    [parameters setObject:startdate forKey:@"startdate"];
    [parameters setObject:contactname forKey:@"contactname"];
    [parameters setObject:contactmobile forKey:@"contactmobile"];
    [parameters setObject:zhonglei forKey:@"zhonglei"];
    
    
    [NetWorkManager netWorkPostURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        
        if([dict[@"res"] integerValue] == 1){
            
            [HUDManager alertText:dict[@"msg"]];
            
            TipViewController * nextVC = [[TipViewController alloc]init];
            nextVC.tipTitle = @"车险";
            nextVC.tipText = @"提交成功";
            nextVC.tipDetail = @"您的车险已提交成功\n我们会尽快联系您，请保持电话畅通！";
            
            UIBaseNavigationController *navi = [[UIBaseNavigationController alloc]initWithRootViewController:nextVC];
            
            [self presentViewController:navi animated:YES completion:nil];
        }
        else {
            
            [HUDManager alertText:dict[@"msg"]];
        }
        
    }];
}




@end
