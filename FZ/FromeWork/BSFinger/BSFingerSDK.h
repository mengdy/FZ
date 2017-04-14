//
//  BSFingerSDK.h
//  BSFingerSDK
//
//  Created by Scorpio on 12/21/15.
//  Copyright © 2015 bsfit. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 设备指纹插件回调协议 : 由客户端实现.
 *
 */
@protocol BSFingerCallBack <NSObject>

@required
/**
 * 设备指纹回调方法: 设备指纹生成成功
 *
 */
- (void)generateOnSuccess :(NSString *) fingerPrint andTraceId :(NSString *)traceId;

@required
/**
 * 设备指纹回调方法: 设备指纹生成失败
 *
 */
- (void)generateOnFailed :(NSError *) error;

@end


@interface BSFingerSDK : NSObject
/**
 * 设备指纹生成类的单例.
 *
 * 调用方式 :
 *
 * [BSFingerSDK sharedInstance];
 *
 */
+ (instancetype)sharedInstance;

/**
 * 生成设备指纹的方法.
 *
 */
- (void)getFingerPrint: (id<BSFingerCallBack>)delegate withKey: (NSString *)key;

@end
