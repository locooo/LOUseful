//
//  LOJumpHelper.h
//  JYYunXi
//
//  Created by locoo on 16/9/29.
//  Copyright © 2016年 locoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LOJumpHelper : NSObject

+(instancetype)shareJumpHelper;
/**
 注册VC  不好的地方就是要指定nav 而不是通过block在需要打开时再根据情况来设定push present  来设定nav
 */
+ (void)lo_mapTheViewConreller;

/**
 打开urlString对应的viewController

 @param urlString vc对应的urlString
 */
+ (void)lo_openMapViewController:(NSString *)urlString;



/*
+ (void)lo_configRoutes;

+ (BOOL)lo_openConfigRouts;
*/
@end
