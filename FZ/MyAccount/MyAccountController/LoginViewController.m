//
//  LoginViewController.m
//  FZ
//
//  Created by mengdy on 16/10/14.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "LoginViewController.h"
#import "macro.h"
#import "MoreApplicationListViewController.h"

#import "LoginCell.h"
#import "PassWordCell.h"

#import "PassGuardCtrl.h"
#import "SXBase.h"

#import "LORequestManger.h"
#import "ForgotPasswordController.h"


@interface LoginViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong)UITableView *tableVeiw;
@property (nonatomic,strong)UIButton *loginBtn;
@property (nonatomic,strong) NSString *enkey;



@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBGViewColor;
    
    _enkey = getEncryptKey();
    
    [self  addNavigationBar];
    
    self.tableVeiw = [[UITableView alloc]initWithFrame:CGRectMake(0, kViewHight(100), kScreenWith, kScreenHight - kViewHight(100)) style:UITableViewStylePlain];
    _tableVeiw.backgroundColor = [UIColor clearColor];
    _tableVeiw.delegate = self;
    _tableVeiw.dataSource = self;
    _tableVeiw.scrollEnabled = NO;
    _tableVeiw.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableVeiw];
    
    
    UIButton *registeredBtn = [[UIButton alloc]initWithFrame:CGRectMake(kViewWith(20), kScreenHight - kViewHight(80), kScreenWith - kViewWith(40), kViewHight(49))];
    [registeredBtn setBackgroundColor:[UIColor clearColor]];
    [registeredBtn setTitle:@"没有账户？请注册" forState:UIControlStateNormal];
    [registeredBtn setTitleColor:kTabbarSelectColor forState:UIControlStateNormal];
    registeredBtn.layer.borderColor = kTabbarSelectColor.CGColor;
    registeredBtn.layer.borderWidth = 1;
    registeredBtn.layer.cornerRadius = 5;
    registeredBtn.layer.masksToBounds = YES;
    [registeredBtn addTarget:self action:@selector(registeredBtnView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:registeredBtn];
        
}

#pragma mark 添加导航栏
-(void)addNavigationBar{
//    //创建一个导航栏
//    UINavigationBar *navigationBar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, kScreenWith, 44+20)];
//    //navigationBar.tintColor=[UIColor whiteColor];
//    navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kTabbarSelectColor};
//   //背景颜色
//    navigationBar.barTintColor = [UIColor whiteColor];
//    [self.view addSubview:navigationBar];
//    //创建导航控件内容
//    UINavigationItem *navigationItem=[[UINavigationItem alloc]initWithTitle:@"登录"];
//    //左侧添加登录按钮
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backBtn"] style:UIBarButtonItemStylePlain target:self action:@selector(undoLoginView:)];
//    [backItem setTitleTextAttributes:@{NSForegroundColorAttributeName:kTabbarSelectColor} forState:UIControlStateNormal];
//    navigationItem.leftBarButtonItem=backItem;
//    //添加内容到导航栏
//    [navigationBar pushNavigationItem:navigationItem animated:NO];
    
    
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWith, kViewHight(64))];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    UILabel *topTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWith -100)/2.f, kViewHight(15), 100, kViewHight(49))];
    topTitleLabel.text = @"登 录";
    topTitleLabel.textAlignment = NSTextAlignmentCenter;
    topTitleLabel.textColor = [UIColor blackColor];
    topTitleLabel.font = [UIFont systemFontOfSize:18];
    [topView addSubview:topTitleLabel];
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, kViewHight(25), 25, kViewHight(25))];
    [backButton setBackgroundImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateNormal];
    
    [backButton addTarget:self action:@selector(undoLoginView:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backButton];

    
}

//
- (void)undoLoginView : (UIButton *)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma  mark  --- delegate  v dataSouce

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kViewHight(60);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *loginStr = @"loginName";
    LoginCell  *cell = [tableView dequeueReusableCellWithIdentifier:loginStr];
    NSString *passWord = @"password";
    PassWordCell *passCell = [tableView dequeueReusableCellWithIdentifier:passWord];
    
    if (!cell) {
        
        cell = [[LoginCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loginStr];
    }
    
    if (!passCell) {
        passCell = [[PassWordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:passWord];
    }
    
    if (indexPath.row == 0) {
        
        cell.loginLabel.text = @"账户";
        cell.loginTextFiled.placeholder = @"请输入正确的手机号";
        cell.loginLabel.textAlignment = NSTextAlignmentCenter;
        [cell.loginTextFiled setValue:kCCLineBGColor forKeyPath:@"_placeholderLabel.textColor"];
        [cell.loginTextFiled setValue:[UIFont systemFontOfSize:18] forKeyPath:@"_placeholderLabel.font"];
        cell.loginTextFiled.delegate = self;
        UIView *lineVeiw = [[UIView alloc]initWithFrame:CGRectMake(kViewWith(10),kViewHight(60) - 1, kScreenWith - kViewWith(20), 1)];
        lineVeiw.backgroundColor = kBGViewColor;
        [cell addSubview:lineVeiw];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
         return cell;
    }else if (indexPath.row == 1) {
    
        passCell.nameLabel.text = @"密码";
        passCell.nameLabel.textAlignment = NSTextAlignmentCenter;
        passCell.passWordTextFiled.textAlignment = NSTextAlignmentLeft;
        passCell.passWordTextFiled.placeholder = @"请输入密码";
        [passCell.passWordTextFiled setValue:kCCLineBGColor forKeyPath:@"_placeholderLabel.textColor"];
        [passCell.passWordTextFiled setValue:[UIFont systemFontOfSize:18] forKeyPath:@"_placeholderLabel.font"];
        passCell.passWordTextFiled.delegate = self;
       [passCell.passWordTextFiled addTarget:self action:@selector(textFiledDidChange:) forControlEvents:UIControlEventEditingChanged];
        passCell.passWordTextFiled.m_mode = NO;
        passCell.selectionStyle = UITableViewCellSelectionStyleNone;

//        id a =  [passCell.passWordTextFiled  initWithMode:true];
//        NSLog(@"%@",[a class]);
        passCell.passWordTextFiled.borderStyle = UITextBorderStyleNone;
        passCell.passWordTextFiled.m_iMaxLen = 20;
        passCell.passWordTextFiled.m_strInput1 = _enkey;
//        passCell.passWordTextFiled.secureTextEntry = YES;
        passCell.passWordTextFiled.userInteractionEnabled = YES;
        [passCell.passWordTextFiled setM_uiapp:[UIApplication sharedApplication]];

        
        return passCell;
    }
    
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    UIView *footVeiw = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWith, kViewHight(200))];
    footVeiw.backgroundColor = [UIColor clearColor];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(kViewWith(20), kViewHight(20), kScreenWith - kViewWith(40), kViewHight(49))];
    [loginBtn setBackgroundColor:kTabbarNormalColor];
    [loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    loginBtn.enabled = NO;
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnView:) forControlEvents:UIControlEventTouchUpInside];
    [footVeiw addSubview:loginBtn];
    _loginBtn = loginBtn;

    UIButton *forgotPassWordBtn = [[UIButton alloc]initWithFrame:CGRectMake(kViewWith(20), kViewHight(79), kScreenWith - kViewWith(40), kViewHight(49))];
    [forgotPassWordBtn setBackgroundColor:[UIColor clearColor]];
    [forgotPassWordBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    forgotPassWordBtn.showsTouchWhenHighlighted = YES;
    [forgotPassWordBtn setTitleColor:kTabbarSelectColor forState:UIControlStateNormal];
    [forgotPassWordBtn addTarget:self action:@selector(forgotPassWordBtnView:) forControlEvents:UIControlEventTouchUpInside];
    [footVeiw addSubview:forgotPassWordBtn];
    
    return footVeiw;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return kViewHight(200);
}


//登录按钮
-(void)loginBtnView : (UIButton *)login {
    
    NSLog(@"登录之后按钮");
    
    LoginCell *cell = [_tableVeiw cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    PassWordCell *passCell = [_tableVeiw cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
     NSLog(@"登录密码  ：  %@",[passCell.passWordTextFiled getOutput1]);
    
     NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:SMCURRENT_VERSION forKey:@"version"];
    [dic setObject:cell.loginTextFiled.text forKey:@"loginName"];
    [dic setObject:[passCell.passWordTextFiled getOutput1] forKey:@"password"];
    [dic setObject:_enkey forKey:@"encryptKey"];

    NSString *strurl  =  [NSString stringWithFormat:@"%@smpayLogin.do?version=%@",URLS,SMCURRENT_VERSION];
    
    [LORequestManger POST:strurl params:dic success:^(id response) {
       
       NSLog(@"2345678");
       
       [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isLogin"];
       
       [self dismissViewControllerAnimated:YES completion:^{
           
      [_tabBar setSelectedIndex:2];
       }];
       
       
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      
       NSLog(@"%@@",error.domain);
   }];


}

//忘记密码
- (void)forgotPassWordBtnView : (UIButton *)forgotPassWord {

    NSLog(@"忘记密码");

    ForgotPasswordController *forgot = [[ForgotPasswordController alloc]init];
    [self  presentViewController:forgot animated:YES completion:^{
        
        NSLog(@"跳转到忘记密码界面");
    }];
}

//注册按钮
- (void)registeredBtnView : (UIButton *)registered {


    NSLog(@"注册按钮");


}


#define mark  ---  textFiled  DELEGATE

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    LoginCell *cell = [_tableVeiw cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//    PassWordCell *passCell = [_tableVeiw cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    if (cell.loginTextFiled == textField) {
        
        if (textField.text.length >= 10 && range.location >= 10 && textField.text.length == range.location) {
            
                _loginBtn.enabled = YES;
                _loginBtn.backgroundColor = kTabbarSelectColor;
        }else {
            _loginBtn.enabled = NO;
            _loginBtn.backgroundColor = kTabbarNormalColor;
        }
     
        if (textField.text.length >= 10 && range.location > 10) {
        
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    return [textField resignFirstResponder];
}

- (void)textFiledDidChange : (UITextField *)aTextFiled {

    LoginCell *cell = [_tableVeiw cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    if (aTextFiled.text.length > 5 && cell.loginTextFiled.text.length == 11) {
        
        [_loginBtn setBackgroundColor:kTabbarSelectColor];
        _loginBtn.enabled = YES;
    }else {
        
        [_loginBtn setBackgroundColor:kTabbarNormalColor];
        _loginBtn.enabled = NO;
    }
}

/** 调出登录页面 */
+ (void)doTaskAfterLoginFromController:(UIViewController *)fromVC afterLoginBlock:(presentBlock)presentBlock {
    LoginViewController *login = [[LoginViewController alloc] init];
    login.presentBlock = presentBlock;
    UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:login];
    [fromVC presentViewController:nv animated:YES completion:nil];
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

@end
