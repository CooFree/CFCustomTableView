
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


@end
