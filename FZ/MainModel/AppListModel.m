//
//  AppListModel.m
//  FZ
//
//  Created by mengdy on 16/10/13.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "AppListModel.h"

@implementation AppListModel


-(id)initWithDictionary:(NSDictionary *)dic{
    
    self = [super init];
    if (self) {
        //对象属性  分别取字典key对应value值
        self.name = [dic objectForKey:@"name"];
        self.iconName = [dic objectForKey:@"iconImage"];
       
    }
    
    return self;
}



@end
