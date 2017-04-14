//
//  MoreSelectModel.h
//  FZ
//
//  Created by mengdy on 16/12/6.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoreSelectModel : NSObject

@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *tel;


//自定义初始化方法,用来封装字典对象
-(id)initWithMoreSelectDictionary:(NSDictionary *)dic;

@end
