//
//  BanaDataHelp.h
//  zjsm
//
//  Created by sumpay on 16/4/22.
//  Copyright © 2016年 sunjun. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^callBack) (NSDictionary *data);
@interface BanaDataHelp : NSObject
//@property(nonatomic, copy) callBack callback;
+ (instancetype)shareBanaData;
//ios自带的get请求方式
- (void)getddWithUrlPath:(NSString *)path params:(NSString *)params callBack:(callBack) callback;
//ios自带的post请求方式
- (void)postddWithUrlPath:(NSString *)path params:(NSDictionary *)params callBack:(callBack) callback;
@end
