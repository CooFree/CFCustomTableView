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

- (NSInteger)numberOfItemsInSlideOperation:(CFSlideOperationViewCell *)cell;

- (UIButton *)slideOperationViewCell:(CFSlideOperationViewCell *)cell
                       buttonAtIndex:(NSInteger)index;

- (CGSize)slideOperationViewCell:(CFSlideOperationViewCell *)cell sizeAtIndex:(NSInteger)index;

@end

@protocol CFSlideOperationViewCellDelegate <NSObject>

- (void)slideOperationViewCell:(CFSlideOperationViewCell *)cell didSelectButtonAtIndex:(NSInteger)index;

- (void)slideOperationViewCellDidBeginSlide:(CFSlideOperationViewCell *)cell;

@end

@interface CFSlideOperationViewCell : CFBaseTableViewCell

@property (nonatomic, weak) id <CFSlideOperationViewCellDataSource> dataSource;
@property (nonatomic, weak) id <CFSlideOperationViewCellDelegate> delegate;
/** 容器视图 类似于contentView*/
@property (nonatomic, weak) UIView *cellContentView;

@end
