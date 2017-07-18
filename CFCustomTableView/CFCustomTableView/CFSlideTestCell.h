//
//  CFSlideTestCell.h
//  CFCustomTableView
//
//  Created by YF on 2017/7/6.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "CFSlideOperationViewCell.h"

@protocol TableCellImgDelegate <NSObject>

-(void)backindexPath:(NSIndexPath *)indexPath;

@end

@interface CFSlideTestCell : CFSlideOperationViewCell

@property (weak, nonatomic) id<TableCellImgDelegate> imgDelegate;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (nonatomic, copy) dispatch_block_t imgBlock;

@property (nonatomic, weak) NSString *name;
@property (nonatomic, weak) UILabel *nameL;
@property (nonatomic, strong) UIImageView  *img;
@end
