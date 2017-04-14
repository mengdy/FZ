//
//  BanaDataHelp.m
//  zjsm
//
//  Created by sumpay on 16/4/22.
//  Copyright © 2016年 sunjun. All rights reserved.
//

#import "BanaDataHelp.h"
#import "Helper.h"

@implementation BanaDataHelp

+ (instancetype)shareBanaData
{
    static BanaDataHelp *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [BanaDataHelp new];
    });
    return helper;
}

- (void)getddWithUrlPath:(NSString *)path params:(NSString *)params callBack:(callBack)callback
{
    BOOL ool = [Helper getProxyStatus];
    if (ool) {
        
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"你的网络已经被代理不安全!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertView addAction:action];
       
      UIViewController *VC = [[[UIApplication sharedApplication]keyWindow] rootViewController];
        [VC presentViewController:alertView animated:YES completion:^{
            
        }];
        return;
    }
    
    
    
    if (params) {
        [path stringByAppendingString:[NSString stringWithFormat:@"?%@",params]];
    }
    
    NSString*  pathStr = [path  stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"url:%@",pathStr);
    NSURL *url = [NSURL URLWithString:pathStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!data) {
                return ;
            }
            //json  解析数据
            id jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:Nil];
//            NSLog(@"%@",jsonData);
            
            if ([jsonData  isKindOfClass:[NSArray  class]]) {
                NSDictionary*  dic = jsonData[0];
                
                callback(dic);
                
                
            }else{
                callback(jsonData);
            }
        });
        
    }];
    //开始请求
    [task resume];
    
}

- (void)postddWithUrlPath:(NSString *)path params:(NSDictionary *)params callBack:(callBack)callback
{
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSError*  error;
    
    if ([NSJSONSerialization isValidJSONObject:params]) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
        [request  setHTTPBody:jsonData];
        
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString*  str = [[NSString   alloc]initWithData:data encoding:NSUTF8StringEncoding];
//                NSLog(@"..........%@",str);
                id  jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:Nil];
                if ([jsonData  isKindOfClass:[NSArray  class]]) {
                    NSDictionary*  dic = jsonData[0];
                    
                    callback(dic);
                    
                    
                }else{
                    callback(jsonData);
                }
            });
            
        }];
        //开始请求
        [task resume];
    }
}
@end
