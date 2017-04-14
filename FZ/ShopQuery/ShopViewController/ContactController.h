//
//  ContactController.h
//  FZ
//
//  Created by mengdy on 16/12/6.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreSelectCell.h"

typedef void(^SelectBlock)(NSArray *array);
@interface ContactController : UITableViewController

@property (nonatomic,copy)SelectBlock selectBolock;

-(void)mySelectBlock:(SelectBlock)block;

@end
