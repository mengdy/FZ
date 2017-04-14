//
//  PhonePayViewController.m
//  FZ
//
//  Created by mengdy on 16/10/17.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "PhonePayViewController.h"
#import "macro.h"
#import <QuartzCore/QuartzCore.h>
#import <AddressBookUI/AddressBookUI.h>
#import "TradeConfirmatiosController.h"

#import "UIImage+Round.h"


@interface PhonePayViewController ()<UITextFieldDelegate,ABPeoplePickerNavigationControllerDelegate>
{
    NSInteger _nSelect;
    NSInteger _lastTag;
    NSInteger _countTag;
    
}

@property (nonatomic,strong)UITextField *phoneTextFiled;
@property (nonatomic,strong)NSMutableArray *buttons;

@property (nonatomic,strong)UILabel *moneyFirstLL;
@property (nonatomic,strong)UILabel *moneySecondLL;
@property (nonatomic,strong)UILabel *realMoneyFirstLL;
@property (nonatomic,strong)UILabel *realMoneySecondLL;
@property (nonatomic,strong)UIButton *completeBtn;
@property (nonatomic,strong)NSMutableArray *acounts;
@property (nonatomic,strong)NSMutableArray *prices;

@end

@implementation PhonePayViewController


-(void)viewWillAppear:(BOOL)animated {

    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     _nSelect = 10;
    _lastTag = 11;
    _countTag = 0;
   self.title = @"手机充值";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self backView];
    
    self.buttons = [NSMutableArray arrayWithCapacity:1];
    self.acounts = [NSMutableArray arrayWithCapacity:1];
    self.prices  = [NSMutableArray arrayWithCapacity:1];
    //输入手机号设置
    [self payPhoneEnterPhoneNumberBox];
    //金额设置按钮
    [self payAmountAboutPhoneOptionButton];
    
    [self payPhoneComplete];
    
    //添加观察着
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickSureButton) name:@"clickSureButton" object:nil];
    
    
    UIImage *image = [UIImage hyb_imageWithCornerRadius:40 imageName:@"placeImage"];
   
    
    UIImageView *imageview = [[UIImageView alloc]initWithImage:image];
    imageview.frame = CGRectMake(50, 300, 200, 100);
    imageview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:imageview];
    
    
    
    
    
}







- (void)backView {
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(handleBackView:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

// 返回按钮事件
- (void)handleBackView : (UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}





//设置号码输入款
- (void)payPhoneEnterPhoneNumberBox {
  
    self.phoneTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(kViewWith(15), kViewHight(20+64), kScreenWith - kViewWith(100), kViewHight(60))];
    _phoneTextFiled.textColor = kNineWordColor;
    _phoneTextFiled.delegate = self;
    _phoneTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTextFiled.returnKeyType = UIReturnKeyDefault;
    _phoneTextFiled.borderStyle = UITextBorderStyleNone;
    _phoneTextFiled.clearButtonMode = UITextFieldViewModeAlways;
    _phoneTextFiled.placeholder = @"输入或选择手机号码";
    [_phoneTextFiled setValue:kCCLineBGColor forKeyPath:@"_placeholderLabel.textColor"];
    [_phoneTextFiled setValue:[UIFont systemFontOfSize:18] forKeyPath:@"_placeholderLabel.font"];
    //首字母大写
//    _phoneTextFiled.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _phoneTextFiled.font = [UIFont boldSystemFontOfSize:24];
    _phoneTextFiled.textAlignment = NSTextAlignmentLeft;
    _phoneTextFiled.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//  [_phoneTextFiled addTarget:self action:@selector(textFiledDidChange:) forControlEvents:UIControlEventEditingChanged];
     UIImage *image = [UIImage imageNamed:@"addressContact"];
    UIButton *addressBookBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWith - kViewWith(image.size.width*2 + 20), (kViewHight(60) - image.size.height)/2.f + kViewHight(64+20), image.size.width, image.size.height)];
    [addressBookBtn setBackgroundImage:image forState:UIControlStateNormal];
    [addressBookBtn addTarget:self action:@selector(accessAddressBookBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineVeiw = [[UIView alloc]initWithFrame:CGRectMake(kViewWith(10), kViewHight(60 + 20 + 64), kScreenWith - kViewWith(20), 1)];
    lineVeiw.backgroundColor = kBGViewColor;
    [self.view addSubview:lineVeiw];
    
    [self.view addSubview:_phoneTextFiled];
    [self.view addSubview:addressBookBtn];

}

//设置输入金额按钮
- (void)payAmountAboutPhoneOptionButton {
    
    CGFloat w = (kScreenWith - kViewWith(75))/2.f;
    NSArray *phoneRechList = [NSArray arrayWithObjects:@"50元",@"100元", nil];
    NSArray *realMoneyList = [NSArray arrayWithObjects:@"售价50.00元",@"售价100.00元", nil];

    for (int i = 0; i < phoneRechList.count; i ++) {
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(kViewWith(25) + (w + kViewWith(25))*i, kViewHight(60+20+64+1+20), w, kViewHight(64))];
        button.layer.borderWidth = 1;
        button.layer.borderColor = kCCLineBGColor.CGColor;
        [button setBackgroundColor:[UIColor whiteColor]];
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        [button addTarget:self action:@selector(phoneRechargeMoney:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self.view addSubview:button];
        
        [_buttons addObject:button];
        
        UILabel *moneyLabel = [[UILabel alloc]init];
        moneyLabel.frame = CGRectMake(0, 0, w, kViewHight(34));
        moneyLabel.textAlignment = NSTextAlignmentCenter;
        moneyLabel.textColor = kSixWordColor;
        moneyLabel.backgroundColor = [UIColor clearColor];
        moneyLabel.font = [UIFont systemFontOfSize:18];
        moneyLabel.text = phoneRechList[i];
        [button addSubview:moneyLabel];
        
        UILabel *realMoneyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kViewHight(34), w, kViewHight(30))];
        realMoneyLabel.text = realMoneyList[i];
        realMoneyLabel.textAlignment = NSTextAlignmentCenter;
        realMoneyLabel.textColor = [UIColor colorWithRed:153.f/255.f green:153.f/255.f blue:153.f/255.f alpha:1];
        realMoneyLabel.font = [UIFont systemFontOfSize:14];
        realMoneyLabel.backgroundColor = [UIColor clearColor];
        [button addSubview:realMoneyLabel];
        [_acounts addObject:moneyLabel];
        [_prices addObject:realMoneyLabel];
        
    }
}

//手机充值金额选择按钮
- (void)phoneRechargeMoney :(UIButton *)button{
    
    _nSelect = button.tag;
    [_phoneTextFiled resignFirstResponder];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"clickSureButton" object:nil];
    
    for (int i = 0; i < self.buttons.count; i ++) {
        UIButton *sender = [self.buttons objectAtIndex:i];
        
        if (button.tag ==  i ) {
            
            if (_lastTag == button.tag && _countTag % 2 == 0) {
                _countTag ++;
                [sender setBackgroundColor:[UIColor whiteColor]];
                sender.layer.borderColor = kCCLineBGColor.CGColor;
                UILabel *accountLabel = [_acounts objectAtIndex:i];
                UILabel *pricesLabel = [_prices objectAtIndex:i];
                [accountLabel setTextColor:kSixWordColor];
                [pricesLabel setTextColor:kSixWordColor];
                _nSelect = 10;
                
                _completeBtn.enabled = NO;
                [_completeBtn setBackgroundColor:kCCLineBGColor];

            }else{
                _countTag = 0;
               [sender setBackgroundColor:kAgreeWordColor];
               sender.layer.borderColor = [UIColor whiteColor].CGColor;
                UILabel *accountLabel = [_acounts objectAtIndex:i];
                UILabel *pricesLabel = [_prices objectAtIndex:i];
                [accountLabel setTextColor:[UIColor whiteColor]];
                [pricesLabel setTextColor:[UIColor whiteColor]];
                if (_phoneTextFiled.text.length == 11) {
                    
                _completeBtn.enabled = YES;
                [_completeBtn setBackgroundColor:kAgreeWordColor];
                }
            }
             _lastTag = button.tag;
        }else {
            [sender setBackgroundColor:[UIColor whiteColor]];
            sender.layer.borderColor = kCCLineBGColor.CGColor;
            
            UILabel *accountLabel = [_acounts objectAtIndex:i];
            UILabel *pricesLabel = [_prices objectAtIndex:i];
            [accountLabel setTextColor:kSixWordColor];
            [pricesLabel setTextColor:kSixWordColor];

        }
    }
}

//设定手机充值确定按钮
- (void)payPhoneComplete {

    UIButton *completeBtn = [[UIButton alloc]initWithFrame:CGRectMake(kViewWith(15), kViewHight(60+20+64+1+20+84), kScreenWith - kViewWith(30), kViewHight(40))];
    [completeBtn setBackgroundColor:kCCLineBGColor];
    [completeBtn setTitle:@"提 交" forState:UIControlStateNormal];
    [completeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    completeBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    completeBtn.enabled = NO;
    [completeBtn addTarget:self action:@selector(phoneOrdersComplete:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:completeBtn];
    _completeBtn = completeBtn;

}

// 手机充值完成按钮
- (void)phoneOrdersComplete : (UIButton *)sender {
    NSLog(@"手机充值完成按钮");
 [_phoneTextFiled resignFirstResponder];

    if(BSTR_EMPTY(_phoneTextFiled.text)){
       
  [self sxAlertTitle:@"提示" Message:@"手机号不得为空" sureActionTitle:@"确定" cancleActionTitle:nil viewController:self];
        return;
    }
    
  if (11 != _phoneTextFiled.text.length) {
        [self sxAlertTitle:@"提示" Message:@"请输入11位手机号码" sureActionTitle:@"确定" cancleActionTitle:nil viewController:self];
        return;
    }
    
    if (![self isValidateMobile:_phoneTextFiled.text]) {
        [self sxAlertTitle:@"提示" Message:@"请输入正确手机号码" sureActionTitle:@"确定" cancleActionTitle:nil viewController:self];
        return;
    }
    
    TradeConfirmatiosController *TC = [[TradeConfirmatiosController alloc]init];
    
    [self.navigationController pushViewController:TC animated:YES];
 
}

//判断手机号码
-(BOOL) isValidateMobile:(NSString *)mobile1
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(17[0-9])|(14[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile1];
}

//提示语
-(void )sxAlertTitle:(NSString *)title Message:(NSString *)message sureActionTitle:(NSString *)sureTitle cancleActionTitle:(NSString *)cancleTitle viewController:(UIViewController *)controller{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"确定按钮");
        
    }];
    
    [alertController addAction:sureAction];
    [controller presentViewController:alertController animated:YES completion:^{
        NSLog(@"推出提示框的时候调用!");
        
    }];
    
}

//访问手机通讯录按钮
- (void)accessAddressBookBtn : (UIButton *)sender {

    ABPeoplePickerNavigationController * vc = [[ABPeoplePickerNavigationController alloc] init];
    
    vc.peoplePickerDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];

}

#pragma mark ABPeoplePickerNavigationController Delegate

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    
    
    ABMultiValueRef valuesRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    CFIndex index = ABMultiValueGetIndexForIdentifier(valuesRef,identifier);
    //电话号码
    CFStringRef telValue = ABMultiValueCopyValueAtIndex(valuesRef,index);
    
    NSString *phoneNum = (__bridge NSString *)(telValue);
    phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    NSLog(@"%@",phoneNum);
    [self dismissViewControllerAnimated:YES completion:^{
        _phoneTextFiled.text = phoneNum;
    }];
    
}

#pragma mark -- UITextFiled DELEGATE 
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField.text.length >= 10 && range.location>=10 && _nSelect == 0 & textField.text.length == range.location) {
        _completeBtn.enabled = YES;
        [_completeBtn setBackgroundColor:kAgreeWordColor];
    }else if (textField.text.length >= 10 && range.location>=10 && _nSelect == 1 & textField.text.length == range.location){
    
        _completeBtn.enabled = YES;
        [_completeBtn setBackgroundColor:kAgreeWordColor];
    }else {
    
        _completeBtn.enabled = NO;
        [_completeBtn setBackgroundColor:kCCLineBGColor];
    }
    
    if(![textField hasText] && [string isEqualToString:@""])
    {
        return NO;
    }
    if(string.length==0) //清除
    {
        return YES;
    }
    if (textField.text.length >= INPUT_MAX)
    {
        return NO;
    }
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ( textField.text.length >INPUT_MAX) {
        textField.text = [textField.text substringToIndex: INPUT_MAX];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"clickSureButton" object:nil];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    //返回一个BOOL值指明是否允许根据用户请求清除内容
    //可以设置在特定条件下才允许清除内容
    
    _completeBtn.enabled = NO;
    [_completeBtn setBackgroundColor:kCCLineBGColor];

    
    return YES;
}


//#pragma  mark 限制UITextFiled 输入款输入文字的时候文字的长度
//- (void)textFiledDidChange:(UITextField *)textField
//{
////    NSLog(@"%@", textField.text);
//    int length = [self convertToInt:textField.text];
////    NSLog(@"%d", length);
//    //如果输入框中的文字大于8，就截取前8个作为输入框的文字
//    if (length > 11) {
//        textField.text = [textField.text substringToIndex:11];
//    }
//}
//- (int)convertToInt:(NSString *)strtemp//判断中英混合的的字符串长度 一个汉字等于两个字符的长度
//{
//    int strlength = 0;
//    for (int i=0; i< [strtemp length]; i++) {
//        int a = [strtemp characterAtIndex:i];
//        if( a > 0x4e00 && a < 0x9fff) { //判断是否为中文
//            strlength += 2;
//        }
//    }
//    return strlength;
//}





//观察者的相应方法f
- (void)clickSureButton {
    
    if ((_nSelect == 0 && _phoneTextFiled.text.length == 11) || (_nSelect == 1 && _phoneTextFiled.text.length == 11)) {
        _completeBtn.enabled = YES;
        [_completeBtn setBackgroundColor:kAgreeWordColor];
    }else {
        
        _completeBtn.enabled = NO;
        [_completeBtn setBackgroundColor:kCCLineBGColor];
        
    }
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
