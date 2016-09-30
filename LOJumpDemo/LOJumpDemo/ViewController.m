//
//  ViewController.m
//  LOJumpDemo
//
//  Created by locoo on 16/9/30.
//  Copyright © 2016年 locoo. All rights reserved.
//

#import "ViewController.h"
#import "Routable.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
            NSString *customURL = @"LOJumpDemo://TestJYRoutesViewController/userIdValue";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:customURL]];
        
        
//        NSString *aUrl = @"users/whatEverValue";
//        [[Routable sharedRouter] open:aUrl];

    });
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
