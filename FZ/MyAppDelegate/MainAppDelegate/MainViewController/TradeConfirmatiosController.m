//
//  TradeConfirmatiosController.m
//  FZ
//
//  Created by mengdy on 16/10/18.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "TradeConfirmatiosController.h"
#import "macro.h"
#import "PaymentDetailsCell.h"
#import "PaymentOptionCell.h"

static NSInteger lastpw = 0;

@interface TradeConfirmatiosController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong)UIView *bgVeiw;
@property (nonatomic,strong)UITableView *payTable;
@property (nonatomic,strong)UIView *paymentView;
@property (strong,nonatomic)UIView *payBGview;
@property (strong,nonatomic)UITableView *paymentTable;
@property (strong,nonatomic)NSString *nameStr;
@property (strong,nonatomic)UIView *passwordVeiw;
@property (strong,nonatomic)UITextField *pwTextFiled;
@property (strong,nonatomic)UIImageView *pwVeiw;
@property (nonatomic,strong)NSMutableArray *numBtnArry;
@property (nonatomic,strong)NSMutableArray *arrays;


@end

@implementation TradeConfirmatiosController

-(void)viewWillAppear:(BOOL)animated {

    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated {

    [self.navigationController setNavigationBarHidden:NO];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    lastIndex = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"交易确认";
    self.nameStr = @"";
    [self backView];
    
    UIButton *payBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 300, 80, 40)];
    [payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [payBtn setBackgroundColor:[UIColor orangeColor]];
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [payBtn addTarget:self action:@selector(handlepayBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:payBtn];


}

- (void)backView {
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWith, 64)];
    UIView *headLine = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, kScreenWith, 0.5)];
    headLine.backgroundColor = klineViewColor;
    [headView addSubview:headLine];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];

    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, 25, 25)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(handleBackView:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:backBtn];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWith - 100)/2.f, 30, 100, 30)];
    titleLabel.text = @"交易确认";
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];
    
}

// 返回按钮事件
- (void)handleBackView : (UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)handlepayBtnEvent:(UIButton *)pay {

    [self submitPaymentToEnterPassword];

}

- (void)submitPaymentToEnterPassword {


    self.bgVeiw = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWith, kScreenHight)];
    _bgVeiw.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    [self.view addSubview:_bgVeiw];
   
     self.payBGview = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHight, kScreenWith, kScreenHight*2.f/3)];
    _payBGview.backgroundColor = [UIColor whiteColor];
    [_bgVeiw addSubview:_payBGview];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, kViewHight(40), kScreenWith, 0.5)];
    lineView.backgroundColor = klineViewColor;
    [_payBGview addSubview:lineView];
    
    UIImage *deleteImage = [UIImage imageNamed:@"delete"];
    
    UIButton *removeBtn = [[UIButton alloc]initWithFrame:CGRectMake(15,(40-25)/2.f, 25, 25)];
    [removeBtn setBackgroundImage:deleteImage forState:UIControlStateNormal];
    [removeBtn addTarget:self action:@selector(removePayBGView) forControlEvents:UIControlEventTouchUpInside];
    [_payBGview addSubview:removeBtn];
    
    UILabel *detail = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, kScreenWith-160, 40)];
    detail.text = @"付款详情";
    detail.font = [UIFont systemFontOfSize:16];
    detail.textAlignment = NSTextAlignmentCenter;
    [_payBGview addSubview:detail];
    
     [UIView animateWithDuration:1 animations:^{
     _payBGview.frame = CGRectMake(0, kScreenHight/3.f, kScreenWith, kScreenHight * 2.f/3) ;
     }];
    
    self.payTable = [[UITableView alloc]initWithFrame:CGRectMake(0, kViewHight(43), kScreenWith, kScreenHight*2/3.f - kViewHight(40))];
    _payTable.delegate = self;
    _payTable.dataSource = self;
    _payTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _payTable.scrollEnabled = NO;
    [_payBGview addSubview:_payTable];
    
}

- (void)removePayBGView {

    [_bgVeiw  removeFromSuperview];
}

#pragma  delegate 
- (NSInteger)numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == _payTable) {
        
        NSString *identifier = @"cell";
        PaymentDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            
            cell = [[PaymentDetailsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        if (indexPath.row == 0) {
            cell.detailsName.text = @"付款详情";
            cell.detailsTitle.text = @"花费充值";
            cell.detailsView.hidden = YES;
        }else if (indexPath.row == 1){
            if (self.nameStr.length > 1) {
              cell.detailsTitle.text = self.nameStr;
                
            }else {
            cell.detailsTitle.text = @"账户余额";
            }
            cell.detailsName.text = @"付款方式";
            cell.detailsView.image = [UIImage imageNamed:@"rightArrow"];
            
        }else if (indexPath.row == 2){
            cell.detailsName.text = @"付款金额";
            cell.detailsTitle.text = @"10元";
            cell.detailsView.hidden = YES;
        }
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        cell.detailsTitle.textAlignment = NSTextAlignmentRight;
        
        return cell;
        
    }else if (tableView == _paymentTable){
    
    
        NSString *identifier = @"cell0";
        PaymentOptionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            
            cell = [[PaymentOptionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        if (indexPath.row == 0) {
            cell.optionName.text = @"账户余额";
        }else if (indexPath.row == 1){
            cell.optionName.text = @"钱包支付";
        }else if (indexPath.row == 2){
            cell.optionName.text = @"银行卡";
        }
        cell.optionTitle.hidden = YES;
        cell.optionView.hidden = YES;
        cell.optionView.image = [UIImage imageNamed:@"tick"];
        cell.optionTitle.textAlignment = NSTextAlignmentRight;
        if (lastIndex == indexPath.row) {
            cell.optionView.hidden = NO;
        }
        
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return kViewHight(60);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == _payTable) {
        if (indexPath.row == 1) {
            
            NSLog(@"选择支付方式");
            [self methodOfPaymentControlView];
        }else {
            
            NSLog(@"无动于衷");
        }
    }else if (tableView == _paymentTable){

        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        PaymentOptionCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        for (int i = 0; i < 3; i ++) {
            
            if (i == indexPath.row) {
                lastIndex = indexPath.row;
                cell.optionView.hidden = NO;
            }else {
        PaymentOptionCell *cell0 = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                
                cell0.optionView.hidden = YES;
            }
        }
        self.nameStr = cell.optionName.text;
        [self removePaymentBGView];
    }
   
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    if (tableView == _payTable) {
        
    UIView *foot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWith, _payTable.frame.size.height - kViewHight(60)*3)];
    foot.backgroundColor = [UIColor clearColor];
 
    UIButton *payButton = [[UIButton alloc]initWithFrame:CGRectMake(kViewWith(10), foot.frame.size.height - kViewHight(80), kScreenWith - kViewWith(20), kViewHight(40))];
    [payButton setBackgroundColor:kTabbarSelectColor];
    [payButton setTitle:@"确定支付 ￥10" forState:UIControlStateNormal];
    [payButton addTarget:self action:@selector(determinePayment:) forControlEvents:UIControlEventTouchUpInside];
    [foot addSubview:payButton];
    return foot;
    }else {
    
        return  nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    if (tableView == _payTable) {
    
    return  _payTable.frame.size.height - kViewHight(60)*3;
    }else{
        return 0.f;
    }
}

#pragma   确定支付
- (void)determinePayment : (UIButton *)payBtn {

    [self inputPayPassword];
}
-(void)inputPayPassword {
    lastpw = 0;
    self.numBtnArry = [NSMutableArray arrayWithCapacity:1];
    self.arrays = [NSMutableArray arrayWithCapacity:1];

    _passwordVeiw = [[UIView alloc]initWithFrame:CGRectMake(kScreenWith, kScreenHight/3.f, kScreenWith, kScreenHight*2.f/3)];
    _passwordVeiw.backgroundColor = [UIColor whiteColor];
    [_bgVeiw addSubview:_passwordVeiw];
    
    
    UIImage *deleteImage = [UIImage imageNamed:@"leftArrow"];
    
    UIButton *removeBtn = [[UIButton alloc]initWithFrame:CGRectMake(15,(40-25)/2.f, 25, 25)];
    [removeBtn setBackgroundImage:deleteImage forState:UIControlStateNormal];
    [removeBtn addTarget:self action:@selector(removePayPasswordBGView) forControlEvents:UIControlEventTouchUpInside];
    [_passwordVeiw addSubview:removeBtn];
    
    UILabel *detail = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, kScreenWith-160, 40)];
    detail.text = @"输入支付密码";
    detail.font = [UIFont systemFontOfSize:16];
    detail.textAlignment = NSTextAlignmentCenter;
    [_passwordVeiw addSubview:detail];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, kViewHight(40), kScreenWith, 0.5)];
    lineView.backgroundColor = klineViewColor;
    [_passwordVeiw addSubview:lineView];
    
    UIImage *pwBgImage = [UIImage imageNamed:@"pwdInputBg"];
//    UIImage *pointImage = [UIImage imageNamed:@"point"];
    
     self.pwVeiw = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWith - pwBgImage.size.width)/2.f, kViewHight(50), pwBgImage.size.width, pwBgImage.size.height)];
    _pwVeiw.image = pwBgImage;
    [_passwordVeiw addSubview:_pwVeiw];
    NSLog(@"应用计数 :%lu",(unsigned long)[[_pwVeiw constraints] count]);
    
    self.pwTextFiled = [UITextField new];
    [_pwTextFiled setBackground:pwBgImage];
    _pwTextFiled.delegate = self;
    _pwTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    [_passwordVeiw addSubview:_pwTextFiled];
    [UIView animateWithDuration:1 animations:^{
        
        _passwordVeiw.frame = CGRectMake(0, kScreenHight/3.f, kScreenWith, kScreenHight*2.f/3);
        _payBGview.frame = CGRectMake(-kScreenWith, kScreenHight/3.f, kScreenWith, kScreenHight*2.f/3);
        [_pwTextFiled becomeFirstResponder];
    }];
    
}


#pragma UITextField delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    NSLog(@"%@,%lu,%lu",textField.text,textField.text.length,(unsigned long)range.location) ;
    UIImage *pointImage = [UIImage imageNamed:@"point"];
    UIImage *im = [UIImage imageNamed:@"pwdInputBg"];
    
    //移除_pwView 上的所有视图
    NSArray *su = [_pwVeiw subviews];
    if ([su count] != 0) {
        [su makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    if ([string isEqualToString:@""]) {
        [_numBtnArry removeLastObject];
    }else {
        [_numBtnArry addObject:string];
    }
     for (int i = 0; i < _numBtnArry.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(20 + _pwVeiw.frame.size.width / 6 * i , im.size.height/2-5 , pointImage.size.width, pointImage.size.height);
        imageView.image = pointImage;
        [_pwVeiw addSubview:imageView];
 }

    if (_numBtnArry.count == 6) {
        [textField resignFirstResponder];
        [_bgVeiw  removeFromSuperview];
        [self.navigationController setNavigationBarHidden:NO];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        NSLog(@"%@",_numBtnArry);
        NSString *textStr = [NSString string];
        for (int i = 0; i < _numBtnArry.count; i ++) {
            NSString *str = [_numBtnArry objectAtIndex:i];
            textStr = [textStr stringByAppendingString:str];
        }
        NSLog(@"输入的字符串 : %@",textStr);
    }
    
    return YES;
}


-(void)removePayPasswordBGView{
    
    [UIView animateWithDuration:1 animations:^{
        
        _passwordVeiw.frame = CGRectMake(kScreenWith, kScreenHight/3.f, kScreenWith, kScreenHight*2/3.f);
        _payBGview.frame = CGRectMake(0, kScreenHight/3.f, kScreenWith, kScreenHight*2.f/3);
    } completion:^(BOOL finished) {
        [_passwordVeiw removeFromSuperview];
    }];
    
    [_payTable reloadData];
    
}

#pragma  选择支付方式事件

-(void)methodOfPaymentControlView {

    _paymentView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWith, kScreenHight/3.f, kScreenWith, kScreenHight*2.f/3)];
    _paymentView.backgroundColor = [UIColor whiteColor];
    [_bgVeiw addSubview:_paymentView];

  [UIView animateWithDuration:1 animations:^{
      
      _paymentView.frame = CGRectMake(0, kScreenHight/3.f, kScreenWith, kScreenHight*2.f/3);
      _payBGview.frame = CGRectMake(-kScreenWith, kScreenHight/3.f, kScreenWith, kScreenHight*2.f/3);
  }];
    
    UIImage *deleteImage = [UIImage imageNamed:@"leftArrow"];
    
    UIButton *removeBtn = [[UIButton alloc]initWithFrame:CGRectMake(15,(40-25)/2.f, 25, 25)];
    [removeBtn setBackgroundImage:deleteImage forState:UIControlStateNormal];
    [removeBtn addTarget:self action:@selector(removePaymentBGView) forControlEvents:UIControlEventTouchUpInside];
    [_paymentView addSubview:removeBtn];
    
    UILabel *detail = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, kScreenWith-160, 40)];
    detail.text = @"选择付款方式";
    detail.font = [UIFont systemFontOfSize:16];
    detail.textAlignment = NSTextAlignmentCenter;
    [_paymentView addSubview:detail];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, kViewHight(40), kScreenWith, 0.5)];
    lineView.backgroundColor = klineViewColor;
    [_paymentView addSubview:lineView];
    
    self.paymentTable = [[UITableView alloc]initWithFrame:CGRectMake(0, kViewHight(43), kScreenWith, kScreenHight*2/3.f - kViewHight(40))];
    _paymentTable.delegate = self;
    _paymentTable.dataSource = self;
    _paymentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_paymentView addSubview:_paymentTable];
    
}
-(void)removePaymentBGView{
    
    [UIView animateWithDuration:1 animations:^{
        
       _paymentView.frame = CGRectMake(kScreenWith, kScreenHight/3.f, kScreenWith, kScreenHight*2/3.f);
         _payBGview.frame = CGRectMake(0, kScreenHight/3.f, kScreenWith, kScreenHight*2.f/3);
    } completion:^(BOOL finished) {
         [_paymentView removeFromSuperview];
    }];
    
    [_payTable reloadData];
    
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
