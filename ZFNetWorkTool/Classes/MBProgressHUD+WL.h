//
//  MBProgressHUD+WL.h
//  LanGeWuLiuPingTai
//
//  Created by  huzhongyin on 16/3/18.
//  Copyright © 2016年 LanGe. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (WL)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;
@end
