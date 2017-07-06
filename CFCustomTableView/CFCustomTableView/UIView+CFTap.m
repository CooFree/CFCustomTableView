//
//  UIView+CFTap.m
//  CFCustomTableView
//
//  Created by YF on 2017/7/5.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "UIView+CFTap.h"
#import <objc/runtime.h>


@implementation UIView (CFTap)

/**
 *  动态添加手势
 */
static const char *ActionHandlerTapGestureKey;

- (void)setTapActionWithBlock:(void (^)(void))block
{
    self.userInteractionEnabled = YES;

    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &ActionHandlerTapGestureKey);

    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &ActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }

    objc_setAssociatedObject(self, &ActionHandlerTapGestureKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)handleActionForTapGesture:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        void(^action)(void) = objc_getAssociatedObject(self, &ActionHandlerTapGestureKey);
        if (action) {
            action();
        }
    }
}
@end
