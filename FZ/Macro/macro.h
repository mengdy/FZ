//
//  macro.h
//  FZ
//
//  Created by mengdy on 16/9/29.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define APP_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]

#define kScreenWith [UIScreen mainScreen].bounds.size.width
#define kScreenHight [UIScreen mainScreen].bounds.size.height
#define kViewHight(h)  (kScreenHight/667.f)*h
#define kViewWith(w)  (kScreenWith/375.f)*w

#define kBGViewColor   [UIColor colorWithRed:235/255.f green:235/255.f blue:235/255.f alpha:1]

#define klineViewColor   [UIColor colorWithRed:235/255.f green:235/255.f blue:235/255.f alpha:1]
#define kTabbarNormalColor [UIColor colorWithRed:171/255.0 green:186/255.0 blue:203/255.0 alpha:1]
#define kTabbarSelectColor [UIColor colorWithRed:43/255.0 green:169/255.0 blue:228/255.0 alpha:1]
#define kSixWordColor   [UIColor colorWithRed:102.f/255.f green:102.f/255.f blue:102.f/255.f alpha:1]
#define kCCLineBGColor  [UIColor colorWithRed:235.f/255.f green:235.f/255.f blue:235.f/255.f alpha:1]
#define kNineWordColor [UIColor colorWithRed:153.f/255.f green:153.f/255.f blue:153.f/255.f alpha:1]
#define kAgreeWordColor [UIColor colorWithRed:33.f/255.f green:183.f/255.f blue:255.f/155.f alpha:1]

#define GuideFinshPicture @"GuideFinshPicture"


#define KEYBOARD_LICENCE  @"YVprWUJoS05QdE8ydDl6SWcwNGc1ZlMzZHo5OXFkTExQWThyU2kycVR5S2kwbEZ3RXhYNFVlT0VwTmQ3Z2FsNCs4ejVwa2s2QjZuL3dRUDYzdFVxeVIwRzRDNmZ1YkVTNlRFR1ZEZytERUhZRkpDMXNNeHNwM05GZUNLckxCUU1QbmZCUUZqQmM1THVndnY2QmVXOFpzREN4L1dnb21OaTNOaWdYd2JvWGhZPXsiaWQiOjAsInR5cGUiOiJwcm9kdWN0IiwicGFja2FnZSI6WyJjbi5zdW1wYXkuc3VtcGF5Il0sImFwcGx5bmFtZSI6WyJ6anNtIl0sInBsYXRmb3JtIjoxfQ=="

#define BSTR_EMPTY(str) (str==nil || str.length==0)
#define SMCURRENT_VERSION     @"0"

//#define URLS @"http://192.168.8.201/phoneserver/"
//正式
#define URLS @"https://m.sumpay.cn/phoneserver/"


@interface macro : NSObject

@end
