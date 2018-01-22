//
//  LogViewController.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/27.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "LogViewController.h"

#import "RBoxTextView.h"

#import "RegViewController.h"

#import "PwdViewController.h"

#import "GeTuiManager.h"

@interface LogViewController ()

@property (nonatomic ,strong)RBoxTextView * phone ;
@property (nonatomic ,strong)RBoxTextView * password ;

@property (nonatomic ,strong)UIScrollView * headView;

@end

@implementation LogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self initNaviBarBtn:@"登录"];
    [self initTitle:@"登录"];
    
    [self initHeadView];
    
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



- (void)initHeadView {
    
    _headView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT)];
    
    [self.view addSubview:_headView];
    
    UIImageView * logo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 85, 36)];
    logo.image = [UIImage imageNamed:@"logo"];
    logo.center = CGPointMake(SCREEM_WIDTH/2, 70);
    [_headView addSubview:logo];
    
    
    _phone = [[RBoxTextView alloc]initWithFrame:CGRectMake(0, 140, SCREEM_WIDTH, 44)];
    _phone.title.text = @"手机号码";
    _phone.textField.placeholder = @"请输入手机号码";
    [_headView addSubview:_phone];
    
    
    _password = [[RBoxTextView alloc]initWithFrame:CGRectMake(0, 140+44, SCREEM_WIDTH, 44)];
    _password.title.text = @"密码";
    _password.textField.placeholder = @"请输入密码";
    _password.textField.secureTextEntry = YES;
    [_headView addSubview:_password];
    
    [_password setBottom];
    
    
    
    UIButton * pwdBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 140, 140+88, 60, 40)];
    pwdBtn.titleLabel.font = FONT12;
    [pwdBtn setTitleColor:RGB(247, 124, 126) forState:UIControlStateNormal];
    [pwdBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    
    
    UIButton * regBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 75, 140+88, 60, 40)];
    regBtn.titleLabel.font = FONT12;
    [regBtn setTitleColor:RGB(247, 124, 126) forState:UIControlStateNormal];
    [regBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    
    
    [_headView addSubview:pwdBtn];
    [_headView addSubview:regBtn];
    
    [regBtn addTarget:self action:@selector(regBtnAction) forControlEvents:UIControlEventTouchUpInside];

    [pwdBtn addTarget:self action:@selector(pwdBtnAction) forControlEvents:UIControlEventTouchUpInside];

    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 77, 140+88 + 14, 1, 12)];
    line.backgroundColor = RGB(247, 124, 126);
    [_headView addSubview:line];
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15, _password.bottom + 94, SCREEM_WIDTH - 30, 44)];
    
    btn.backgroundColor = MAINCOLOR;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"登录" forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 4;
    
    [btn addTarget:self action:@selector(logBtnAction) forControlEvents:UIControlEventTouchUpInside];

    [_headView addSubview:btn];
    
//    _phone.textField.text = @"13817967384";
//    _password.textField.text = @"123456";
    
}



- (void)regBtnAction {
    
    RegViewController *nextVC = [[RegViewController alloc]init];
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)pwdBtnAction {
    
    PwdViewController *nextVC = [[PwdViewController alloc]init];
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}


- (void)logBtnAction {
    
    
    NSString *url = HOSTAPIKEY(@"api/public/login");
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    NSString * loginname = _phone.textField.text;
    NSString * loginpwd  = _password.textField.text;
    
    NSString *clientid = [GeTuiSdk clientId];
    
    if(clientid == nil){
        clientid = @"";
    }
    
    [parameters setObject:loginname forKey:@"loginname"];
    [parameters setObject:loginpwd forKey:@"loginpwd"];
    [parameters setObject:clientid forKey:@"clientid"];
    [parameters setObject:@"2" forKey:@"clienttype"];
    
    [NetWorkManager netWorkPostURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        
        if([dict[@"res"] integerValue] == 1){
            
            [UserManager loginWithToken:dict[@"token"]];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"lognotification" object:nil];
        }
        
        
        [HUDManager alertText:dict[@"msg"]];
    }];

    
    
}





@end
