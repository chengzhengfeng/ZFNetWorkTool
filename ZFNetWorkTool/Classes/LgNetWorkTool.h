//
//  LgNetWorkTool.h
//  ironLGMI
//
//  Created by  chengzhengfeng on 2017/7/31
//  Copyright © 2017年 LanGe. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "LgUploadParam.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+WL.h"

@interface LgNetWorkTool : NSObject

@property(nonatomic,assign)AFNetworkReachabilityStatus status;  //当前网络状态

/**
 *  二次封装网络工具单例
 *
 */
+ (instancetype)sharedTool;


/**
 *  网络状态改变
 */
-(void)reachabilityStatusChange;

/**
 *  基于AFN二次封装GET方法
 *
 *  @URLString    相对路径
 *  @parames      请求参数
 *  @finish      完成回调
 *
 */
- (void)requestGET:(NSString *)URLString parames:(id)parames success:(void (^)(id responseObj))success failure:(void (^)(id error))failure;

/**
 *   基于AFN二次封装POST方法
 *
 *  @URLString    相对路径
 *  @parames      请求参数
 *  @finish      完成回调
 */
- (void)requestPOST:(NSString *)URLString parames:(id)parames success:(void (^)(id responseObj))success failure:(void (^)(id error))failure;
/**
 *  上传图片 (单张或一组)
 *
 *  @param URLString   上传图片的网址字符串
 *  @param parameters  上传图片的参数
 *  @param uploadParams 上传图片的信息
 *  @param success     上传成功的回调
 *  @param failure     上传失败的回调
 */
- (void)uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                uploadParam:(NSArray<LgUploadParam *> *)uploadParams
                    success:(void (^)(id responseObj))success
                    failure:(void (^)(id error))failure;
/**
 *  下载数据
 *
 *  @param URLString   下载数据的网址
 *  @param parameters  下载数据的参数
 *  @param success     下载成功的回调
 *  @param failure     下载失败的回调
 */
- (void)downLoadWithURLString:(NSString *)URLString
                   parameters:(id)parameters
                     progerss:(void (^)())progress
                      success:(void (^)(NSString *url))success
                      failure:(void (^)(NSError *error))failure;

@end
