//
//  ViewController1.m
//  CFCustomTableView
//
//  Created by YF on 2017/7/5.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "ParallaxHeaderViewController.h"
#import "CFBaseTableViewCell.h"
#import "CFSlideTestCell.h"

#import "ImageModel.h"

#import "SDWebImage/SDWebImage/UIImageView+WebCache.h"
#import "ShowImageController.h"
#import "UIScrollView+CFParallaxHeader.h"


@interface ParallaxHeaderViewController ()<CFSlideOperationViewCellDelegate,CFSlideOperationViewCellDataSource,TableCellImgDelegate>
{
    NSInteger indexRow;
    UIImageView *imageview;
    CGRect frame_first;
}
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIImageView *topView;
@property (nonatomic, strong) UIView *header;
@end

@implementation ParallaxHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setData];

}
- (UIView *)header {
    if (!_header) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
        [view addSubview:self.topView];

        _header = view;
    }
    return _header;
}
- (UIView *)tableHeader {
   UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    [view addSubview:self.header];

    return view;
}
- (UIImageView *)topView {
    if (!_topView) {
        _topView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
        [_topView sd_setImageWithURL:[NSURL URLWithString:@"http://img2.duitang.com/uploads/item/201208/22/20120822155433_ZLnhS.jpeg"]];

    }
    return _topView;
}
- (void)setData {
//    self.tableView.frame=CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
//    [self.tableView addParallaxHeadView:self.topView isTranslucent:self.navigationController.navigationBar.translucent];
    [self.tableView addParallaxHeadView:self.topView];

//    for (int i = 0 ; i < 5; i++) {
        ImageModel *model = [ImageModel new];
        model.imageurl = @"http://img4q.duitang.com/uploads/item/201408/11/20140811141753_iNtAF.jpeg";
        model.width = 1280;
        model.height = 720;
        [self.dataArray addObject:model];
        ImageModel *model1 = [ImageModel new];
        model1.imageurl = @"http://imgsrc.baidu.com/forum/pic/item/8b82b9014a90f603fa18d50f3912b31bb151edca.jpg";
        model1.width = 1280;
        model1.height = 720;
        [_dataArray addObject:model1];
        ImageModel *model2 = [ImageModel new];
        model2.imageurl = @"http://imgsrc.baidu.com/forum/pic/item/8e230cf3d7ca7bcb3acde5a2be096b63f724a8b2.jpg";
        model2.width = 1280;
        model2.height = 720;
        [_dataArray addObject:model2];
        ImageModel *model3 = [ImageModel new];
        model3.imageurl = @"http://att.bbs.duowan.com/forum/201210/20/210446opy9p5pghu015p9u.jpg";
        model3.width = 1280;
        model3.height = 720;
        [_dataArray addObject:model3];
        ImageModel *model4 = [ImageModel new];
        model4.imageurl = @"http://img5.duitang.com/uploads/item/201404/11/20140411214939_XswXa.jpeg";
        model4.width = 1280;
        model4.height = 720;
        [_dataArray addObject:model4];
//    }
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
    return 70;
}
- (UIEdgeInsets)cf_sepEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath {
    return UIEdgeInsetsZero;
}


- (CFBaseTableViewCell *)cf_cellAtIndexPath:(NSIndexPath *)indexPath {

    CFSlideTestCell *cell = [CFSlideTestCell cellWithTableView:self.tableView];
    cell.name = @"可以滑动的cell";
    cell.delegate = self;
    cell.dataSource = self;
    //        cell.cellContentView.backgroundColor = [UIColor lightGrayColor];
    // 加载内容加到这上面。。
    ImageModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.indexPath=indexPath;
    cell.imgDelegate = self;
    [cell.img sd_setImageWithURL:[NSURL URLWithString:model.imageurl]];

    return cell;

    return [[CFBaseTableViewCell alloc] init];
}
#pragma mark - TableCellImgDelegate
-(void)backindexPath:(NSIndexPath *)indexPath{
    indexRow = [indexPath row];
    CFSlideTestCell *cell = (CFSlideTestCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    imageview = cell.img;
    frame_first = CGRectMake(cell.frame.origin.x+imageview.frame.origin.x, cell.frame.origin.y+imageview.frame.origin.y-self.tableView.contentOffset.y, imageview.frame.size.width, imageview.frame.size.height);

    ShowImageController *img = [ShowImageController new];
    img.tableCellSapce = imageview.frame.origin.y*2;
    img.data = self.dataArray;
    img.index = indexRow;
    img.type = 1;
    //动画类型，目前只有2种.0和1
    img.pop_type = 0;
    ImageModel *model = [self.dataArray objectAtIndex:indexRow];
    [img showImageView:frame_first image:imageview.image w:model.width h:model.height];

    [self presentViewController:img animated:NO completion:nil];
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
        [btn setTitle:@"收藏" forState:UIControlStateNormal];
        bgColor = [UIColor redColor];
    } else if (index == 1) {
        [btn setTitle:@"评论" forState:UIControlStateNormal];
        bgColor = [UIColor greenColor];
    } else if (index == 2) {
        [btn setTitle:@"删除" forState:UIControlStateNormal];
        bgColor = [UIColor whiteColor];
    }
    [btn setBackgroundColor:bgColor];
    return btn;
}

- (void)slideOperationViewCell:(CFSlideOperationViewCell *)cell didSelectButtonAtIndex:(NSInteger)index {
    NSLog(@"%@", [NSString stringWithFormat:@"点击了第几%ld个按钮", index]);
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (index==2) {
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

        [self.tableView reloadData];
    }

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
