//
//  WaterWaveViewController.m
//  CFCustomTableView
//
//  Created by YF on 2017/7/19.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "WaterWaveViewController.h"
#import "WaterWaveView.h"

@interface WaterWaveViewController ()
{
    WaterWaveView *waterView;
}
@property (nonatomic, assign) CGFloat       preOffsetX;

@end

@implementation WaterWaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (NSInteger)cf_numberOfRowsInSection:(NSInteger)section {
    return 5;
}
#pragma mark - UIScrollViewDelegate
// 当开始滚动视图时，执行该方法。一次有效滑动（开始滑动，滑动一小段距离，只要手指不松开，只算一次滑动），只执行一次。
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"WillBeginDragging");
    [self setupWaterView];
    [waterView wave];
}

// 滑动视图，当手指离开屏幕那一霎那，调用该方法。一次有效滑动，只执行一次。
// decelerate 手指离开那一瞬后，视图是否还将继续向前滚动（一段距离），经过测试，decelerate=YES
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"DidEndDragging");
    [waterView stop];
    [waterView removeFromSuperview];
    waterView = nil;
}

//scrollView滚动时，就调用该方法。任何offset值改变都调用该方法。即滚动过程中，调用多次
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (waterView == nil) {
        return;
    }
    //改变速度
    CGFloat yOffset = scrollView.contentOffset.y;
    CGFloat interYpiex = yOffset - _preOffsetX;
    _preOffsetX = yOffset;

    CGFloat ratio = fabs(interYpiex);
    CGFloat amplitude = ratio;
    CGFloat waveSpeed = ratio * 0.5;
    /**
     *  当waveAmplitude＝6时，波纹比较明显
     *  当waveAmplitude＝3时，波纹趋于平缓（当手指不移动，或者缓慢移动）
     *  需要随着位移&&滑动速度——》改变波动大小
     */
    //这个判断条件不能距离第一阶段的数值偏远，会造成频率突然降低，波形卡顿的现象
    if (waterView.waveAmplitude > 9.0f) {
        return;
    }
    if (ratio < 9.0f) {
        amplitude = 9.0f;
        waveSpeed = 3.0f;
    } else {
        amplitude = 12.0f;
        waveSpeed = 3.0f;
    }

    //当偏移量较小时，限制振幅，防止振幅过大，遮挡其他空间

    waterView.waveAmplitude = amplitude;
    waterView.waveSpeed = waveSpeed;
}
/**
 *   创建水波纹
 */
- (void)setupWaterView {
    CGFloat xPiex = 0;
    CGFloat height = 100;
    CGFloat yPiex = -height;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGRect waterFrame = CGRectMake(xPiex, yPiex, width, height);

    waterView = [[WaterWaveView alloc]initWithFrame:waterFrame];
    [self.tableView addSubview:waterView];
    //        waterView.layer.cornerRadius  = waterView.frame.size.width / 2;
    waterView.waveSpeed = 3.0f;//根据滑动幅度更改
    waterView.waveAmplitude = 6.0f;//3
}

@end
