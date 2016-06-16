//
//  UIViewController+LOIndexView.m
//  LOIndexView
//
//  Created by locoo on 16/6/16.
//  Copyright © 2016年 locoo. All rights reserved.
//

#import "MJNIndexView/MJNIndexView.h"
#import "UIViewController+LOIndexView.h"
#import <objc/message.h>
#import "TestModel.h"
static void *mjIndexViewKey = &mjIndexViewKey;
static void *showDataDicKey = &showDataDicKey;
static void *indexKeysArrayKey = &indexKeysArrayKey;

@implementation UIViewController (LOIndexView)

- (MJNIndexView *)mjIndexView{
    return objc_getAssociatedObject(self, &mjIndexViewKey);
}
- (void)setMjIndexView:(NSString *)aProperty{
    objc_setAssociatedObject(self, mjIndexViewKey, aProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)showDataDic{
    return objc_getAssociatedObject(self, &showDataDicKey);
}
- (void)setShowDataDic:(NSString *)aProperty{
    objc_setAssociatedObject(self, showDataDicKey, aProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)indexKeysArray{
    return objc_getAssociatedObject(self, &indexKeysArrayKey);
}
- (void)setIndexKeysArray:(NSString *)aProperty{
    objc_setAssociatedObject(self, indexKeysArrayKey, aProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setTheIndexView {
    self.showDataDic = [NSMutableDictionary dictionaryWithCapacity:1];
    self.indexKeysArray = [NSMutableArray arrayWithArray:[self.showDataDic.allKeys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]];
    self.mjIndexView = [[MJNIndexView alloc]
                    initWithFrame:CGRectMake(0,
                                             44,
                                             [UIScreen mainScreen].bounds.size.width,
                                             [UIScreen mainScreen].bounds.size.height - 150)
                        ];
    self.mjIndexView.dataSource = self;
    self.mjIndexView.fontColor = [UIColor colorWithRed:107 / 255.0f
                                             green:107 / 255.0f
                                              blue:107 / 255.0f
                                             alpha:1];
    [self.view addSubview:self.mjIndexView];
    [self.view bringSubviewToFront:self.mjIndexView];
}


#pragma mark MJMIndexForTableView datasource methods
- (NSArray *)sectionIndexTitlesForMJNIndexView:(MJNIndexView *)indexView {
    
    return (self.indexKeysArray.count > 0) ? self.indexKeysArray : nil;
}

- (void)sectionForSectionMJNIndexTitle:(NSString *)title
                               atIndex:(NSInteger)index {
    [[self loIndexView_getTheTabelView]
     scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:index]
     atScrollPosition:UITableViewScrollPositionTop
     animated:NO];
}

#pragma mark - 数据处理
- (void)loIndexView_dealWithData:(NSArray *)array
                 withModelString:(NSString*)modelString
            andThePropertyString:(NSString*)PropertyString{
    
    if (!self.mjIndexView) {[self setTheIndexView];}
    
    if ([self.showDataDic.allKeys count] != 0) {[self.showDataDic removeAllObjects];}
    
    for (NSString *string in LOALPHA_ARRAY){
        
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        BOOL realExist = NO;
        
        __block BOOL realExistInBlock = realExist;
        __weak __typeof(&*self) theWeekSelf = self;
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop){
        
        NSString *first;
        if ([ self loIndexView_isEmpty:[obj valueForKey:PropertyString]]) {

            first = @"1"; //名字是空就用数字代替放到#里面，防止取首字母没有会蹦
            
        } else {
            
            first = [[obj valueForKey:PropertyString] substringWithRange:NSMakeRange(0, 1)];
        }
        NSString *nameFirstLetter = [self loIndexView_getTheFirstLetterWithName:first];
        NSString *outputString = [first uppercaseString];
        if ([nameFirstLetter isEqualToString:@"#"]) {

            if ([outputString hasPrefix:string]) {
                
                [temp addObject:obj];
                realExistInBlock = YES;
                
            } else if ([nameFirstLetter hasPrefix:string] &&
                       ![self loIndexView_isLetter:outputString]) {
                
                [temp addObject:obj];
                realExistInBlock = YES;
            }
            
        } else {
            
            if ([nameFirstLetter hasPrefix:string]) {
                
                [temp addObject:obj];
                realExistInBlock = YES;
            }
        }

        if (realExistInBlock){
            [theWeekSelf.showDataDic setObject:temp forKey:string];
            
        }
       
    }];
}
    self.indexKeysArray = [NSMutableArray
                           arrayWithArray:
                           [self.showDataDic.allKeys
                            sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]];
    if ([self.indexKeysArray containsObject:@"#"]){
        [self.indexKeysArray removeObject:@"#"];
        [self.indexKeysArray addObject:@"#"];
    }
    [[self loIndexView_getTheTabelView] reloadData];
    [self.mjIndexView refreshIndexItems];
}

//获取中文首字母（大写）
- (NSString *)loIndexView_getTheFirstLetterWithName:(NSString *)name {
    
  NSString *str = @"";
  str = [NSString stringWithFormat:@"%@%c", str,
                                 pinyinFirstLetter([name characterAtIndex:0])];
  NSString *outputString = [str uppercaseString];
  return outputString;
}

//是否是字母
- (BOOL)loIndexView_isLetter:(NSString *)str {
    
  for (NSString *string in LOINDEXARRAY) {
    if ([str isEqualToString:string]) {
      return YES;
    }
  }
  return NO;
}

//获取对应的TableView
-(UITableView *)loIndexView_getTheTabelView{
    
    //!!!:注意如果有N个view或许得不到TableView会出问题
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITableView class]]) {
            return (UITableView *)view;
        }
    }
    return nil;
}

#pragma mark - 判断是否是全是空字符串
- (BOOL)loIndexView_isEmpty:(id )string
{
    if (string==nil || [string isKindOfClass:[NSNull class]]) {return YES;}
    NSString* str =  [[string stringByReplacingOccurrencesOfString:@" " withString:@""]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (str.length == 0) {return YES;}
    return NO;
}

@end
