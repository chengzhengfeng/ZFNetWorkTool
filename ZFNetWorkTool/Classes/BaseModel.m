//
//  BaseModel.m
//  ironLGMI
//
//  Created by chengzhengfeng on 2017/7/31.
//  Copyright © 2017年 LanGe. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

-(id) initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

// 设置未找到的Key
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //    NSLog(@"Undefined Key: %@",key);
}


@end
