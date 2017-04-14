//
//  MyAccountViewController.m
//  FZ
//
//  Created by mengdy on 16/9/29.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "MyAccountViewController.h"
#import "macro.h"
#import "LORequestManger.h"


@interface MyAccountViewController ()

@end

@implementation MyAccountViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //iOS_7.0之后view被导航栏遮盖
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //设置导航栏的字体颜色
    self.title = @"我的账户";
    [self.navigationController.navigationBar setTitleTextAttributes:
  @{NSFontAttributeName:[UIFont systemFontOfSize:17],
    NSForegroundColorAttributeName:kTabbarSelectColor}];
    /*
    NSDate *date = [NSDate date];
    NSDateFormatter *fa = [[NSDateFormatter alloc]init];
    [fa setDateFormat:@"yyyyMMddHHmmss"];
    NSString *time = [fa stringFromDate:date];
    NSLog(@"当前时间:%@",time);
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:@"1000005367" forKey:@"cstno"];
    [dic setObject:@"PreetyToy" forKey:@"goods_name"];
    [dic setObject:@"http://192.168.13.214:8081/demo/notify_url.jsp" forKey:@"notify_url"];
    [dic setObject:@"1.00" forKey:@"order_amt"];
    [dic setObject:@"1" forKey:@"remark"];
    [dic setObject:@"ios_sdk" forKey:@"terminal_type"];
    [dic setObject:@"100000404" forKey:@"order_no"];
    [dic setObject:@"1.0" forKey:@"version"];
    [dic setObject:@"http://192.168.13.214:8081/demo/return_url.jsp" forKey:@"return_url"];
    [dic setObject:time forKey:@"timestamp"];
    [dic setObject:@"CNY" forKey:@"cur_type"];
    [dic setObject:time forKey:@"order_time"];
    [dic setObject:@"100000404" forKey:@"mer_id"];
    [dic setObject:@"1" forKey:@"address"];
    [dic setObject:@"T0002" forKey:@"trade_code"];
     [dic setObject:@"1" forKey:@"goods_type"];
     [dic setObject:@"sumpay.wap.trade.order.apply" forKey:@"service"];
     [dic setObject:@"100000404" forKey:@"app_id"];
     [dic setObject:@"0" forKey:@"logistics"];
    [dic setObject:@"ae164ce0d1a9b824a9e51b7c95b7929179695184c7e7a4f6c44793954380e200" forKey:@"finger_id"];
    
    NSString *uu = @"http://192.168.8.191:8083/getSigns";
    
    [LORequestManger POST:uu params:dic success:^(id response) {
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    */
    
    UIButton *cancellationBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    [cancellationBtn setTitle:@"注销" forState:UIControlStateNormal];
    [cancellationBtn setTitleColor:kNineWordColor forState:UIControlStateNormal];
    [cancellationBtn addTarget:self action:@selector(cancellationLoginEven:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc]initWithCustomView:cancellationBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
 }

//注销登录按钮事件
-(void)cancellationLoginEven : (UIButton *)cancellBtn {

    NSLog(@"取消按钮");
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否注销账号" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *determine = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"isLogin"];
        [self.tabBarController setSelectedIndex:0];
    }];
    UIAlertAction *cancell = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"取消");
    }];
    [alert addAction:determine];
    [alert addAction:cancell];
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
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
