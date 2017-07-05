
//
//  CFBaseTableView.m
//  CFCustomTableView
//
//  Created by YF on 2017/7/4.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "CFBaseTableView.h"

@implementation CFBaseTableView

/** 分割线颜色*/
- (void)setSepLineColor:(UIColor *)sepLineColor {
    _sepLineColor = sepLineColor;

    if (sepLineColor) {
        self.separatorColor = sepLineColor;
    }
}

/*设置分割线偏移间距并适配*/
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    if ([self respondsToSelector:@selector(CF_sepEdgeInsetsAtIndexPath:)]) {
        edgeInsets = [self CF_sepEdgeInsetsAtIndexPath:indexPath];
    }
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) [tableView setSeparatorInset:edgeInsets];
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) [tableView setLayoutMargins:edgeInsets];
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) [cell setSeparatorInset:edgeInsets];
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) [cell setLayoutMargins:edgeInsets];
}

- (UIEdgeInsets)CF_sepEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath { return UIEdgeInsetsMake(0, 15, 0, 0);
}
@end
