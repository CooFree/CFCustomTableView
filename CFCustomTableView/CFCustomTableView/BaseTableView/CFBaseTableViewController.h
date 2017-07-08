//
//  CFBaseTableViewController.h
//  CFCustomTableView
//
//  Created by YF on 2017/7/4.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CFBaseTableView.h"
@class CFBaseTableViewCell;

@interface CFBaseTableViewController : UIViewController

@property (nonatomic, weak) CFBaseTableView *tableView;

- (NSInteger)cf_numberOfSections;
- (NSInteger)cf_numberOfRowsInSection:(NSInteger)section;
- (void)cf_didSelectRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;
- (CFBaseTableViewCell *)cf_cellAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)cf_cellheightAtIndexPath:(NSIndexPath *)indexPath;
- (UIView *)cf_headerAtSection:(NSInteger)section;
- (UIView *)cf_footerAtSection:(NSInteger)section ;
- (CGFloat)cf_sectionHeaderHeightAtSection:(NSInteger)section;
- (CGFloat)cf_sectionFooterHeaderAtSection:(NSInteger)section;

/** 分割线偏移*/
- (UIEdgeInsets)cf_sepEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath;

@end
