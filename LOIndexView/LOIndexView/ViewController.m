//
//  ViewController.m
//  LOIndexView
//
//  Created by locoo on 16/6/15.
//  Copyright © 2016年 locoo. All rights reserved.
//


#import "TestModel.h"
#import "ViewController.h"

//
#import "UIViewController+LOIndexView.h"
//

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {
  NSMutableArray *_allDataMutableArry;
 
}
@property(weak, nonatomic) IBOutlet UITableView *theTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self requestData];
}
- (void)requestData {

  NSArray *titleArry = @[
    @"沈1",
    @"沈二",
    @"大赛",
    @"科技",
    @"和的",
    @"健康",
    @" 杀很大",
    @"空间圣诞",
    @"节",
    @"快单号",
    @"1",
    @"快单号",
    @"快单号",
    @"快单号",
    @"快单号",
    @"快单号",
    @"快单号",
    @"快单号",
    @"快单号",
    @"快单号",
    @"快单号",
    @"快单号",
    @"快单号",
    @"快单号",
    @"快单号",
    @"快单号",
    @"快单号",
    @"快单号",
    @"快单号"
  ];
  
  _allDataMutableArry = [NSMutableArray arrayWithCapacity:1];
  
  for (NSInteger i = 0; i < titleArry.count; i++) {
    TestModel *model = [[TestModel alloc] init];
    model.theTitle = titleArry[i];
    model.theAge = [@(i) stringValue];
    [_allDataMutableArry addObject:model];
  }
  [self loIndexView_dealWithData:_allDataMutableArry
                 withModelString:@"TestModel"
            andThePropertyString:@"theTitle"];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

  return (self.indexKeysArray.count > 0) ? self.indexKeysArray.count : 0;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {

    
 return (self.indexKeysArray.count > 0)?((NSArray*)[self.showDataDic objectForKey:[self.indexKeysArray objectAtIndex:section]]).count:0;
    
  }

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
  static NSString *communicationIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:communicationIdentifier];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:communicationIdentifier];
  }

  if (self.indexKeysArray.count > 0) {
    NSArray *array = [self.showDataDic
        objectForKey:[self.indexKeysArray objectAtIndex:indexPath.section]];
    TestModel *model = [array objectAtIndex:indexPath.row];
    cell.textLabel.text = model.theTitle;
  }
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 44;
}
- (UIView *)tableView:(UITableView *)tableView
    viewForHeaderInSection:(NSInteger)section {

  if (self.indexKeysArray.count > 0) {
    UILabel *la = [[UILabel alloc]
        initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,
                                 30)];
    la.text = self.indexKeysArray[section];
      la.backgroundColor = [UIColor orangeColor];
    return la;

  }
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView
    heightForHeaderInSection:(NSInteger)section {
  return 30;
}
- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}


@end
