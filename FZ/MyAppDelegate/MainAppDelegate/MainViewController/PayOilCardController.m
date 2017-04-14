//
//  PayOilCardController.m
//  FZ
//
//  Created by mengdy on 16/10/25.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "PayOilCardController.h"
#import "macro.h"

@interface PayOilCardController ()

@end

@implementation PayOilCardController

-(void)viewWillAppear:(BOOL)animated {

    self.tabBarController.tabBar.hidden = YES;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"加油卡充值";
    self.view.backgroundColor= [UIColor whiteColor];
    
    
    
    
    
    UIActivityIndicatorView *indicator = nil;
    indicator = (UIActivityIndicatorView *)[self.view viewWithTag:103];
    
    if (indicator == nil) {
        
        //初始化:
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        
        indicator.tag = 103;
        
        //设置显示样式,见UIActivityIndicatorViewStyle的定义
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        
        //设置背景色
        indicator.backgroundColor = [UIColor blackColor];
        
        //设置背景透明
        indicator.alpha = 0.5;
        
        //设置背景为圆角矩形
        indicator.layer.cornerRadius = 6;
        indicator.layer.masksToBounds = YES;
        //设置显示位置
        [indicator setCenter:CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0)];
        
        //开始显示Loading动画
        [indicator startAnimating];
        
        [self.view addSubview:indicator];
        
        }
    
    //开始显示Loading动画
    [indicator startAnimating];
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 60, 30)];
    [btn setTitle:@"菊花" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor orangeColor]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickIndicator) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

-(void)clickIndicator{

    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)[self.view viewWithTag:103];
    //停止显示Loading动画
    [indicator stopAnimating];

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
