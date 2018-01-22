//
//  CarEditViewController.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/10/9.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "CarEditViewController.h"

#import "CarTextView.h"

#import "DGDatePicker.h"

#import "BrandSelViewController.h"

#import "CarProvinceView.h"

@interface CarEditViewController ()

@property (nonatomic ,strong)UIScrollView * scrollView;

@property (nonatomic ,strong)CarTextView * carBrand;
@property (nonatomic ,strong)CarTextView * carDate;
@property (nonatomic ,strong)CarTextView * carNum;
@property (nonatomic ,strong)CarTextView * contract;
@property (nonatomic ,strong)CarTextView * phone;
@property (nonatomic ,strong)CarTextView * carVIN;

@property (nonatomic ,strong)BrandModel * brand;
@property (nonatomic ,strong)BrandModel * bmodel;

@end

@implementation CarEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"车辆信息"];
    
    [self creatView];
    
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



- (void)creatView {
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT)];
    _scrollView.contentSize = CGSizeMake(SCREEM_WIDTH, SCREEM_HEIGHT);
    [self.view addSubview:_scrollView];
    
    
    _carBrand = [[CarTextView alloc]initWithFrame:CGRectMake(0, 10, SCREEM_WIDTH, 50)];
    _carBrand.title.text = @"品牌型号：";
    _carBrand.textField.placeholder = @"请选择品牌型号";
    [_scrollView addSubview:_carBrand];
    
    _carDate = [[CarTextView alloc]initWithFrame:CGRectMake(0, _carBrand.bottom, SCREEM_WIDTH, 50)];
    _carDate.title.text = @"年份：";
    _carDate.textField.placeholder = @"请选择年份";
    [_scrollView addSubview:_carDate];
    
    _carNum = [[CarTextView alloc]initWithFrame:CGRectMake(0, _carDate.bottom, SCREEM_WIDTH, 50)];
    _carNum.title.text = @"车牌号码：";
    _carNum.textField.placeholder = @"请输入车牌号码";
    [_scrollView addSubview:_carNum];
    
    _carNum.leftView.frame = CGRectMake(0, 0, 50, 36);
    
    
    
    
    _contract = [[CarTextView alloc]initWithFrame:CGRectMake(0, _carNum.bottom, SCREEM_WIDTH, 50)];
    _contract.title.text = @"联系人：";
    _contract.textField.placeholder = @"请输入联系人姓名";
    [_scrollView addSubview:_contract];
    
    _phone = [[CarTextView alloc]initWithFrame:CGRectMake(0, _contract.bottom, SCREEM_WIDTH, 50)];
    _phone.title.text = @"联系电话：";
    _phone.textField.placeholder = @"请输入联系电话";
    [_scrollView addSubview:_phone];
    
    _carVIN = [[CarTextView alloc]initWithFrame:CGRectMake(0, _phone.bottom, SCREEM_WIDTH, 50)];
    _carVIN.title.text = @"车架后四位：";
    _carVIN.textField.placeholder = @"请输入车架后四位";
    [_scrollView addSubview:_carVIN];
    
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15, _carVIN.bottom + 64, SCREEM_WIDTH - 30, 44)];
    
    btn.backgroundColor = MAINCOLOR;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 4;
    
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_scrollView addSubview:btn];
    
    
    
//    __weak typeof(self) weak = self;
    
    
    __weak typeof(self) weak = self;
    [_carNum addProvinceBtnBlock:^{
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [CarProvinceView showInView:window success:^(NSString *province) {
            
            [weak.carNum.provinceBtn setTitle:province forState:UIControlStateNormal];
        }];
    }];
    
    [_carBrand addBtnInTextField];
    _carBrand.clickBlock = ^(CarTextView *carTextView) {
        
        BrandSelViewController *nextVC = [[BrandSelViewController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        [weak.navigationController pushViewController:nextVC animated:YES];
        nextVC.selBrandBlock = ^(BrandModel *brand, BrandModel *model) {
            
            weak.brand = brand;
            weak.bmodel = model;
            
            weak.carBrand.textField.text = model.name;
        };
        
    };
    
    [_carDate addBtnInTextField];
    _carDate.clickBlock = ^(CarTextView *carTextView) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [CarProvinceView showInView:window array:[DGDatePicker getCurrentDateArray] success:^(NSString *dateString) {
            
            weak.carDate.textField.text = dateString;
        }];
    };

    
}

- (void)btnAction {
    
    [self uploadData];
}


// 车辆详情

- (void)loadData {
    
    NSString *url = HOSTAPIKEY(@"api/public/carinfodetail");
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString * token = [UserManager getToken];
    
    [parameters setObject:token forKey:@"token"];
    
    [parameters setObject:_model.Id forKey:@"id"];
    
    
    [NetWorkManager netWorkGetURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        
        if([dict[@"res"] integerValue] == 1){
            
            
            [_model detailWithDict:dict];
            [self dataWithModel];
            
        }
        else {
            
            [HUDManager alertText:dict[@"msg"]];
        }
        
        
    }];

    
}



- (void)dataWithModel {
    
    _carBrand.textField.text = _model.carbrand;
    _carDate.textField.text = _model.cardate;
    
    
    _contract.textField.text = _model.contactname;
    _phone.textField.text = _model.contactmobile;
    _carVIN.textField.text = _model.framenumber;
    
    if(_model.carnumber.length > 0){
        
        const char *c = [_model.carnumber UTF8String];
        
        int num = c[0];
        
        if(num > 128 || num < 0){
            
            _carNum.textField.text = [_model.carnumber substringFromIndex:1];
            [_carNum.provinceBtn setTitle:[_model.carnumber substringToIndex:1] forState:UIControlStateNormal];
        }
        else {
            _carNum.textField.text = _model.carnumber;
        }
    }
    
    
}


- (void)uploadData {
    
    
    NSString *url = HOSTAPIKEY(@"api/public/editcarinfo");
    
    NSString * token = [UserManager getToken];
    
    NSString * Id = _model.Id;
    
    NSString * brandid = _brand.Id;
    NSString * modelid  = _bmodel.Id;
    
    NSString * cardate = _carDate.textField.text;
    NSString * carnumber  = _carNum.textField.text;
    NSString * contactname  = _contract.textField.text;
    NSString * contactmobile  = _phone.textField.text;
    NSString * framenumber  = _carVIN.textField.text; //车架号后四位
    
//    if(brandid == nil){
//        [HUDManager alertText:@"请选择品牌型号"];
//        return;
//    }
//    
//    if(modelid == nil){
//        [HUDManager alertText:@"请选择品牌型号"];
//        return;
//    }
    
    if(cardate.length <= 0){
        [HUDManager alertText:@"请选择首次上牌时间"];
        return;
    }
    
    if(carnumber.length <= 0){
        
        [HUDManager alertText:@"请输入车牌号"];
        return;
    }
    
    if(contactname.length <= 0){
        
        [HUDManager alertText:@"请输入联系人姓名"];
        return;
    }
    
    if(contactmobile.length <= 0){
        [HUDManager alertText:@"请输入联系电话"];
        return;
    }
    
    if(framenumber.length <= 0){
        [HUDManager alertText:@"请输入车架号后四位"];
        return;
    }
    
    carnumber = [NSString stringWithFormat:@"%@%@",_carNum.provinceBtn.titleLabel.text,carnumber];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setObject:token forKey:@"token"];
    [parameters setObject:Id forKey:@"id"];
    
    [parameters setObject:cardate forKey:@"cardate"];
    [parameters setObject:carnumber forKey:@"carnumber"];
    [parameters setObject:contactname forKey:@"contactname"];
    [parameters setObject:contactmobile forKey:@"contactmobile"];
    [parameters setObject:framenumber forKey:@"framenumber"];
    
    if(brandid != nil){
        
        [parameters setObject:brandid forKey:@"brandid"];
    }
    
    if(modelid != nil){
        
        [parameters setObject:modelid forKey:@"modelid"];
    }
    
    
    [NetWorkManager netWorkPostURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        
        if([dict[@"res"] integerValue] == 1){
            
            if(_successBlock != nil){
                _successBlock();
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        [HUDManager alertText:dict[@"msg"]];
    }];
}



@end
