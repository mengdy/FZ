//
//  FileManager.h
//  FZ
//
//  Created by mengdy on 16/11/11.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Singleton.h"

@interface FileManager : NSObject

singleton_Interface(FileManager)

@property (nonatomic,assign) int netState;

@end
