//
//  LGModelTool.m
//  ironLGMI
//
//  Created by  huzhongyin on 17/5/8.
//  Copyright © 2017年 LanGe. All rights reserved.
//

#import "LGModelTool.h"

@implementation LGModelTool
+(id)dealWithResponseObject:(id)result andClass:(Class)modalClass{
    
//    id modalInstance=[[modalClass alloc]init];
//    [modalInstance setValuesForKeysWithDictionary:result];
    id modalInstance = [modalClass mj_objectWithKeyValues:result];
    return modalInstance;
}

+(NSArray *)dealWithArrayResponseObject:(id)result andClass:(Class)modalClass andKeyName:(NSString *)keyName{
    NSMutableArray *mutableArray=[NSMutableArray array];
    if ([result[keyName] isKindOfClass:[NSArray class]]) {
        NSArray *array=result[keyName];
        for (NSDictionary *dic in array) {
            id aModal = [modalClass mj_objectWithKeyValues:dic];
            [mutableArray addObject:aModal];
        }
    }
    return [mutableArray copy];
}

+(NSMutableArray *)dealWithMutableArrayResponseObject:(id)result andClass:(Class)modalClass andKeyName:(NSString *)keyName{
    NSMutableArray *mutableArray=[NSMutableArray array];
    if ([result[keyName] isKindOfClass:[NSArray class]]) {
        NSArray *array=result[keyName];
        for (NSDictionary *dic in array) {
            id aModal=[modalClass mj_objectWithKeyValues:dic];
            [mutableArray addObject:aModal];
        }
    }
    return [mutableArray mutableCopy];
}

+(NSString *)dealWithHTMLStr:(NSString *)content withFont:(float)font{
    NSMutableString *muString = [[NSMutableString alloc] initWithString:content];
    [muString replaceOccurrencesOfString:@"\r" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muString.length)];
    [muString replaceOccurrencesOfString:@"\n" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muString.length)];
    [muString replaceOccurrencesOfString:@"\t" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, muString.length)];
    
    NSString *BookStr = [NSString stringWithFormat:@"<html> \n"
                         "<head> \n"
                         "<style type=\"text/css\"> \n"
                         "body {margin-top:20;font-size: %f;color:black}\n"
                         "</style> \n"
                         "</head> \n"
                         "<body>%@</body> \n"
                         "</html>",font,muString];
    //此处content为要设置字体大小的html内容代码
    return BookStr;
}
@end
