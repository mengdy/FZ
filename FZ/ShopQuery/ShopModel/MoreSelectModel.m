//
//  MoreSelectModel.m
//  FZ
//
//  Created by mengdy on 16/12/6.
//  Copyright © 2016年 mengdy. All rights reserved.
//

#import "MoreSelectModel.h"

@implementation MoreSelectModel

- (id)initWithMoreSelectDictionary:(NSDictionary *)dic {

    self = [super init];
    if (self) {
        
        self.name = [dic objectForKey:@"name"];
        self.tel = [dic objectForKey:@"tel"];
        
    }
    return self;
}


@end
