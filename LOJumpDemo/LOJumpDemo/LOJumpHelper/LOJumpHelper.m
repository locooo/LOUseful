//
//  LOJumpHelper.m
//  JYYunXi
//
//  Created by locoo on 16/9/29.
//  Copyright © 2016年 locoo. All rights reserved.
//

#import "LOJumpHelper.h"
#import "TestRoutesViewController.h"
#import "AppDelegate.h"
#import "Routable.h"
#import <objc/runtime.h>
@implementation LOJumpHelper

+(instancetype)shareJumpHelper {
    
    static LOJumpHelper * jumpHelper = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        jumpHelper = [[LOJumpHelper alloc]init];
        
    });
    
    return jumpHelper;
}



#pragma mark - Routable框架
+ (void)lo_mapTheViewConreller {

    
    
    //   UPRouterOptions *options = [[UPRouterOptions modal] withPresentationStyle: UIModalPresentationCurrentContext];
    //
    //    [[Routable sharedRouter] map:@"users/:id" toController:[ViewCCCCCViewController class] withOptions:options];
    
    [[Routable sharedRouter] map:@"users/:id" toController:[TestRoutesViewController class]];
    UINavigationController *na =(UINavigationController*)((AppDelegate*)[UIApplication sharedApplication].delegate).window.rootViewController;
    [[Routable sharedRouter] setNavigationController:na];
    
}

+ (void)lo_openMapViewController:(NSString *)urlString {
    
      [[Routable sharedRouter] open:urlString];

}
@end
