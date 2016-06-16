//
//  UIViewController+LOIndexView.h
//  LOIndexView
//
//  Created by locoo on 16/6/16.
//  Copyright © 2016年 locoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HanyuPinyinOutputFormat.h"
#import "PinYin4Objc.h"
#import "MJNIndexView.h"
#define LOALPHA_ARRAY                                                          \
  [NSArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H",    \
                            @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P",    \
                            @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X",    \
                            @"Y", @"Z", @"#", nil]

#define LOINDEXARRAY                                                           \
  [NSArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H",    \
                            @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P",    \
                            @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X",    \
                            @"Y", @"Z", nil]

@interface UIViewController (LOIndexView) <MJNIndexViewDataSource>
@property(nonatomic, strong) MJNIndexView *mjIndexView;/**< 侧边索引 */
@property(nonatomic, strong) NSMutableDictionary *showDataDic; /**< 放索引对应的model */
@property(nonatomic, strong) NSMutableArray *indexKeysArray; /**< 排好序的索引 @[A,B,C]样式*/
/**
 *  对数据进行处理 并且刷新tableview
 *
 *  @param array          原始Model数据
 *  @param modelString    Modle Class
 *  @param PropertyString model排序的属性
 */
- (void)loIndexView_dealWithData:(NSArray *)array
                 withModelString:(NSString *)modelString
            andThePropertyString:(NSString *)PropertyString;

@end
