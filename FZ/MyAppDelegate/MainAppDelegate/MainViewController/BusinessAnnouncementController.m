//
//  BusinessAnnouncementController.m
//  FZ
//
//  Created by mengdy on 16/10/13.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "BusinessAnnouncementController.h"

#import "macro.h"


@interface BusinessAnnouncementController ()

@end

@implementation BusinessAnnouncementController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBGViewColor;
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWith, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    UILabel *topTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWith -100)/2.f, 15, 100, 49)];
    topTitleLabel.text = @"业务公告";
    topTitleLabel.textAlignment = NSTextAlignmentCenter;
    topTitleLabel.textColor = [UIColor blackColor];
    topTitleLabel.font = [UIFont systemFontOfSize:18];
    [topView addSubview:topTitleLabel];
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 5, 25, 25)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateNormal];
    
    [backButton addTarget:self action:@selector(handleBackLastView:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backButton];
    
    
}

#pragma 导航栏返回按钮点击事件
- (void)handleBackLastView : (UIButton *)sender {

    [self dismissViewControllerAnimated:YES completion:nil];

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
