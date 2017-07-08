//
//  CFSlideOperationViewCell.m
//  CFCustomTableView
//
//  Created by YF on 2017/7/5.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "CFSlideOperationViewCell.h"
#import "UIView+CFTap.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@implementation CFSlideOperationViewCell

#define kAnimatedDuration 0.3f

- (void)setDataSource:(id<CFSlideOperationViewCellDataSource>)dataSource {
    _dataSource = dataSource;
    if (dataSource) {
        self.shouldSlide = YES;
        [self initViews];
    }
}
- (void)initViews {
    NSInteger btnCount = 0;
    if ([self.dataSource respondsToSelector:@selector(numberOfItemsInSlideOperation:)]) {
        btnCount = [self.dataSource numberOfItemsInSlideOperation:self];
    } else {
        btnCount = 0;
    }

    if (btnCount > 0) {
        for (int i = 0; i < btnCount; i++) {
            UIButton *btn = nil;
            // 创建button
            if ([self.dataSource respondsToSelector:@selector(slideOperationViewCell:buttonAtIndex:)]) {
                btn = [self.dataSource slideOperationViewCell:self buttonAtIndex:i];
                if ([btn isKindOfClass:[UIButton class]] == NO) {
                    btn = [[UIButton alloc] init];
                }
            } else {
                btn = [[UIButton alloc] init];
            }

            btn.tag = i + 1;
            [self.contentView addSubview:btn];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        }

        [self addPanGestToCellContentView];
    }

}

- (void)btnClick:(UIButton *)btn {

    [self reverse];
    if (self.delegate && [self.delegate respondsToSelector:@selector(slideOperationViewCell:didSelectButtonAtIndex:)]) {
        [self.delegate slideOperationViewCell:self didSelectButtonAtIndex:btn.tag - 1];
    }
}
- (UIView *)tapView {
    if (_tapView==nil) {
        UIView *tapView = [[UIView alloc] init];
        tapView.frame = self.contentView.bounds;
        tapView.hidden = YES;
        tapView.backgroundColor = [[UIColor groupTableViewBackgroundColor]colorWithAlphaComponent:0.5];
        _tapView = tapView;

        WeakSelf(weakSelf);
        [tapView setTapActionWithBlock:^{
            [weakSelf reverse];
        }];
    }
    return _tapView;
}
- (UIView *)cellContentView {

    if (_cellContentView == nil) {
        UIView *cellContentView = [[UIView alloc] init];
        cellContentView.backgroundColor = [UIColor whiteColor];
        [cellContentView addSubview:self.tapView];
        cellContentView.userInteractionEnabled=YES;
        [self.contentView addSubview:cellContentView];
        [self.contentView bringSubviewToFront:cellContentView];
        _cellContentView = cellContentView;
//        WeakSelf(weakSelf);
//        [cellContentView setTapActionWithBlock:^{
//            [weakSelf reverse];
//        }];

    }
    return _cellContentView;
}

- (void)reverse {
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint center = self.contentView.center;
        center.x = self.contentView.center.x;
        self.cellContentView.center = center;
        self.tapView.hidden = YES;
//        self.cellContentView.centerX = self.contentView.centerX;
    }];
}

- (void)layoutSubviews {

    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfItemsInSlideOperation:)]) {
        NSInteger btnCount = [self.dataSource numberOfItemsInSlideOperation:self];
        if (btnCount) {
            CGFloat btnW = kScreenWidth / 2.0 / btnCount * 1.0;
            CGFloat btnRight = kScreenWidth;
            for (int i = 0; i < btnCount; i++) {
                UIButton *btn = (UIButton *)[self.contentView viewWithTag:i + 1];
                if (self.dataSource && [self.dataSource respondsToSelector:@selector(slideOperationViewCell:sizeAtIndex:)]) {
                    CGSize size = [self.dataSource slideOperationViewCell:self sizeAtIndex:i];
                    if (size.width > btnW || size.width < 30) {
                        size.width = btnW;
                    }
                    btn.frame = CGRectMake(btnRight - size.width, 0, size.width, self.contentView.frame.size.height);
                    btnRight -= size.width;
                }
            }
        }
    }
    [self.contentView bringSubviewToFront:self.cellContentView];
    self.cellContentView.frame = self.contentView.bounds;
    self.tapView.frame = self.contentView.bounds;
    [super layoutSubviews];
}

- (void)addPanGestToCellContentView {

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestAction:)];
    // 设置代理
    pan.delegate = self;
    [self.cellContentView addGestureRecognizer:pan];
}

- (CGFloat)totalW {
    CGFloat totalW = 0;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfItemsInSlideOperation:)]) {
        NSInteger items = [self.dataSource numberOfItemsInSlideOperation:self];
        if (items == 0) {
            totalW = 0;
        }
        for (int i = 0; i < items; i++) {
            UIButton *btn = (UIButton *)[self.contentView viewWithTag:i + 1];
            totalW += btn.frame.size.width;
        }
    } else {
        totalW = 0;
    }
    return totalW;
}

- (void)panGestAction:(UIPanGestureRecognizer *)panGest {


    // 根据状态设置东西 当开始滑动手势的时候，需要刷新其余cell，只让当前cell 显示设置和删除按钮
    if (panGest.state == UIGestureRecognizerStateBegan) { // 手势开始
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(slideOperationViewCellDidBeginSlide:)]) {
            [self.delegate slideOperationViewCellDidBeginSlide:self];
        }

    } else if (panGest.state == UIGestureRecognizerStateChanged) { // 手势移动

        CGPoint point = [panGest translationInView:self.contentView];

        // 修改中心点坐标
        CGFloat centerX = self.cellContentView.center.x + point.x;

        // 情况1. 刚开始 直接右滑
        if (centerX > self.contentView.center.x) {
            centerX = self.contentView.center.x;
            self.cellContentView.center = CGPointMake(centerX, self.cellContentView.center.y);
        }

        // 情况2. 按钮显示  右滑
        if ((point.x > 0 && self.cellContentView.center.x < self.contentView.center.x)) {
            self.cellContentView.center = CGPointMake(centerX, self.cellContentView.center.y);
        }

        // 情况3. 删除按钮显示不完全，回弹
        if (centerX < self.contentView.center.x && centerX > self.contentView.center.x - [self totalW] / 2.0) {
            self.cellContentView.center = CGPointMake(centerX, self.cellContentView.center.y);
        }

        // 情况4. 删除按钮显示完全
        if (centerX < self.contentView.center.x-[self totalW] / 2.0 && centerX > self.contentView.center.x-[self totalW]) {
            self.cellContentView.center = CGPointMake(centerX, self.cellContentView.center.y);
        }

        // translation需要归0因为是不断增加的。
        [panGest setTranslation:CGPointZero inView:self.cellContentView];

    } else if (panGest.state == UIGestureRecognizerStateEnded) { // 手势结束

        if (self.cellContentView.center.x > self.contentView.center.x - [self totalW] / 2.0 && self.cellContentView.center.x < self.contentView.center.x) {

            [UIView animateWithDuration:kAnimatedDuration animations:^{

                self.cellContentView.center = CGPointMake(self.contentView.center.x, self.cellContentView.center.y);
                self.tapView.hidden=YES;
            }];
        }
        if ((self.cellContentView.center.x < (self.contentView.center.x-[self totalW] / 2.0)) && (self.cellContentView.center.x > (self.contentView.center.x-[self totalW]))) {

            [UIView animateWithDuration:kAnimatedDuration animations:^{
                self.tapView.hidden=NO;
                self.cellContentView.center = CGPointMake(self.contentView.center.x-[self totalW], self.cellContentView.center.y);
            }];
        }



    }
}

/**
 *  通过此代理方法实现 上下拖动和左右拖动的区分
 *  如果 左右拖动幅度  大于 上下拖动幅度
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {

    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {

        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint point = [pan translationInView:self.contentView];
        // 左右滑动
        if (fabs(point.x) > fabs(point.y)) {
            return _shouldSlide;
        }
    }

    return NO;
}

@end
