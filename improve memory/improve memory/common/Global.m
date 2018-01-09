//
//  Global.m
//  improve memory
//
//  Created by 斌 on 2017/12/8.
//  Copyright © 2017年 斌. All rights reserved.
//

#import "Global.h"

static Global *instance=nil;
@implementation Global

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[Global alloc] init];
    });
    return instance;
}

@end
