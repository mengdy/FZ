//
//  SearchViewController.m
//  FZ
//
//  Created by mengdy on 16/10/20.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "SearchViewController.h"
#import "searchHeaderView.h"
#import "macro.h"
#import "SearchListViewController.h"

@interface SearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)searchHeaderView *headerView;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *records;

@end

@implementation SearchViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   [self.navigationController setNavigationBarHidden:YES animated:animated];
    if (_tableView) {
        self.tableView.delegate = self;
        [_tableView reloadData];
    }
    _headerView.hidden = NO;
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    //因为navigation公用的  所以为了使其不收影响 需要进行下面操作
//    [self.navigationController setValue:[UINavigationBar new]  forKey:@"navigationBar"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addHeaderView];
    self.records = [NSMutableArray arrayWithCapacity:1];
    
    NSString *filePath = [[self documentsPath] stringByAppendingPathComponent:@"/record.txt"];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    [self.records addObject:@"历史搜索"];
    [self.records addObjectsFromArray:array];
    
    //添加tableView 搜索历史记录
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWith, kScreenHight - 64) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}
- (void)addHeaderView {
    
    self.headerView = [[searchHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWith, 64)];
    [self.headerView.backButton addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    self.headerView.searchBar.delegate = self;
    self.headerView.backgroundColor = kBGViewColor;
    [self.view addSubview:self.headerView];
    [self.view bringSubviewToFront:self.headerView];
    
}

-(void)back{

    [self.navigationController popViewControllerAnimated:YES];
    [_headerView.searchBar resignFirstResponder];
}
//沙盒document地址
- (NSString *)documentsPath {
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    return docPath;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.headerView.searchBar endEditing:YES];
    
}
//调用键盘搜索功能
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    NSString *filePath = [[self documentsPath] stringByAppendingPathComponent:@"/record.txt"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:filePath];
        
        int exist = 0;
        for (NSString *items in array) {
            if ([items isEqualToString:searchBar.text]) {
                ++exist;
            }
        }
         if (exist == 0) {
            [array insertObject:searchBar.text atIndex:0];
          }
        [array writeToFile:filePath atomically:YES];
    }else {
        NSMutableArray *array = [NSMutableArray arrayWithObjects:searchBar.text, nil];
        [array writeToFile:filePath atomically:YES];
    }
    NSLog(@"   %@",filePath);
    
    [self.headerView.searchBar resignFirstResponder];
    _headerView.hidden = YES;
    SearchListViewController *searchList = [[SearchListViewController alloc]init];
    searchList.searchStr = searchBar.text;
    [self.navigationController pushViewController:searchList animated:YES];
}


#pragma  mark --  delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _records.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.textLabel.textColor = [UIColor grayColor];
        cell.backgroundColor = klineViewColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    cell.textLabel.text = _records[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.headerView.searchBar resignFirstResponder];
    
    if (indexPath.row == 0) {
        NSLog(@"搜索个毛毛");
    }else {
    
        SearchListViewController *searchList = [[SearchListViewController alloc]init];
        searchList.searchStr = _records[indexPath.row];
        [self.navigationController pushViewController:searchList animated:YES];
        
        _headerView.hidden = YES;
    }
}

//拖动屏幕 回收键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.headerView.searchBar resignFirstResponder];
}

#pragma mark --- 表尾 ---
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWith, 40)];
    UIButton *deleButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    deleButton.frame = CGRectMake((kScreenWith - 100) / 2, 5, 100, 30);
    [deleButton setTitle:@"清除搜索历史" forState:(UIControlStateNormal)];
    [deleButton setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    deleButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    
    [deleButton addTarget:self action:@selector(deleRecord) forControlEvents:(UIControlEventTouchUpInside)];
    
    deleButton.layer.borderColor = [UIColor redColor].CGColor;
    deleButton.layer.cornerRadius = 5;
    deleButton.layer.borderWidth = 1;
    [view addSubview:deleButton];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 0.f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    return nil;
}


- (void)deleRecord {
    _records = nil;
    _records = [NSMutableArray arrayWithObjects:@"历史搜索", nil];
    NSString *filePath = [[self documentsPath] stringByAppendingPathComponent:@"/record.txt"];
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    [self.tableView reloadData];
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
