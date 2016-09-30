//
//  LOJLRoutesJumpHelper.h
//  JYYunXi
//
//  Created by locoo on 16/9/30.
//  Copyright © 2016年 locoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LOJLRoutesJumpHelper : NSObject


+(instancetype)shareJLRoutesJumpHelper;


/**
 注册VC  详细见方法内部
 */
+ (void)lo_configJLRoutes;


/**
 AppDelegate 中 - (BOOL)application:(UIApplication *)app openURL:(NSURL *)url 调用

 @param aUrl 要打开的URL

 @return BOOL
 */
+ (BOOL)lo_openJLRoutesWithUrl:(NSURL *)aUrl;


/**
 查找当前活动窗口

 @return UIViewController
 */
- (UIViewController *)lo_activityViewController;
@end
