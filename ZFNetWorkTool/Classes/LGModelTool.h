//
//  LGModelTool.h
//  ironLGMI
//
//  Created by  huzhongyin on 17/5/8.
//  Copyright © 2017年 LanGe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface LGModelTool : NSObject

+(NSString *)dealWithHTMLStr:(NSString *)content withFont:(float)font;

+(id)dealWithResponseObject:(id)result andClass:(Class)modelClass;

+(NSArray *)dealWithArrayResponseObject:(id)result andClass:(Class)modalClass andKeyName:(NSString *)keyName;

+(NSMutableArray *)dealWithMutableArrayResponseObject:(id)result andClass:(Class)modalClass andKeyName:(NSString *)keyName;


@end
