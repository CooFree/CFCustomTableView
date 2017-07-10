//
//  UIScrollView+CFParallaxHeader.h
//  CFCustomTableView
//
//  Created by YF on 2017/7/10.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (CFParallaxHeader)

@property (nonatomic, weak) UIView *topView;
@property (nonatomic) CGFloat parallaxHeight;

- (void)addSpringHeadView:(UIView *)view isTranslucent:(BOOL)translucent;

@end
