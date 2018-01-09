//
//  Global.h
//  improve memory
//
//  Created by 斌 on 2017/12/8.
//  Copyright © 2017年 斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Global : NSObject

+(instancetype)shareInstance;

@property(nonatomic,strong) NSString *iphoneType;

@end
