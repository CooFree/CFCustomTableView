//
//  UIScrollView+CFParallaxHeader.m
//  CFCustomTableView
//
//  Created by YF on 2017/7/10.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "UIScrollView+CFParallaxHeader.h"
#import <objc/runtime.h>

#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width           //(e.g. 320)

static char UIScrollViewParallaxHeader;
static char HeaderHeight;

@implementation UIScrollView (CFParallaxHeader)

- (void)setTopView:(UIView *)topView{
    [self willChangeValueForKey:@"SpringHeadView"];
    objc_setAssociatedObject(self, &UIScrollViewParallaxHeader,
                             topView,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"SpringHeadView"];
}

- (UIView *)topView{
    return objc_getAssociatedObject(self, &UIScrollViewParallaxHeader);
}

- (void)setParallaxHeight:(CGFloat)parallaxHeight {
    objc_setAssociatedObject(self, &HeaderHeight, @(parallaxHeight), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (CGFloat)parallaxHeight {
    CGFloat headerH = [objc_getAssociatedObject(self, &HeaderHeight) floatValue];
    return headerH;
}

- (void)addParallaxHeadView:(UIView *)view {
    [self addParallaxHeadView:view isTranslucent:YES];
}
- (void)addParallaxHeadView:(UIView *)view isTranslucent:(BOOL)translucent {
    self.contentInset = UIEdgeInsetsMake(view.bounds.size.height-(translucent?64:0), 0, 0, 0);
    [self addSubview:view];
    view.frame = CGRectMake(0, -view.bounds.size.height, view.bounds.size.width, view.bounds.size.height);
    self.parallaxHeight = view.frame.size.height;
    self.topView = view;
    //使用kvo监听scrollView的滚动
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self scrollViewDidScroll:self];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offy = scrollView.contentOffset.y;

    /**  上下伸长压缩的效果  **/
    if (offy < 0) {
//        self.topView.frame = CGRectMake(0, offy, self.topView.bounds.size.width, -offy);

    }
    /**  整体向四周伸长压缩的效果 **/
    CGFloat BackGroupHeight = self.parallaxHeight;
    CGFloat yOffset  = scrollView.contentOffset.y;
    CGFloat xOffset = (yOffset + BackGroupHeight)/2;

    if (yOffset < -BackGroupHeight) {

        CGRect rect = self.topView.frame;
        rect.origin.y = yOffset;
        rect.size.height =  -yOffset ;
        rect.origin.x = xOffset;
        rect.size.width = kScreenWidth + fabs(xOffset)*2;

        self.topView.frame = rect;
    }
}

@end
