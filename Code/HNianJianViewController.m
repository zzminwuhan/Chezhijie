//
//  HNianJianViewController.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/24.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "HNianJianViewController.h"

#import "CarTextView.h"

#import <SDCycleScrollView.h>

#import "InfoCarsViewController.h"

#import "NJCarView.h"

#import "UPDatePickerView.h"

#import "ShopPickerView.h"

#import "AlipayManager.h"

#import "SKWX.h"

#import "SuccessViewController.h"

#import "NianJianPopView.h"


@interface HNianJianViewController ()<SDCycleScrollViewDelegate>

@property (nonatomic ,strong)UIScrollView * scrollView;

@property (nonatomic ,strong)CarTextView * carBrand;
@property (nonatomic ,strong)CarTextView * carAdd;
@property (nonatomic ,strong)CarTextView * carDate;
@property (nonatomic ,strong)CarTextView * carNum;
@property (nonatomic ,strong)CarTextView * contract;
@property (nonatomic ,strong)CarTextView * phone;
@property (nonatomic ,strong)CarTextView * carVIN;

@property (nonatomic,strong)SDCycleScrollView* cycleScrollView;
@property (nonatomic ,strong)NSMutableArray *adList;

@property (nonatomic ,strong)NJCarView * carView;

@property (nonatomic ,strong)CarModel * carModel;

@property (nonatomic ,strong)UIView * tipView;

@property (nonatomic ,strong)ShopModel *model;

@property (nonatomic ,strong)UIButton *selBtn;

@property (nonatomic ,strong)UIButton *btn1;

@property (nonatomic ,strong)UIButton *btn2;

@property (nonatomic ,strong)NSString *type;

@property (nonatomic ,strong)NSString* price;

//亲自办理费用
@property (nonatomic ,strong)NSString* personallyprice;
//上门代办费用
@property (nonatomic ,strong)NSString* replaceprice;

@property (nonatomic ,strong)UIButton *footbtn;



@end

@implementation HNianJianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.adList = [NSMutableArray array];
    
    [self initNaviBarBtn:@"年检"];
    
    _price = @"300";
    
    [self creatView];
    
    [self creatFootBtn];
    
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


- (NJCarView *)carView {
    
    if(_carView == nil){
        
        CGFloat w = CAR_WIDTH;
        CGFloat h = w*(228/456.f);
        
        _carView = [[NJCarView alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - w - 15, _carNum.bottom + 10, w, h)];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, _carView.width, _carView.height)];
        
        [btn addTarget:self action:@selector(carSelAction) forControlEvents:UIControlEventTouchUpInside];
        [_carView addSubview:btn];
        
    }
    
    return _carView;
}


- (void)creatFootBtn {
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, SCREEM_HEIGHT - 64 - 44, SCREEM_WIDTH, 44)];
    btn.backgroundColor = MAINCOLOR;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"立即预约（￥300）" forState:UIControlStateNormal];
    btn.titleLabel.font = FONT15;
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
 
    self.footbtn = btn;
    [self.footbtn setTitle:[NSString stringWithFormat:@"立即预约（￥%@）",_price] forState:UIControlStateNormal];
}


- (void)creatView {
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT - 64)];
    
    [self.view addSubview:_scrollView];
    
    
    SDCycleScrollView *cycleScrollView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_WIDTH*0.5)];
    
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    cycleScrollView.clipsToBounds = YES;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
    [_scrollView addSubview:cycleScrollView];
    
    self.cycleScrollView = cycleScrollView;
 
    
    
    _carBrand = [[CarTextView alloc]initWithFrame:CGRectMake(0, cycleScrollView.bottom + 10, SCREEM_WIDTH, 50)];
    _carBrand.title.text = @"检测站：";
    _carBrand.textField.placeholder = @"请选择检测站";
    [_scrollView addSubview:_carBrand];
    
    _carAdd = [[CarTextView alloc]initWithFrame:CGRectMake(0, _carBrand.bottom, SCREEM_WIDTH, 50)];
    _carAdd.title.text = @"检测站地址：";
    _carAdd.textField.placeholder = @"请选择检测站";
    [_scrollView addSubview:_carAdd];
    
    _carNum = [[CarTextView alloc]initWithFrame:CGRectMake(0, _carAdd.bottom, SCREEM_WIDTH, 50)];
    _carNum.title.text = @"预约时间：";
    _carNum.textField.placeholder = @"请选择预约时间";
    [_scrollView addSubview:_carNum];
    
    _contract = [[CarTextView alloc]initWithFrame:CGRectMake(0, _carNum.bottom, SCREEM_WIDTH, 50)];
    _contract.title.text = @"选择车辆：";
    _contract.textField.placeholder = @"请选择需检测的车辆";
    [_scrollView addSubview:_contract];
    
   
    
    
    _scrollView.contentSize = CGSizeMake(0, _contract.bottom +20 +64);
    
    [self creattipView];
    
    __weak typeof(self) weak = self;
    
    [_carBrand addBtnInTextField];
    
    _carBrand.clickBlock = ^(CarTextView *carTextView) {
      
        [weak loadData];
    };
    
    [_carAdd addBtnInTextField];
    
    _carAdd.clickBlock = ^(CarTextView *carTextView) {
        
        [weak loadData];
    };
    
    [_carNum addBtnInTextField];
    
    _carNum.clickBlock = ^(CarTextView *carTextView) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow ;
        
        [UPDatePickerView showInView:window success:^(NSString *date) {
            
            carTextView.textField.text = date;
        }];
    };
    
    
    [_contract addBtnInTextField];
    _contract.clickBlock = ^(CarTextView *carTextView) {
        
        [weak carSelAction];
    };
    
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
    
    _contract.textField.hidden = YES;
    
    _tipView.frame = CGRectMake(0, self.carView.bottom + 30, SCREEM_WIDTH, _tipView.height);
    
    _scrollView.contentSize = CGSizeMake(0, _tipView.bottom +20 +64);
}


- (void)creattipView {
    
    
    _tipView = [[UIView alloc]initWithFrame:CGRectMake(0, _contract.bottom + 30, SCREEM_WIDTH, 150)];
    
     [_scrollView addSubview:_tipView];
    
#pragma mark 按钮1
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 5)];
    line.backgroundColor = RGB(240, 240, 240);
    [_tipView addSubview:line];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 44)];
    
    [btn1 setAttributedTitle:[self setTip] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"idcard_btn"] forState:UIControlStateNormal];
    [btn1 setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [btn1 setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_tipView addSubview:btn1];
    
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, btn1.bottom, SCREEM_WIDTH, 0.5)];
    line2.backgroundColor = RGB(200, 200, 200);
    [_tipView addSubview:line2];
    
#pragma mark 按钮2
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, line2.bottom, 100, 44)];
    [btn2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [btn2 setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [btn2 setImage:[UIImage imageNamed:@"idcard_btn_n"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"idcard_btn"] forState:UIControlStateSelected];

     btn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_tipView addSubview:btn2];
    [btn2 setTitle:@"亲自办理" forState:UIControlStateNormal];
    [btn2 setTitleColor:RGB(50, 50, 50) forState:UIControlStateNormal];
    btn2.titleLabel.font = FONT12;

    
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(100, line2.bottom, 100, 44)];
    [btn3 setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [btn3 setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
     btn3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn3 setImage:[UIImage imageNamed:@"idcard_btn_n"] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"idcard_btn"] forState:UIControlStateSelected];
    
    [btn3 setTitle:@"上门代办" forState:UIControlStateNormal];
    [btn3 setTitleColor:RGB(50, 50, 50) forState:UIControlStateNormal];
    [_tipView addSubview:btn3];
    btn3.titleLabel.font = FONT12;
    
    [btn2 addTarget:self action:@selector(payBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 addTarget:self action:@selector(payBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _btn1 = btn2;
    _btn2 = btn3;
    _type = @"2";
//    [self payBtnAction:btn2];
    
    UILabel *line3 = [[UILabel alloc]initWithFrame:CGRectMake(0, btn3.bottom, SCREEM_WIDTH, 5)];
    line3.backgroundColor = RGB(240, 240, 240);
    [_tipView addSubview:line3];
    
    CGFloat y1 = line3.bottom;
    CGFloat h = 0;
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(15, y1 + h*2+10, SCREEM_WIDTH - 30, 30)];
    label4.textColor = RGB(50, 50, 50);
    label4.text = @"车主须知：";
    label4.font = FONT15;
    [_tipView addSubview:label4];
    
    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(0, y1 + h*2+10, 5, 30)];
    label5.backgroundColor = RGB(41, 181, 235);
    [_tipView addSubview:label5];
    
    
    UILabel *label6 = [[UILabel alloc]initWithFrame:CGRectMake(15, y1 + h*2+50, SCREEM_WIDTH - 30, 30)];
    label6.numberOfLines = 0;
    label6.attributedText = [self tipAttr];
    [_tipView addSubview:label6];
    
    [label6 sizeToFit];
    
    
    
    _tipView.frame = CGRectMake(0, _tipView.top, SCREEM_WIDTH, label6.bottom);
   
    _scrollView.contentSize = CGSizeMake(0, _tipView.bottom+100);
    
    
}


- (NSAttributedString*)tipAttr {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;// 字体的行间距
//    paragraphStyle.headIndent = 15.f;
//    paragraphStyle.firstLineHeadIndent = 15.f;//首行缩进
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]init];
    
    
    NSDictionary * attributes1 = @{NSFontAttributeName:FONT12,NSForegroundColorAttributeName:RGB(100, 100, 100), NSParagraphStyleAttributeName:paragraphStyle};
    
//    (***平台查询违章缴费)
    NSString *string0 = @"1.预约前须将违章处理清空\n";
    NSString *string1 = @"2.检测须在预约时间前5分钟到达检测站\n";
    NSString *string2 = @"3.到达检测站到办证大厅的导办台提交相关资料(预约码/保单/行驶证/身份证/车钥匙)\n";
    NSString *string3 = @"4.车主进入休息区等待,检测通过后导办台将相关证件资料归还车主,车主直接开车离开\n";
    NSString *string4 = @"5.可预约时间： 周一至周六\n  上午 9:00 - 11:00 \n  下午 13:30 - 16:30\n";
    NSString *string5 = @"6.如预约时间为上午11点后,需要等到下午检测站上班后才会出检测结果\n 如预约时间为下午16点后,需要等到下一个工作日才会出检测结果.上门代验车的选项,代验车加收50元\n";
    NSString *string6 = @"7.验车项目中如发生网络故障问题等一些其他检测站硬件条件导致无法检测，请车主谅解，进行时间将重新调整\n";
    
    NSString *string = @"";
    string = [string stringByAppendingString:string0];
    string = [string stringByAppendingString:string1];
    string = [string stringByAppendingString:string2];
    string = [string stringByAppendingString:string3];
    string = [string stringByAppendingString:string4];
    string = [string stringByAppendingString:string5];
    string = [string stringByAppendingString:string6];
    
    NSAttributedString *attr1 = [[NSAttributedString alloc]initWithString:string attributes:attributes1];
    
    
    [attrStr appendAttributedString:attr1];
    
    return attrStr;
}




- (void)payBtnAction:(UIButton*)btn {
    
    _selBtn.selected = NO;
    _selBtn = btn;
    _selBtn.selected = YES;
    
    if(_selBtn == _btn1){
        _type = @"1";
        _price = self.personallyprice;
        [self.footbtn setTitle:[NSString stringWithFormat:@"立即预约（￥%@）",_price] forState:UIControlStateNormal];
    }
    else if (_selBtn == _btn2){
        _type = @"2";
        _price = self.replaceprice;
        [self.footbtn setTitle:[NSString stringWithFormat:@"立即预约（￥%@）",_price] forState:UIControlStateNormal];
    }
}


- (NSAttributedString *)setTip {
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]init];
    
    
    NSDictionary * attributes1 = @{NSFontAttributeName:FONT12,NSForegroundColorAttributeName:RGB(50, 50, 50)};
    NSDictionary * attributes2 = @{NSFontAttributeName:FONT11,NSForegroundColorAttributeName:RGB(247, 124, 126)};
    
    NSAttributedString *attr1 = [[NSAttributedString alloc]initWithString:@"身份证，行驶证，保险单" attributes:attributes1];
    NSAttributedString *attr2 = [[NSAttributedString alloc]initWithString:@"(请携带好以上资料到监测站)" attributes:attributes2];
    
    [attrStr appendAttributedString:attr1];
    [attrStr appendAttributedString:attr2];
    
    return attrStr;
}


- (void)btnAction {
    
    NSString * shopid = _model.Id;
    NSString * startdate = _carNum.textField.text;
    NSString * carid = _carModel.Id;
    
    if(shopid == nil){
        [HUDManager alertText:@"请选择检查站"];
        return;
    }
    
    if(startdate.length <= 0){
        [HUDManager alertText:@"请选择预约时间"];
        return;
    }
    
    if(carid == nil){
        [HUDManager alertText:@"请选择需检测得车辆"];
        return;
    }
    
    _model.startdate = startdate;
    _model.carname = _carModel.carnumber;
    _model.price = _price ;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [NianJianPopView showInView:window shopModel:_model success:^{
      
        [self nianjianUploadData];
    }];
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
    
    [parameters setObject:@(1) forKey:@"type"];
    
    
    [NetWorkManager netWorkGetURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        
        if([dict[@"res"] integerValue] == 1){
            
            
            NSArray *array = dict[@"elements"];
            
            NSLog(@"%@",array);
            
            NSMutableArray *arr = [NSMutableArray array];
            
            for(NSDictionary *dic in array){
                
                ShopModel *model = [[ShopModel alloc]initWithDict:dic];
                [arr addObject:model];
            }
            
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [ShopPickerView showInView:window array:arr success:^(ShopModel *model) {
                
                self.model = model;
                
                _carBrand.textField.text = model.name;
                _carAdd.textField.text = model.address;
                
                [self loadPrice];
            }];
            
        }
        else {
            
            [HUDManager alertText:dict[@"msg"]];
        }
        
        
    }];
    
    

}


- (void)loadPrice {
    
    NSString *url = HOSTAPIKEY(@"api/public/getnjprice");
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setObject:self.model.Id forKey:@"shopid"];
    
    
    [NetWorkManager netWorkGetURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        
        if([dict[@"res"] integerValue] == 1){
            
            self.personallyprice = DictStr(dict, @"personallyprice");
            self.replaceprice = DictStr(dict, @"replaceprice");
            
            [self payBtnAction:_btn1];
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
    
    [parameters setObject:@(2) forKey:@"type"];
    
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







- (void)nianjianUploadData {
    
    
    NSString * shopid = _model.Id;
    NSString * startdate = _carNum.textField.text;
    NSString * carid = _carModel.Id;
    NSString * type = _type;
    
    if(shopid == nil){
        [HUDManager alertText:@"请选择检查站"];
        return;
    }
    
    if(startdate == nil){
        [HUDManager alertText:@"请选择预约时间"];
        return;
    }
    
    if(carid == nil){
        [HUDManager alertText:@"请选择需检测得车辆"];
        return;
    }
    
    _model.cateid = @"1";
    
    
    NSString *url = HOSTAPIKEY(@"api/public/submitnjorder");
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    
    NSString *token = [UserManager getToken];
    
    [parameters setObject:token forKey:@"token"];
    
    [parameters setObject:shopid forKey:@"shopid"];
    [parameters setObject:carid forKey:@"carid"];
    [parameters setObject:startdate forKey:@"startdate"];
    [parameters setObject:type forKey:@"type"];
    
    
    [NetWorkManager netWorkPostURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        
        if([dict[@"res"] integerValue] == 1){
            
            _model.serialnumber = DictStr(dict, @"serialnumber");
            
            [self payYanghu];
        }
        else {
            
            [HUDManager alertText:dict[@"msg"]];
        }
        
    }];
}


- (void)payYanghu {
    
    NSInteger tag = _model.payType;
    
    if(tag == 1){
        
        [self wxPay];
    }
    else if(tag == 2){
        
        [self aliPay];
    }
}


-  (void)aliPay {
    
    NSString *url = HOSTAPIKEY(@"api/public/getalipaysign");
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString * token = [UserManager getToken];
    
    [parameters setObject:token forKey:@"token"];
    
    [parameters setObject:_model.serialnumber forKey:@"serialnumber"];
    
    [NetWorkManager netWorkPostURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        NSString *sign = DictStr(dict, @"sign");
        
        [AlipayManager alipaySign:sign completion:^(NSDictionary *dict) {
            
            [self yanghuPaySuccess];
        }];
    }];
    
}

- (void)wxPay {
    
    
    NSString *url = HOSTAPIKEY(@"api/public/getprepayid");
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString * token = [UserManager getToken];
    
    [parameters setObject:token forKey:@"token"];
    
    [parameters setObject:_model.serialnumber forKey:@"serialnumber"];
    
    
    
    [NetWorkManager netWorkPostURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        [[SKWX shareSdkWX] wxPayWithDict:dict];
        [[SKWX shareSdkWX] setPaySuccess:^{
            
            [self yanghuPaySuccess];
        }];
        
    }];
}


- (void)yanghuPaySuccess {
    
    _model.price = self.price;
    
    SuccessViewController *nextVC = [[SuccessViewController alloc]init];
    nextVC.hidesBottomBarWhenPushed = YES;
    nextVC.shopModel = _model;
    nextVC.selTag = 1;
    [self.navigationController pushViewController:nextVC animated:YES];
}




@end
