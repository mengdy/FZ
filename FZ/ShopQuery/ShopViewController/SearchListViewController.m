//
//  SearchListViewController.m
//  FZ
//
//  Created by mengdy on 16/10/20.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "SearchListViewController.h"

@interface SearchListViewController ()

@end

@implementation SearchListViewController


- (void)viewWillAppear:(BOOL)animated {

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索列表";
    self.view.backgroundColor = [UIColor whiteColor];
    [self backView];

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
