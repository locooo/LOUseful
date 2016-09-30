//
//  LOJLRoutesJumpHelper.m
//  JYYunXi
//
//  Created by locoo on 16/9/30.
//  Copyright © 2016年 locoo. All rights reserved.
//

#import "LOJLRoutesJumpHelper.h"
#import "JLRoutes.h"
#import <objc/runtime.h>
@implementation LOJLRoutesJumpHelper
+(instancetype)shareJLRoutesJumpHelper {
    static LOJLRoutesJumpHelper * jumpHelper = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        jumpHelper = [[LOJLRoutesJumpHelper alloc]init];
        
    });
    return jumpHelper;
}

+ (void)lo_configJLRoutes {

//    NSString *customURL = @"JYYunXii://ViewCCCCCViewController/lee";
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:customURL]];
    
    //users 表示VC userId 表示这个VC的一个属性  users等可以替换成其他
    [JLRoutes addRoute:@"/:users/:userId" handler:^BOOL(NSDictionary<NSString *,NSString *> * _Nonnull parameters) {
        
        [[LOJLRoutesJumpHelper shareJLRoutesJumpHelper]lo_startToJump:@"users" andVCparameters:parameters];
        return YES;
    }];
}

+ (BOOL)lo_openJLRoutesWithUrl:(NSURL *)aUrl {
    
    return  [JLRoutes  routeURL:aUrl];
    
}
- (void)lo_startToJump:(NSString *)vcString andVCparameters:(NSDictionary *)vcParameters{
    NSString *viewID = vcParameters[vcString];
    id controller =[[NSClassFromString(viewID) alloc]initWithNibName:viewID bundle:nil ];
    UIViewController *tureVC = (UIViewController*)controller;
    UIViewController *activeVC = [[LOJLRoutesJumpHelper shareJLRoutesJumpHelper] lo_activityViewController];
    
    [[LOJLRoutesJumpHelper shareJLRoutesJumpHelper] lo_paramToVc:tureVC param:vcParameters];
    
    [[LOJLRoutesJumpHelper shareJLRoutesJumpHelper]lo_toPushOrPresentVC:activeVC andBePushOrPresentVC:tureVC];

    
}
#pragma mark - 查找当前活动窗口
- (UIViewController *)lo_activityViewController {
    
    UIViewController* activityViewController = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows)
        {
            if(tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0)
    {
        UIView *frontView = [viewsArray objectAtIndex:0];
        
        id nextResponder = [frontView nextResponder];
        
        if([nextResponder isKindOfClass:[UIViewController class]])
        {
            activityViewController = nextResponder;
        }
        else
        {
            activityViewController = window.rootViewController;
        }
    }
    
    return activityViewController;
}

#pragma mark - 判断怎样跳出界面
-(void)lo_toPushOrPresentVC:(UIViewController*)theLastVC
                   andBePushOrPresentVC:(UIViewController*)bePushOrPresentVC
{
    UINavigationController *nav = [self lo_setTheNavWithBePresentOrPushedVC:bePushOrPresentVC];
    
    if ([theLastVC isKindOfClass:[UITabBarController class]])
    {
        UITabBarController *tabVC = (UITabBarController *)theLastVC;
        UIViewController *tabRootVC = tabVC.viewControllers[tabVC.selectedIndex];
        if ([tabRootVC isKindOfClass:[UINavigationController class]])
        {
            [(UINavigationController *)tabRootVC pushViewController:bePushOrPresentVC animated:YES];
        }else
        {
            [theLastVC presentViewController:bePushOrPresentVC animated:YES completion:^{
                [nav.navigationBar.topItem setLeftBarButtonItem:[self lo_leftBackItemWithVC:bePushOrPresentVC]];
            }];
        }
    }else if ([theLastVC isKindOfClass:[UINavigationController class]])
    {
#warning  或替换成自定义的NavigationController
        [(UINavigationController*)theLastVC pushViewController:bePushOrPresentVC animated:YES];
    }else
    {
        [theLastVC presentViewController:nav animated:YES completion:^{
            [nav.navigationBar.topItem setLeftBarButtonItem:[self lo_leftBackItemWithVC:bePushOrPresentVC]];
        }];
    }
    
    
    
}

#pragma mark - 返回按钮
- (UIBarButtonItem *)lo_leftBackItemWithVC:(UIViewController *)vcController {
    
#warning 设置返回按钮图片
    UIImage *leftImage = [UIImage imageNamed:@"left"];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0) {
        [leftButton setFrame:CGRectMake(5, 5, leftImage.size.width, leftImage.size.height)];
        [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    }else{
        [leftButton setFrame:CGRectMake(5, 5, leftImage.size.width, leftImage.size.height)];
    }
    
    objc_setAssociatedObject(leftButton, "lo_currenctVC", vcController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [leftButton setImage:leftImage forState:UIControlStateNormal];
    [leftButton addTarget:self
                   action:@selector(dismissOrPopJump:)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    return leftItem;
}
-(void)dismissOrPopJump:(UIButton *)btn
{
    UIViewController *bePresentOrPushVC = objc_getAssociatedObject(btn, "lo_currenctVC");
    NSArray *viewcontrollers = bePresentOrPushVC.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            //push方式
            [bePresentOrPushVC.navigationController popViewControllerAnimated:YES];
        }
    }
    else{
        //present方式
        [bePresentOrPushVC dismissViewControllerAnimated:YES completion:nil];
    }

}

#pragma mark - Present出来时设置UINavigationController
-(UINavigationController *)lo_setTheNavWithBePresentOrPushedVC:(UIViewController *)toBePresentVC {
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:toBePresentVC];
    nav.navigationBar.barTintColor = [UIColor redColor];
    nav.navigationBar.translucent = NO;
    nav.interactivePopGestureRecognizer.enabled = YES;
    UIColor * color = [UIColor colorWithRed:149 / 255.0f green:69 / 255.0f blue:20 / 255.0f alpha:1];
    nav.navigationBar.tintColor = color;
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    nav.navigationBar.titleTextAttributes = dict;
    return nav;
}

#pragma mark - 匹配VC中属性的值
-(void)lo_paramToVc:(UIViewController *) v param:(NSDictionary<NSString *,NSString *> *)parameters{
    
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList(v.class , &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        NSString *param = parameters[key];
        if (param != nil) {
            [v setValue:param forKey:key];
        }
    }
}


@end
