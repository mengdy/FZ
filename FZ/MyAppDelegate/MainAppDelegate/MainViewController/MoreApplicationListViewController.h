//
//  MoreApplicationListViewController.h
//  FZ
//
//  Created by mengdy on 16/10/13.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CHINNEL_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)       objectAtIndex:0]stringByAppendingPathComponent:@"MeAppdelegateList.plist"]


@interface MoreApplicationListViewController : UIViewController

@property (nonatomic,strong)NSMutableArray *dataSouseArrs;
@property (nonatomic,strong)NSMutableArray *picDataSouseS;


@end
