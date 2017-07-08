//
//  CFBaseTableViewCell.h
//  CFCustomTableView
//
//  Created by YF on 2017/7/4.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFBaseTableViewCell : UITableViewCell

/**
 *  快速创建一个不是从xib中加载的tableview cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
