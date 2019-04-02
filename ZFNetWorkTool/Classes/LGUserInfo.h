//
//  LGUserInfo.h
//  JianBangOnlinerRetailersForSeller
//
//  Created by chengzhengfeng on 2018/7/6.
//  Copyright © 2018年 chengzhengfeng. All rights reserved.
//
/*
 "token": "token",
 "userCode": "23455",
 "userName": "asdasd",
 "corpCode": "asdasd",
 "corpName": "asdasd",
 "appId": "1011"
 
 */

#import "BaseModel.h"
#import "Singleton.h"

@interface LGUserInfo : BaseModel
singleton_interface(LGUserInfo)
//@property (nonatomic,copy) NSString *loginName;     //登录名（账号或手机号）
@property (nonatomic,copy) NSString *userCode;      //用户id 现定登录名
@property (nonatomic,copy) NSString *userName;      //注册填写的用户真实姓名
@property (nonatomic,copy) NSString *corpCode;   //
@property (nonatomic,copy) NSString *corpName;   //
@property (nonatomic,copy) NSString *appId;   //平台ID
@property (nonatomic,copy) NSString *token;
@property (nonatomic,copy) NSString *check_status;  // 建邦后台 1:审核通过 9：审核不通过
@property (nonatomic,copy) NSString *userType;  //   兰格后台   t：会员用户   f：一般用户

@property (nonatomic,copy) NSString *userID;

@end
