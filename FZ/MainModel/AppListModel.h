//
//  AppListModel.h
//  FZ
//
//  Created by mengdy on 16/10/13.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppListModel : NSObject

@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *iconName;


//自定义初始化方法,用来封装字典对象
-(id)initWithDictionary:(NSDictionary *)dic;


@end
