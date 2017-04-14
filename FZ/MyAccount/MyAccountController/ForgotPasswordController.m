//
//  ForgotPasswordController.m
//  FZ
//
//  Created by mengdy on 16/10/18.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "ForgotPasswordController.h"
#import "macro.h"




@interface ForgotPasswordController ()

@end

@implementation ForgotPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addNavigationBar];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}


#pragma mark 添加导航栏
-(void)addNavigationBar{
    //创建一个导航栏
    UINavigationBar *navigationBar=[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, kScreenWith, 44+20)];
//    navigationBar.tintColor=[UIColor whiteColor];
    navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kTabbarSelectColor};
   //背景颜色
    navigationBar.barTintColor = [UIColor whiteColor];
    [self.view addSubview:navigationBar];
    //创建导航控件内容
    UINavigationItem *navigationItem=[[UINavigationItem alloc]initWithTitle:@"忘记密码"];
    //左侧添加登录按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backBtn"] style:UIBarButtonItemStylePlain target:self action:@selector(undoLoginView:)];
    
    navigationItem.leftBarButtonItem=backItem;
    //添加内容到导航栏
    [navigationBar pushNavigationItem:navigationItem animated:NO];
}

//
- (void)undoLoginView : (UIButton *)sender {
    
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
