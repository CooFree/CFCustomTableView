//
//  ViewController1.m
//  CFCustomTableView
//
//  Created by YF on 2017/7/5.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "ViewController1.h"
#import "CFBaseTableViewCell.h"
#import "CFSlideTestCell.h"

@interface ViewController1 ()<CFSlideOperationViewCellDelegate,CFSlideOperationViewCellDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setData];
}
- (void)setData {
    int count = (int)self.dataArray.count;
    for (int i = count; i < count + 20; i++) {
        if (i % 2 == 0) {
            [self.dataArray addObject:@(YES)];
        } else {
            [self.dataArray addObject:@(NO)];
        }
    }
    [self.tableView reloadData];
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (NSInteger)cf_numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)cf_cellheightAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (UIEdgeInsets)cf_sepEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath {
    return UIEdgeInsetsZero;
}


- (CFBaseTableViewCell *)cf_cellAtIndexPath:(NSIndexPath *)indexPath {

    NSNumber *boolFlag = self.dataArray[indexPath.row];

    if (boolFlag.boolValue) {

        CFBaseTableViewCell *cell = [CFBaseTableViewCell cellWithTableView:self.tableView];
        cell.textLabel.text = @"普通的cell";
        return cell;

    } else {
        CFSlideTestCell *cell = [CFSlideTestCell cellWithTableView:self.tableView];
        cell.name = @"可以滑动的cell";
        cell.delegate = self;
        cell.dataSource = self;
        //        cell.cellContentView.backgroundColor = [UIColor lightGrayColor];
        // 加载内容加到这上面。。
        return cell;
    }
    return [[CFBaseTableViewCell alloc] init];
}




#pragma mark - <XRSlideOperationViewCellDataSource, XRSlideOperationViewCellDelegate>
- (NSInteger)numberOfItemsInSlideOperation:(CFSlideOperationViewCell *)cell {
    return 3;
}
- (UIButton *)slideOperationViewCell:(CFSlideOperationViewCell *)cell buttonAtIndex:(NSInteger)index {
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:[NSString stringWithFormat:@"第%ld个", index] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIColor *bgColor = [UIColor redColor];
    if (index == 0) {
        bgColor = [UIColor redColor];
    } else if (index == 1) {
        bgColor = [UIColor greenColor];
    } else if (index == 2) {
        bgColor = [UIColor whiteColor];
    }
    [btn setBackgroundColor:bgColor];
    return btn;
}

- (void)slideOperationViewCell:(CFSlideOperationViewCell *)cell didSelectButtonAtIndex:(NSInteger)index {
    NSLog(@"%@", [NSString stringWithFormat:@"点击了第几%ld个按钮", index]);
}

- (CGSize)slideOperationViewCell:(CFSlideOperationViewCell *)cell sizeAtIndex:(NSInteger)index {
    if (index == 0) {
        return CGSizeMake(80, 100);
    } else if (index == 1) {
        return CGSizeMake(60, 100);
    } else if (index == 2) {
        return CGSizeMake(100, 100);
    }
    return CGSizeZero;
}

// 开始滑动的时候调用
- (void)slideOperationViewCellDidBeginSlide:(CFSlideOperationViewCell *)cell {
    NSLog(@"---begin---slide");
}
@end
