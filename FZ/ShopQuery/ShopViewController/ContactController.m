//
//  ContactController.m
//  FZ
//
//  Created by mengdy on 16/12/6.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "ContactController.h"
#import "MoreSelectModel.h"
#import "MoreSelectHeaderView.h"

static NSString *const kHeaderFooterViewReuseIdentifier = @"a2b2c2";


@interface ContactController ()<MoreSelectHeaderViewDelegate>

@property (nonatomic,strong)NSMutableArray *sections;
@property (nonatomic,strong)NSMutableDictionary *dataDic;
@property (nonatomic,strong)NSMutableArray *dataSelects;
@property (nonatomic,strong)NSMutableDictionary *openDict; //用于设置当前分组展开或关闭

@end

@implementation ContactController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSelects = [NSMutableArray array];
    
    [self readDataFromPlistFile];
    [self chChangePin:@"孟凡"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(handleFindshed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

-(void)handleFindshed : (UIButton *)sender {

    if (_selectBolock) {
        self.selectBolock(self.dataSelects);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)mySelectBlock:(SelectBlock)block{

    self.selectBolock = block;
    
}

//从plist文件当中读取数据
- (void)readDataFromPlistFile{

     NSString *fliePath = [[NSBundle mainBundle]pathForResource:@"Contact" ofType:@"plist"];
    self.dataDic = [NSMutableDictionary dictionaryWithContentsOfFile:fliePath];
    NSArray *allKey = [[self.dataDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    self.sections = [NSMutableArray arrayWithArray:allKey];
    
    for (NSString *key  in self.sections) {
        
        NSArray *array = [self.dataDic objectForKey:key] ;
        
        NSMutableArray *titles = [NSMutableArray array];
        NSMutableArray *newArray = [NSMutableArray array];
        
        for (NSDictionary *dic in array) {
          
            MoreSelectModel *model = [[MoreSelectModel alloc]initWithMoreSelectDictionary:dic];
            [newArray addObject:model];
            
            [titles addObject:[dic objectForKey:@"name"]];
        }
        [self.dataDic setObject:newArray forKey:key];
    }

}

//汉字转为拼音
-(NSString *)chChangePin:(NSString *)str1
{
    //  把汉字转换成拼音第一种方法
    NSString *str = [[NSString alloc]initWithFormat:@"%@", str1];
    // NSString 转换成 CFStringRef 型
    CFStringRef string1 = (CFStringRef)CFBridgingRetain(str);
    NSLog(@"%@", str);
    //  汉字转换成拼音
    CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, string1);
    //  拼音（带声调的）
    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
    NSLog(@"%@", string);
    //  去掉声调符号
    CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
    NSLog(@"%@", string);
    //  CFStringRef 转换成 NSString
    NSString *strings = (NSString *)CFBridgingRelease(string);
    //  去掉空格
    NSString *cityString = [strings stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"汉子转化为拼音 :%@", cityString);
    return cityString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    return [[self.dataDic objectForKey:[self.sections objectAtIndex:section]] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"moreSelectCell";
    
    MoreSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[MoreSelectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSString *key = [self.sections objectAtIndex:indexPath.section];
    NSArray *array = [self.dataDic objectForKey:key];
    MoreSelectModel *model = [array objectAtIndex:indexPath.row];
    cell.markImageView.image = [UIImage imageNamed:@"contact_normal"];
    cell.markTitle.text = [model.name substringToIndex:1];
    cell.contactTitle.text = model.name;
    cell.addressTitle.text = model.tel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // 超出父视图不显示，如果不将其值设为YES（默认为NO），那么现实在表格视图上的数据会出现重叠的bug
    cell.layer.masksToBounds = YES;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *key = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
    
    if ([_openDict objectForKey:key]) {
        return 60.f;
    }else{
        return 0.f;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 40.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    MoreSelectHeaderView *headView = [[MoreSelectHeaderView alloc]initWithReuseIdentifier:kHeaderFooterViewReuseIdentifier];
    headView.frame = CGRectMake(0, 0, kScreenWith, 40);
    headView.delegate = self;
    headView.indictorImageView.image = [UIImage imageNamed:@"flag.png"];
    headView.sectionTitleLabel.text = [self.sections objectAtIndex:section];
    NSString *number = [NSString stringWithFormat:@"%lu",[[self.dataDic objectForKey:[self.sections objectAtIndex:section]] count]];
    headView.contactNumberLabel.text = number;
    headView.tag = section;
    NSString *key = [NSString stringWithFormat:@"%ld",(long)section];
    // 通过动画效果实现展开与关闭指示状态的显示
    [UIView animateWithDuration:0.4 animations:^{
        // 如果展开，则将指示图片旋转45°，箭头向下，意为展开；
        // 如果关闭，则移除transform属性，回复原样，箭头向右，意为关闭；
        headView.indictorImageView.transform = [_openDict objectForKey:key] ? CGAffineTransformMakeRotation(M_PI_2) : CGAffineTransformIdentity;
    }];

    return headView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    MoreSelectCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *name = cell.contactTitle.text;
    if (_dataSelects.count>0) {
        
        BOOL res = [self containSomething:name];
        if (res) {
            
            [_dataSelects removeObject:name];
            cell.markImageView.image = [UIImage imageNamed:@"contact_normal"];
        }else {
        
            [_dataSelects addObject:name];
            cell.markImageView.image = [UIImage imageNamed:@"contact_select"];
        }
    }else{
    
         [_dataSelects addObject:name];
        cell.markImageView.image = [UIImage imageNamed:@"contact_select"];
    }
    
}


-(BOOL)containSomething:(NSString *)name{
 
    for (NSString *str in _dataSelects) {
        if ([str isEqualToString:name]) {
            
            return YES;
        }
    }
    return NO;
}

#pragma mark  MoreSelectHeaderViewDelegate
-(void)moreSelectHeadView:(MoreSelectHeaderView *)headView didSelectedWithTag:(NSInteger)tag{

//判断字典是不是存在 如果不存在，则新建
    if (!_openDict) {
        _openDict = [NSMutableDictionary dictionary];
    }
//获取tag值 并将其作为key值
    NSString *key = [NSString stringWithFormat:@"%ld",(long)tag];
    // 模拟展开与关闭
    // 判断当前组是否有值，有值则移除对应key-value对，无值则设置key-value对。
    if (![_openDict objectForKey:key]) {
        [_openDict setObject:key forKey:key];
    }else{
        [_openDict removeObjectForKey:key];
    }

    // 刷新表格视图指定组
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:tag] withRowAnimation:UITableViewRowAnimationFade];

}






/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
