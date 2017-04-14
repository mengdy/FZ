//
//  UserViewController.m
//  FZ
//
//  Created by mengdy on 16/12/2.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "UserViewController.h"
#import "macro.h"

#import "PopuListView.h"


@interface UserViewController ()
@property (nonatomic,strong)NSMutableArray *listButtons;
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)NSIndexPath *leftPath;
@property (nonatomic,strong)NSIndexPath *centerPath;
@property (nonatomic,strong)NSIndexPath *rightPath;

@property (nonatomic,strong)PopuListView *timeListView;
@property (nonatomic,strong)PopuListView *stateListView;
@property (nonatomic,strong)PopuListView *peopleListView;
@end

@implementation UserViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.leftPath = nil;
    self.centerPath = nil;
    self.rightPath = nil;
    self.listButtons = [NSMutableArray arrayWithCapacity:3];
    if ([[[UIDevice  currentDevice] systemVersion] doubleValue]>=7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 49)];
    view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.1];
    [self.view addSubview:view];
    
    NSArray *listTitles = [NSArray arrayWithObjects:@"全部时间",@"状态",@"成员", nil];
    
    for (int i = 0; i < 3; i ++) {
        
        UIButton *listBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWith/3.f * i, 1, kScreenWith/3.f, 49)];
        [listBtn setBackgroundColor:[UIColor clearColor]];
        [listBtn setImage:[UIImage imageNamed:@"triangleDown"] forState:UIControlStateNormal];
        [listBtn setImage:[UIImage imageNamed:@"triangleDown"] forState:UIControlStateHighlighted];
        listBtn.tag = 10+i;
        [listBtn setTitle:listTitles[i] forState:UIControlStateNormal];
        listBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        
        CGFloat imageWith = listBtn.imageView.frame.size.width;
        CGFloat titleWith = listBtn.titleLabel.frame.size.width;
        
        listBtn.imageEdgeInsets = UIEdgeInsetsMake(0, titleWith, 0,-titleWith);
        listBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWith, 0, imageWith);
        
        [listBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [listBtn addTarget:self action:@selector(clickListViewUp:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:listBtn];
        
        UIView *baffleView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWith/3.f *(i+ 1)-0.5, 5, 0.5, 39)];
        baffleView.backgroundColor = [UIColor grayColor];
        [view addSubview:baffleView];
        [_listButtons addObject:listBtn];
    }
    
}


-(void)clickListViewUp : (UIButton *)sender {

    for (int i = 0; i < 3; i ++) {
        
        UIButton *button = [self.listButtons objectAtIndex:i];
        if (i + 10 == sender.tag) {
            
            [sender setImage:[UIImage imageNamed:@"triangleUp"] forState:UIControlStateNormal];
            [sender setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        }else {
            [button setImage:[UIImage imageNamed:@"triangleDown"] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    NSArray *lists = [self makeArrays:sender.tag];

    switch (sender.tag) {
        case 10:{
            self.stateListView.hidden = YES;
            self.peopleListView.hidden = YES;
            if (_timeListView) {
                _timeListView.hidden = NO;
                _timeListView.lists = lists;
            }else {

                PopuListView *centerPopuView = [self makePopulistView:_leftPath style:PopuStyle_left sender:sender];
                centerPopuView.lists = lists;
                self.timeListView = centerPopuView;
            }
            break;
        }
        case 11:{
            self.timeListView.hidden = YES;
            self.peopleListView.hidden = YES;
            if (_stateListView) {
                _stateListView.hidden = NO;
                _stateListView.lists = lists;
            }else {
                
                PopuListView *centerPopuView = [self makePopulistView:_centerPath style:PopuStyle_centre sender:sender];
                centerPopuView.lists = lists;
                self.stateListView = centerPopuView;

            }
            break;
        }
        case 12:{
            self.timeListView.hidden = YES;
            self.stateListView.hidden = YES;
            if (_peopleListView) {
                _peopleListView.hidden = NO;
                _peopleListView.lists = lists;
            }else {
                PopuListView *centerPopuView = [self makePopulistView:_rightPath style:PopuStyle_Right sender:sender];
                centerPopuView.lists = lists;
                self.peopleListView = centerPopuView;
            }
            break;
        }
        default:
            break;
    }
}


-(PopuListView *)makePopulistView:(NSIndexPath *)path style:(USPOPUSTYLE)styley sender:(UIButton *)sender{

    PopuListView *centerPopuView = [[PopuListView alloc]initWithListViewFrame:CGRectMake(0, 49, kScreenWith, kScreenHight) stely:styley];
    centerPopuView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:centerPopuView];
    [centerPopuView myListBlock:^(NSIndexPath *indexPath, USPOPUSTYLE listStyle) {
        ListCell *rightCellNew = [centerPopuView.listTable cellForRowAtIndexPath:indexPath];
        NSLog(@"sender : %ld",(long)sender.tag);
        NSIndexPath *path = [self makeResultKey:sender.tag];
        
        if (path) {
            ListCell *rightCellOld = [centerPopuView.listTable cellForRowAtIndexPath:path];
            if (path == indexPath) {
                
                rightCellNew.listImage.hidden = NO;
                rightCellNew.listLbTitle.textColor = [UIColor orangeColor];
            }else{
                
                rightCellNew.listImage.hidden = NO;
                rightCellNew.listLbTitle.textColor = [UIColor orangeColor];
                rightCellOld.listImage.hidden = YES;
                rightCellOld.listLbTitle.textColor = [UIColor blackColor];
            }
            
        }else {
            
            rightCellNew.listImage.hidden = NO;
            rightCellNew.listLbTitle.textColor = [UIColor orangeColor];
        }
        
        [self storageSomething:indexPath index:sender.tag];
        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sender setTitle:rightCellNew.listLbTitle.text forState:UIControlStateNormal];
        [sender setImage:[UIImage imageNamed:@"triangleDown"] forState:UIControlStateNormal];
        centerPopuView.hidden = YES;
    }];
    
    return centerPopuView;
}

-(NSIndexPath *)makeResultKey:(NSInteger)index{

    switch (index) {
        case 10:
            return _leftPath;
            break;
        case 11:
           return  _centerPath ;
            break;
        case 12:
            return _rightPath;
            break;
        default:
            break;
    }
    return nil;
}

-(void)storageSomething:(NSIndexPath *)path  index:(NSInteger)index {

    switch (index) {
        case 10:{
            _leftPath = path;
            break;
        }
        case 11:{
            _centerPath = path;
            break;
        }
        case 12:{
            _rightPath = path;
            break;
        }
        default:
            break;
    }
}


//获取数组
- (NSArray *)makeArrays:(NSUInteger)index{

    switch (index) {
        case 10:{
            
            return [NSMutableArray arrayWithObjects:@"2016年1月",@"2016年2月",@"2016年3月",@"2016年4月",@"2016年5月",@"2016年6月",@"2016年7月",@"2016年8月",@"2016年9月",@"2016年10月",@"2016年11月",@"2016年12月", nil];
            break;
        }
        case 11:{
            
            return [NSMutableArray arrayWithObjects:@"在线",@"隐身",@"忙碌", nil];
            break;
        }
        case 12:{
            
            return [NSMutableArray arrayWithObjects:@"小凡",@"于禁",@"女帝",@"祁王",@"先生", nil];
            break;
        }
        default:
            break;
    }
    return [NSArray array];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
