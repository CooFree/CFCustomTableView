//
//  CFBaseTableHeaderFooterview.h
//  CFCustomTableView
//
//  Created by YF on 2017/7/5.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFBaseTableHeaderFooterview : UITableViewHeaderFooterView

+ (instancetype)headerFooterViewWithTableView:(UITableView *)tableView;

/**
 *  传入数据
 */
@property (nonatomic, strong)id  data;

/**
 *  header and footer 的section
 */
@property (nonatomic) NSInteger  section;

/**
 *  setting HeaderFooterView Basic attributes
 */
- (void)setUpHeaderFooterView;

/**
 *  HeaderFooter Interface layout,add Interface controls :like , label button
 */
- (void)bulidHeaderFooterSubViews;

/**
 *  Interface data into
 */
- (void)loadHeaderFooterData;

/**
 *  change HeaderFooterView 的背景颜色
 *
 *  @param color
 */
- (void)setHeaderFooterBackgroundColor:(UIColor *)color;

@end
