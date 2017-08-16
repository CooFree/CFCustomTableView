//
//  CFSlideOperationViewCell.h
//  CFCustomTableView
//
//  Created by YF on 2017/7/5.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "CFBaseTableViewCell.h"

@class CFSlideOperationViewCell;

@protocol CFSlideOperationViewCellDataSource <NSObject>


/**
 滑动按钮数量
 */
- (NSInteger)numberOfItemsInSlideOperation:(CFSlideOperationViewCell *)cell;

/**
 对按钮进行初始化

 @param cell <#cell description#>
 @param index <#index description#>
 @return <#return value description#>
 */
- (UIButton *)slideOperationViewCell:(CFSlideOperationViewCell *)cell
                       buttonAtIndex:(NSInteger)index;


/**
 按钮的大小

 @param cell <#cell description#>
 @param index <#index description#>
 @return <#return value description#>
 */
- (CGSize)slideOperationViewCell:(CFSlideOperationViewCell *)cell sizeAtIndex:(NSInteger)index;

@end

@protocol CFSlideOperationViewCellDelegate <NSObject>


/**
 点击按钮 操作

 @param cell <#cell description#>
 @param index <#index description#>
 */
- (void)slideOperationViewCell:(CFSlideOperationViewCell *)cell didSelectButtonAtIndex:(NSInteger)index;


/**
 开始滑动的时候

 @param cell <#cell description#>
 */
- (void)slideOperationViewCellDidBeginSlide:(CFSlideOperationViewCell *)cell;

@end

@interface CFSlideOperationViewCell : CFBaseTableViewCell

@property (nonatomic, weak) id <CFSlideOperationViewCellDataSource> dataSource;
@property (nonatomic, weak) id <CFSlideOperationViewCellDelegate> delegate;
/** 容器视图 类似于contentView*/
@property (nonatomic, weak) UIView *cellContentView;

@property (nonatomic, strong) UIView *tapView;

/** 设置可否滑动  默认可以滑动*/
@property (nonatomic, assign) BOOL shouldSlide;

@end
