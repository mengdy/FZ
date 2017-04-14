//
//  PayWaterRateViewController.m
//  FZ
//
//  Created by mengdy on 16/10/25.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "PayWaterRateViewController.h"

#import "macro.h"
#import "WaterViewCell.h"


@interface PayWaterRateViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong)UITableView *waterTable;
@property (nonatomic,strong)NSArray *titles;
@property (nonatomic,strong)NSArray *places;
@property (nonatomic,strong)UIPickerView *picker;
@property (nonatomic,strong)UIView *pickerView;
@property (nonatomic,strong)NSArray *pickers;
@property (nonatomic,strong)UIButton *nextStepBtn;

@end

@implementation PayWaterRateViewController

- (void)viewWillAppear:(BOOL)animated {

    self.tabBarController.tabBar.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"水费缴费";
    self.view.backgroundColor = [UIColor whiteColor];
    
     self.titles = [NSArray arrayWithObjects:@"缴费城市",@"缴费单位",@"缴费号码",@"缴费金额", nil];
     self.places = [NSArray arrayWithObjects:@"",@"",@"请输入缴费号码",@"请输入缴费金额", nil];
    self.pickers = [NSArray arrayWithObjects:@"11",@"222",@"333",@"44",@"55", nil];
    self.waterTable = [[UITableView alloc]initWithFrame:CGRectMake(0, kViewHight(10), kScreenWith, kScreenHight)];
    _waterTable.delegate = self;
    _waterTable.dataSource = self;
    _waterTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_waterTable];
     
}



#pragma  mark UITabeleVeiw  DELEGATE  DATASCOUCE

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _titles.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

     NSString *ide = @"water";
     WaterViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:ide];
    if (!cell) {
        
        cell = [[WaterViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ide];
    }
    cell.waterTitle.text = [_titles objectAtIndex:indexPath.row];
    cell.waterText.placeholder = [_places objectAtIndex:indexPath.row];
   cell.waterText.textAlignment = NSTextAlignmentLeft;
    if (indexPath.row == 0 || indexPath.row == 1) {
         cell.waterText.textAlignment = NSTextAlignmentRight;
        cell.waterText.enabled = NO;
        cell.waterBtn.hidden = NO;
    }
    cell.waterText.delegate = self;
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 3) {
        cell.waterText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }
    
    if (indexPath.row == 0) {
      
     [cell.waterBtn addTarget:self action:@selector(clickArrawCityEvents:) forControlEvents:UIControlEventTouchUpInside];
    }else if (indexPath.row == 1){
    
    [cell.waterBtn addTarget:self action:@selector(clickArrawUnitEvents:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    return cell;
}

-(void)clickArrawCityEvents : (UIButton *)sender {

    self.pickerView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHight, kScreenWith, kViewHight(220))];
    self.pickerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_pickerView];
    
    UIView *btnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWith, kViewHight(40))];
    btnView.backgroundColor = klineViewColor;
    [_pickerView addSubview:btnView];
    
    UIButton *cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(kViewWith(10), 0, kViewWith(100), kViewHight(40))];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:kAgreeWordColor forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(canclePicker:) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:cancleBtn];
    
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWith - kViewWith(100), 0, kViewWith(100), kViewHight(40))];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:kAgreeWordColor forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnPicker:) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:sureBtn];
    
    
    self.picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0,kViewHight(40)+1 , kScreenWith, kViewHight(220)- kViewHight(40) - 1)];
    _picker.backgroundColor = klineViewColor;
    _picker.delegate = self;
    _picker.dataSource = self;
    [_pickerView addSubview:_picker];
    
    [UIView animateWithDuration:1 animations:^{
        _pickerView.frame = CGRectMake(0, kScreenHight - kViewHight(220), kScreenWith, kViewHight(200));
    }];
    
}

- (void)clickArrawUnitEvents : (UIButton *)sender {
    
    NSLog(@"单位选择");
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return kViewHight(60);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    UIView *footVeiw = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWith, kViewHight(200))];
    footVeiw.backgroundColor = [UIColor clearColor];
    
    UILabel *arrageLabel = [[UILabel alloc]initWithFrame:CGRectMake(kViewWith(15), kViewHight(10), kScreenWith - kViewWith(30), kViewHight(40))];
    arrageLabel.textAlignment = NSTextAlignmentLeft;
    arrageLabel.text = @"同意《统统付充值缴费协议》";
    arrageLabel.textColor = [UIColor blackColor];
    arrageLabel.font = [UIFont systemFontOfSize:14];
    arrageLabel.userInteractionEnabled = YES;
    NSMutableAttributedString*attribute = [[NSMutableAttributedString alloc] initWithString: arrageLabel.text];
    [attribute addAttributes: @{NSFontAttributeName : [UIFont systemFontOfSize:14],NSForegroundColorAttributeName:kAgreeWordColor}range: NSMakeRange(2, arrageLabel.text.length - 2)];
    arrageLabel.attributedText = attribute;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAgreeDeal)];
    [arrageLabel addGestureRecognizer:tap];
    [footVeiw  addSubview:arrageLabel];
   
    UIButton *nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(kViewWith(15), kViewHight(60), kScreenWith - kViewWith(30), kViewHight(40))];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setBackgroundColor:klineViewColor];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextBtn.enabled = NO;
    _nextStepBtn = nextBtn;
    [nextBtn addTarget:self action:@selector(payWaterNextStep:) forControlEvents:UIControlEventTouchUpInside];
    [footVeiw addSubview:nextBtn];

    return footVeiw;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return kViewHight(200);
}

//同意支付协议点击
- (void)clickAgreeDeal{

    NSLog(@"同意《统统付充值缴费协议》");
}

#pragma  下一步操作
- (void)payWaterNextStep : (UIButton *)sender {

    NSLog(@"水费缴费下一步操作");
}

#define UITextFiled  DELEGATE
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    WaterViewCell *cell0 = [_waterTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    WaterViewCell *cell1 = [_waterTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    WaterViewCell *cell2 = [_waterTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    WaterViewCell *cell3 = [_waterTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    NSLog(@"收银台:%@,%@,%@,%@",cell0.waterText.text,cell1.waterText.text,cell2.waterText.text,cell3.waterText.text);
    if (cell0.waterText.text.length>1&&cell1.waterText.text.length>1&&cell2.waterText.text.length>1 && cell3.waterText.text.length > 1 ) {
            
        _nextStepBtn.enabled = YES;
        _nextStepBtn.backgroundColor = kAgreeWordColor;
    }else {
    
        _nextStepBtn.enabled = NO;
        _nextStepBtn.backgroundColor = klineViewColor;
    }
    
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    return [textField resignFirstResponder];
}

#pragma mark UIPickerView DataSource Method 数据源方法

//指定pickerview有几个表盘
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;//第一个展示字母、第二个展示数字
}

//指定每个表盘上有几行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
  
    return _pickers.count;
}

#pragma mark UIPickerView Delegate Method 代理方法

//指定每行如何展示数据（此处和tableview类似）
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString * title = nil;
  
    title = _pickers[row];
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    NSLog(@"%@",_pickers[row]);
    WaterViewCell *cell = [_waterTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0 ]];
    WaterViewCell *cell1 = [_waterTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0 ]];
    cell.waterText.text = _pickers[row];
    cell1.waterText.text = _pickers[row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {

    return kViewHight(50);
}

//canclePicker
- (void)canclePicker : (UIButton *)sender {

    NSLog(@"quxiao ");
    WaterViewCell *cell = [_waterTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0 ]];
    cell.waterText.text =@"";
    [_pickerView removeFromSuperview];
    
}

- (void)sureBtnPicker : (UIButton *)sender {

    NSLog(@"确定");
    
    [_pickerView removeFromSuperview];
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
