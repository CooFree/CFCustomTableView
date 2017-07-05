//
//  CFBaseTableViewController.m
//  CFCustomTableView
//
//  Created by YF on 2017/7/4.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "CFBaseTableViewController.h"
#import "CFBaseTableView.h"
#import "CFBaseTableViewCell.h"
#import "CFBaseTableHeaderFooterview.h"

@interface CFBaseTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CFBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self.tableView reloadData];
}

/**
 *  加载tableview
 */
- (CFBaseTableView *)tableView {
    if(!_tableView){
        CFBaseTableView *tab = [[CFBaseTableView alloc] init];
        tab.dataSource = self;
        tab.delegate = self;
        tab.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:tab];
        _tableView = tab;
        _tableView.frame=self.view.bounds;
    }
    return _tableView;
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>
// 分组数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self respondsToSelector:@selector(cf_numberOfSections)]) {
        return self.cf_numberOfSections;
    }
    return 1;
}

// 指定组返回的cell数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(cf_numberOfRowsInSection:)]) {
        return [self cf_numberOfRowsInSection:section];
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(cf_headerAtSection:)]) {
        return [self cf_headerAtSection:section];
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(cf_footerAtSection:)]) {
        return [self cf_footerAtSection:section];
    }
    return nil;
}

// 每一行返回指定的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([self respondsToSelector:@selector(cf_cellAtIndexPath:)]) {
        return [self cf_cellAtIndexPath:indexPath];
    }
    // 1. 创建cell
    CFBaseTableViewCell *cell = [CFBaseTableViewCell cellWithTableView:self.tableView];

    // 2. 返回cell
    return cell;
}

// 点击某一行 触发的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(cf_didSelectRowAtIndexPath:tableView:)]) {
        return [self cf_didSelectRowAtIndexPath:indexPath tableView:tableView];
    }
}


// 每一行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self respondsToSelector:@selector(cf_cellheightAtIndexPath:)]) {
        return [self cf_cellheightAtIndexPath:indexPath];
    }
    return tableView.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(cf_sectionHeaderHeightAtSection:)]) {
        return [self cf_sectionHeaderHeightAtSection:section];
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([self respondsToSelector:@selector(cf_sectionFooterHeaderAtSection:)]) {
        return [self cf_sectionFooterHeaderAtSection:section];
    }
    return 0.01;
}

#pragma mark - 1️⃣➢➢➢ <#mark#>
- (NSInteger)cf_numberOfSections { return 1; }

- (NSInteger)cf_numberOfRowsInSection:(NSInteger)section { return 0; }

- (void)cf_didSelectRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView
{
    NSLog(@"第%zd行点击",indexPath.row);
}
- (CFBaseTableViewCell *)cf_cellAtIndexPath:(NSIndexPath *)indexPath {
   CFBaseTableViewCell *cell = [CFBaseTableViewCell cellWithTableView:self.tableView];
    cell.textLabel.text = [NSString stringWithFormat:@"第%zd行",indexPath.row];
    return cell;
}

- (CGFloat)cf_cellheightAtIndexPath:(NSIndexPath *)indexPath { return 60; }


- (UIView *)cf_headerAtSection:(NSInteger)section {
    return [CFBaseTableHeaderFooterview headerFooterViewWithTableView:self.tableView];
}

- (UIView *)cf_footerAtSection:(NSInteger)section {
    return [CFBaseTableHeaderFooterview headerFooterViewWithTableView:self.tableView];
}

- (CGFloat)cf_sectionHeaderHeightAtSection:(NSInteger)section { return 0.01; }

- (CGFloat)cf_sectionFooterHeaderAtSection:(NSInteger)section { return 0.01; }

@end
