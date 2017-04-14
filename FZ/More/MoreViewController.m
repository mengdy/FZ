//
//  MoreViewController.m
//  FZ
//
//  Created by mengdy on 16/9/29.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "MoreViewController.h"
#import "macro.h"
#import "MoreSetTableViewCell.h"
#import "ScanQRCode.h"

@interface MoreViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MoreViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //iOS_7.0之后view被导航栏遮盖
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:kTabbarSelectColor}];
    self.titles = [NSArray arrayWithObjects:@"扫一扫",@"关于我们",@"图片设置",@"意见反馈",@"购卡网点",@"客户端分享", nil];
    
    self.itemIcons = [NSArray arrayWithObjects:@"scanningIcon",@"auoutIcon",@"pictrueIcon",@"feedbackIcon",@"buycard",@"sharedIcon", nil];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWith, kScreenHight -  49)];
    _tableView.backgroundColor = kBGViewColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = 0;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    
    
}

#define mark ---  delegate  dateSouce;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static  NSString *identifier = @"more";
    MoreSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        
        cell = [[MoreSetTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.titleLabel.text = _titles[indexPath.row];
    cell.titleLabel.font = [UIFont systemFontOfSize:14];
    cell.titleLabel.textColor = kSixWordColor;
    cell.arrowImage.image = [UIImage imageNamed:@"right_Arrow"];
    cell.iconImage.image = [UIImage imageNamed:_itemIcons[indexPath.row]];
    if (_itemIcons.count == indexPath.row + 1) {
        
        cell.separatorView.hidden = YES;
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWith, 50)];
    view.backgroundColor = kBGViewColor;
    cell.selectedBackgroundView = view;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    //添加此方法即可完成 松开cell之后cell回复原来的颜色
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"第%ld行,",(long)indexPath.row);
    
    if (indexPath.row == 0) {
        ScanQRCode *scan = [[ScanQRCode alloc]init];
        scan.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:scan animated:YES];
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
