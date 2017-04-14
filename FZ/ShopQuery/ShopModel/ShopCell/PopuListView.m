//
//  PopuListView.m
//  FZ
//
//  Created by mengdy on 16/12/2.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "PopuListView.h"

@interface PopuListView()

@property (nonatomic,strong)NSIndexPath *path;


@end

@implementation PopuListView


-(instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.lists = [NSArray array];
    }
    return self;

}

- (instancetype)initWithListViewFrame:(CGRect)frame  stely:(USPOPUSTYLE)listStyle{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.listBGimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _listBGimageView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _listBGimageView.userInteractionEnabled = YES;
        [self addSubview:_listBGimageView];
        
        _listStyle = listStyle;
        self.listTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        _listTable.delegate = self;
        _listTable.dataSource = self;
        _listTable.backgroundColor = [UIColor clearColor];
        _listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_listBGimageView addSubview:_listTable];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _lists.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *celldefaults = @"popuViewcell";
    
    ListCell  *cell = [tableView dequeueReusableCellWithIdentifier:celldefaults];;
    
    if (!cell) {
        
        cell = [[ListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celldefaults];
        
        cell.listLbTitle.text = [NSString stringWithFormat:@"%@",_lists[indexPath.row]];
        cell.listImage.image = [UIImage imageNamed:@"tick"];
        cell.listImage.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_lists.count == indexPath.row + 1) {
            
            cell.lineView.hidden = YES;
        }
        
    }
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.listBlock) {
        
        self.listBlock(indexPath,_listStyle);
    }
    
}

-(void)myListBlock:(ListBtnBlock)block {

    self.listBlock = block;
}











@end
