//
//  TestRoutesViewController.m
//  LOJumpDemo
//
//  Created by locoo on 16/9/30.
//  Copyright © 2016年 locoo. All rights reserved.
//

#import "TestRoutesViewController.h"

@interface TestRoutesViewController ()

@end

@implementation TestRoutesViewController
#warning 别忘了
- (id)initWithRouterParams:(NSDictionary *)params
{
    if ((self = [self initWithNibName:@"TestRoutesViewController" bundle:nil]))
    {
        self.whatEver = [params objectForKey:@"id"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
