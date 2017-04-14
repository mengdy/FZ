//
//  PopuListView.h
//  FZ
//
//  Created by mengdy on 16/12/2.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListCell.h"



typedef enum {
    PopuStyle_left = 1,
    PopuStyle_centre,
    PopuStyle_Right,
}USPOPUSTYLE;

typedef void(^ListBtnBlock)(NSIndexPath *indexPath , USPOPUSTYLE listStyle);

@interface PopuListView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *listTable;
@property (nonatomic,strong)NSArray *lists;
@property (nonatomic,copy)ListBtnBlock listBlock;
@property (nonatomic,strong)UIImageView *listBGimageView;
@property (nonatomic,assign)USPOPUSTYLE listStyle;



- (instancetype)initWithListViewFrame:(CGRect)frame stely:(USPOPUSTYLE)listStyle;

-(void)myListBlock:(ListBtnBlock)block;


@end
