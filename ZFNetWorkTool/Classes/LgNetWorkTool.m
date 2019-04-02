//
//  LgNetWorkTool.m
//  ironLGMI
//
//  Created by  chengzf on 17/7/31.
//  Copyright © 2017年 LanGe. All rights reserved.
//

#import "LgNetWorkTool.h"
//获取沙盒Document路径
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) firstObject]
@implementation LgNetWorkTool

+ (instancetype)sharedTool{
    static dispatch_once_t onceToken;
    static LgNetWorkTool *instance;
    dispatch_once(&onceToken, ^{
        instance = [[super alloc]init];
        
    });
    return instance;
}

-(void)reachabilityStatusChange{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
   __block int i = 0;
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        // 当网络状态改变时调用
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                _status = AFNetworkReachabilityStatusUnknown;
                i = 1;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                _status = AFNetworkReachabilityStatusNotReachable;
                [MBProgressHUD showError:@"当前网络已断连"];
                i = 1;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"手机自带网络");
                _status = AFNetworkReachabilityStatusReachableViaWWAN;
                if (i) {
                    [MBProgressHUD showError:@"当前已连接移动网络"];
                }else{
                    i = 1;
                }

                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
                _status = AFNetworkReachabilityStatusReachableViaWiFi;
                if (i) {
                    [MBProgressHUD showError:@"当前已连接WIFI网络"];
                }else{
                    i = 1;
                }
                break;
        }
    }];
    
    //开始监控
    [manager startMonitoring];
    
}


#pragma mark - 自定义GET

- (void)requestGET:(NSString *)URLString parames:(id)parames success:(void (^)(id responseObj))success failure:(void (^)(id error))failure{
    //创建AFHTTPSessionManager对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    requestSerializer.timeoutInterval = 30;
    ///我们项目是把access_token（后台验证用户s身份份标识）放在了请求头里,有的项目是放在了请求体里,视实际情况而定
    // [requestSerializer setValue:[SDHSDataCache getToken] forHTTPHeaderField:@"access_token"];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"User-Agent"];
    manager.requestSerializer = requestSerializer;
    
    //        ///1.强制更换AFN数据解析类型 只支持一下添加的数据类型 AFN自带的就没有了 如果AFN新增了数据解析类型 这里也没有变化 所以有下面2方法 向原有可解析数据类型添加较好
    //        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"plant/html",nil];8k9K10
    
    //2.获取AFN原有的数据解析类型 然后新增一些响应解析器能够接受的数据类型
    NSMutableSet *acceptableContentTypes = [NSMutableSet setWithSet:manager.responseSerializer.acceptableContentTypes];
    [acceptableContentTypes addObjectsFromArray:@[@"application/json", @"text/json", @"text/javascript",@"text/html",@"plant/html",@"text/plain",@"text/xml"]];
    manager.responseSerializer.acceptableContentTypes = acceptableContentTypes;
    //AFN没有做UTF8转码 防止URL字符串中含有中文或特殊字符发生崩溃
    URLString = [[NSString  stringWithFormat:@"%@",URLString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    [manager GET:URLString parameters:parames success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

#pragma mark - 自定义POST

- (void)requestPOST:(NSString *)URLString parames:(id)parames success:(void (^)(id responseObj))success failure:(void (^)(id error))failure{
    //创建AFHTTPSessionManager对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    requestSerializer.timeoutInterval = 30;
    ///我们项目是把access_token（后台验证用户s身份份标识）放在了请求头里,有的项目是放在了请求体里,视实际情况而定
    // [requestSerializer setValue:[SDHSDataCache getToken] forHTTPHeaderField:@"access_token"];
    [requestSerializer setValue:@"ios" forHTTPHeaderField:@"User-Agent"];
    manager.requestSerializer = requestSerializer;
    
    //序列化了，把返回的数据类型转化成nsdata类型了
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //        ///1.强制更换AFN数据解析类型 只支持一下添加的数据类型 AFN自带的就没有了 如果AFN新增了数据解析类型 这里也没有变化 所以有下面2方法 向原有可解析数据类型添加较好
//            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"plant/html",nil];8k9K10
    
    ///2.获取AFN原有的数据解析类型 然后新增一些响应解析器能够接受的数据类型
    NSMutableSet *acceptableContentTypes = [NSMutableSet setWithSet:manager.responseSerializer.acceptableContentTypes];
    [acceptableContentTypes addObjectsFromArray:@[@"application/json", @"text/json", @"text/javascript",@"text/html",@"plant/html",@"text/plain",@"text/xml"]];
    manager.responseSerializer.acceptableContentTypes = acceptableContentTypes;
    //AFN没有做UTF8转码 防止URL字符串中含有中文或特殊字符发生崩溃
    URLString = [[NSString  stringWithFormat:@"%@",URLString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //AFN没有做UTF8转码 防止URL字符串中含有中文或特殊字符 发生崩溃
    URLString = [[NSString stringWithFormat:@"%@",URLString]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    http://newapp.lgmi.com/priceCenter/getAllVarieties.asp
    [manager POST:URLString parameters:parames success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        NSLog(@"%@",task);
        NSLog(@"%@",task.currentRequest.allHTTPHeaderFields);
        //将接收回来的数据转成UTF8的字符串，然后取出格式占位符 加上个转义符后才能让数据进行转换 否则转换失败
//                NSString*jsonString = [[NSString alloc] initWithBytes:[responseObject bytes]length:[responseObject length]encoding:NSUTF8StringEncoding];
//                jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\t" withString:@"\\t"];
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [MBProgressHUD showError:@"网络错误，请检查您的网络"];
        failure(error);
    }];
}

#pragma mark - 上传数据
- (void)uploadWithURLString:(NSString *)URLString parameters:(id)parameters uploadParam:(NSArray<LgUploadParam *> *)uploadParams success:(void (^)(id responseObj))success failure:(void (^)(id error))failure {
    //创建AFHTTPSessionManager对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    requestSerializer.timeoutInterval = 100;
    ///我们项目是把access_token（后台验证用户s身份份标识）放在了请求头里,有的项目是放在了请求体里,视实际情况而定
    // [requestSerializer setValue:[SDHSDataCache getToken] forHTTPHeaderField:@"access_token"];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"User-Agent"];
    manager.requestSerializer = requestSerializer;
    
    //        ///1.强制更换AFN数据解析类型 只支持一下添加的数据类型 AFN自带的就没有了 如果AFN新增了数据解析类型 这里也没有变化 所以有下面2方法 向原有可解析数据类型添加较好
    //        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"plant/html",nil];8k9K10
    
    ///2.获取AFN原有的数据解析类型 然后新增一些响应解析器能够接受的数据类型
    NSMutableSet *acceptableContentTypes = [NSMutableSet setWithSet:manager.responseSerializer.acceptableContentTypes];
    [acceptableContentTypes addObjectsFromArray:@[@"application/json", @"text/json", @"text/javascript",@"text/html",@"plant/html",@"text/plain",@"text/xml"]];
    manager.responseSerializer.acceptableContentTypes = acceptableContentTypes;
    //AFN没有做UTF8转码 防止URL字符串中含有中文或特殊字符发生崩溃
    URLString = [[NSString  stringWithFormat:@"%@",URLString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //开始请求
    URLString = [NSString stringWithFormat:@"%@",URLString];
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  formData) {
        for (LgUploadParam *uploadParam in uploadParams) {
            [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.filename mimeType:uploadParam.mimeType];
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
    }];
}

#pragma mark - 下载数据

- (void)downLoadWithURLString:(NSString *)URLString parameters:(id)parameters progerss:(void (^)())progress success:(void (^)(NSString *))success failure:(void (^)(NSError *))failure {
    NSURL *url = [NSURL URLWithString:[URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%lld   %lld",downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *ss = [[URLString componentsSeparatedByString:@"/"]lastObject];
        NSString *path = [kDocumentPath stringByAppendingPathComponent:ss];
        NSLog(@"文件路径＝＝＝%@",path);
        return [NSURL fileURLWithPath:path];//这里返回的是文件下载到哪里的路径 要注意的是必须是携带协议file://
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //        [MBProgressHUD showSuccess:@"下载完成,正在打开"];
        //        if (error) {
        //
        //        }else {
        NSString *name = [filePath path];
        NSLog(@"下载完成文件路径＝＝＝%@",name);
        success(name);
        //        }
    }];
    [task resume];//开始下载 要不然不会进行下载的
}

@end
