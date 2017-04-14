//
//  LORequestManger.h
//  Photo
//
//  Created by yrapp on 15/12/15.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"
@interface LORequestManger : NSObject

+ (void)POST:(NSString *)URL params:(NSDictionary * )params success:(void (^)(id response))success
     failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))Error;


+ (void)GET:(NSString *)URL
    success:(void (^)(id response))success
    failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))Error;

+ (void)UPLOADIMAGE:(NSString *)URL
             params:(NSDictionary *)params
        uploadImage:(UIImage *)image
            success:(void (^)(id response))success
            failure:(void (^)(AFHTTPRequestOperation *operation,NSError *error))Error;




@end
