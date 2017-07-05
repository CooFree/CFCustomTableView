//
//  CFBaseTableView.h
//  CFCustomTableView
//
//  Created by YF on 2017/7/4.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFBaseTableView : UITableView

/** 分割线颜色*/
@property (nonatomic, assign) UIColor *sepLineColor;

/** 分割线偏移*/
- (UIEdgeInsets)CF_sepEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath;


@end
