//
//  RegViewController.m
//  CarIntermediator
//
//  Created by 李加建 on 2017/9/27.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "RegViewController.h"

#import "RBoxTextView.h"

#import "ICodeButton.h"

#import "FillCarViewController.h"

#import <IQKeyboardManager.h>

@interface RegViewController ()

@property (nonatomic ,strong)RBoxTextView * phone ;
@property (nonatomic ,strong)RBoxTextView * password ;
@property (nonatomic ,strong)RBoxTextView * passwordA ;
@property (nonatomic ,strong)RBoxTextView * code ;


@property (nonatomic ,strong)UIScrollView * headView;

@end

@implementation RegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"注册"];
    
    [self initHeadView];
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
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
    _headView.contentSize = CGSizeMake(SCREEM_WIDTH, SCREEM_HEIGHT);
    [self.view addSubview:_headView];

    
    UIImageView * logo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 85, 36)];
    logo.image = [UIImage imageNamed:@"logo"];
    logo.center = CGPointMake(SCREEM_WIDTH/2, 70);
    [_headView addSubview:logo];
    
    CGFloat y = 140;
    
    _phone = [[RBoxTextView alloc]initWithFrame:CGRectMake(0, y, SCREEM_WIDTH, 44)];
    _phone.title.text = @"手机号码";
    _phone.textField.placeholder = @"请输入手机号码";
    [_headView addSubview:_phone];
    
    _code = [[RBoxTextView alloc]initWithFrame:CGRectMake(0, y+44, SCREEM_WIDTH, 44)];
    _code.title.text = @"验证码";
    _code.textField.placeholder = @"输入验证码";
    [_headView addSubview:_code];
    
    [_code setBottom];

    _password = [[RBoxTextView alloc]initWithFrame:CGRectMake(0, y+44*2+10, SCREEM_WIDTH, 44)];
    _password.title.text = @"密码";
    _password.textField.placeholder = @"请输入密码";
    [_headView addSubview:_password];
    
    
    
    _passwordA = [[RBoxTextView alloc]initWithFrame:CGRectMake(0, y+44*3+10, SCREEM_WIDTH, 44)];
    _passwordA.title.text = @"确定密码";
    _passwordA.textField.placeholder = @"请再次输入密码";
    [_headView addSubview:_passwordA];
    
    [_passwordA setBottom];
    
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15, _passwordA.bottom + 94, SCREEM_WIDTH - 30, 44)];
    
    btn.backgroundColor = MAINCOLOR;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 2;
    
    [btn addTarget:self action:@selector(logBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_headView addSubview:btn];
    
    
    CGRect btnf = CGRectMake(SCREEM_WIDTH - 90, 9, 75, 26);
    ICodeButton* codeBtn = [[ICodeButton  alloc]initWithFrame:btnf];
    [codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [codeBtn setTitleColor:RGB(247, 124, 126) forState:UIControlStateNormal];
    codeBtn.titleLabel.font = FONT(11);
    codeBtn.layer.masksToBounds = YES;
    codeBtn.layer.cornerRadius = 2;
    codeBtn.layer.borderWidth = 0.8;
    codeBtn.layer.borderColor = RGB(247, 124, 126).CGColor;
    [_code addSubview:codeBtn];
    
    [codeBtn addTarget:self action:@selector(codeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * hideBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 60, 0, 50, 44)];
    
    [hideBtn setImage:[UIImage imageNamed:@"pwd_hide"] forState:UIControlStateNormal];
    [hideBtn setImage:[UIImage imageNamed:@"pwd_hide"] forState:UIControlStateSelected];
    [_password addSubview:hideBtn];
    
    [hideBtn addTarget:self action:@selector(hideBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    CGFloat x = 15;
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(x, _passwordA.bottom , SCREEM_WIDTH - 2*x, 40)];
    [btn3 setImage:[UIImage imageNamed:@"img_reg"] forState:UIControlStateNormal];
    
    [btn3 setAttributedTitle:[self setTip] forState:UIControlStateNormal];
    btn3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft ;
    [btn3 setImageEdgeInsets:UIEdgeInsetsMake(0, 3, 0, 0)];
    [btn3 setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    [_headView addSubview:btn3];
    
    [btn3 addTarget:self action:@selector(btn3Action) forControlEvents:UIControlEventTouchUpInside];
}


- (void)btn3Action {
    
    NSString *url = [NSString stringWithFormat:@"%@api/public/about?id=2",HOST];
    
    [WKWebViewController pushVC:self title:@"关于我们" URL:url];
}



- (void)codeBtnAction:(ICodeButton*)btn {
    
    NSLog(@"code btn ");
    
    NSString *url = HOSTAPIKEY(@"api/public/checkmember");
    
    NSString * loginname = _phone.textField.text;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setObject:loginname forKey:@"mobile"];
    [parameters setObject:@"register" forKey:@"action"];
    
    [NetWorkManager netWorkPostURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        if([dict[@"res"] integerValue] == 1){
            
            
            [btn timeStart];
        }
        
        [HUDManager alertText:dict[@"msg"]];
    }];
}



- (void)hideBtnAction:(UIButton*)btn {
    
    btn.selected = !btn.selected;
    if(btn.selected == YES){
        
        _password.textField.secureTextEntry = YES;
        _passwordA.textField.secureTextEntry = YES;

    }
    else {
        _password.textField.secureTextEntry = NO;
        _passwordA.textField.secureTextEntry = NO;
        
    }
    
}


- (NSAttributedString *)setTip {
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]init];
    
    
    NSDictionary * attributes1 = @{NSFontAttributeName:FONT11,NSForegroundColorAttributeName:RGB(100, 100, 100)};
    NSDictionary * attributes2 = @{NSFontAttributeName:FONT11,NSForegroundColorAttributeName:RGB(247, 124, 126)};
    
    NSAttributedString *attr1 = [[NSAttributedString alloc]initWithString:@"我已阅读同意" attributes:attributes1];
    NSAttributedString *attr2 = [[NSAttributedString alloc]initWithString:@"《用户协议及隐私权声明》" attributes:attributes2];
    
    [attrStr appendAttributedString:attr1];
    [attrStr appendAttributedString:attr2];
    
    return attrStr;
}


- (void)logBtnAction {
    
    
//    FillCarViewController *nextVC = [[FillCarViewController alloc]init];
//    nextVC.hidesBottomBarWhenPushed = YES;
//    nextVC.regToken = @"";
//    [self.navigationController pushViewController:nextVC animated:YES];
//    
//    return;
    
    
    NSString *url = HOSTAPIKEY(@"api/public/register");
    
    NSString * loginname = _phone.textField.text;
    NSString * loginpwd  = _password.textField.text;
    NSString * code  = _code.textField.text;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    [parameters setObject:loginname forKey:@"loginname"];
    [parameters setObject:loginpwd forKey:@"loginpwd"];
    [parameters setObject:code forKey:@"code"];
    
    [NetWorkManager netWorkPostURL:url parameters:parameters completion:^(NSDictionary *dict) {
        
        
        if([dict[@"res"] integerValue] == 1){
            
//            [UserManager loginWithToken:dict[@"token"]];
            NSString *token = dict[@"token"];
            
            FillCarViewController *nextVC = [[FillCarViewController alloc]init];
            nextVC.hidesBottomBarWhenPushed = YES;
            nextVC.regToken = token;
            [self.navigationController pushViewController:nextVC animated:YES];
        }
        
        [HUDManager alertText:dict[@"msg"]];
    }];

}





@end
