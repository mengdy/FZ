//
//  BaseTapSound.h
//  vodSeal
//
//  Created by wangwenke on 15/8/25.
//  Copyright (c) 2015年 wangwenke. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  播放音效类、判断应用是否有权限使用相机
 */
@interface BaseTapSound : NSObject


/**
 *  振动效果,默认为YES(有振动效果)
 */
@property(nonatomic) BOOL vibrate;


/**
 *  音效播放对象
 */
+(instancetype)shareTapSound;

/**
 *  添加音效文件
 */
- (void)playSoundFileName:(NSString *)soundName;

/**
 *  播放音效文件
 */
- (void)playSound;

/**
 * 播放系统音效
 */
- (void)playSystemSound;

/**
 * 是否有权限使用系统相机
 */
+ (BOOL)ifCanUseSystemCamera;

/**
 * 是否有权限使用系统相册
 */
+ (BOOL)ifCanUseSystemPhoto;

@end
