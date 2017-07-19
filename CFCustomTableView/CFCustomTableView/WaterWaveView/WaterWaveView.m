//
//  WaterWaveView.m
//  WaterWave
//
//  Created by sunhong on 16/6/21.
//  Copyright © 2016年 Sunhong. All rights reserved.
//

#import "WaterWaveView.h"

@interface WaterWaveView ()

@property (nonatomic, strong) CAShapeLayer *firstWaveLayer;//水波
@property (nonatomic, strong) CAShapeLayer *secondWaveLayer;//水波

@property (nonatomic, strong) CADisplayLink *waveDisplaylink; //每帧刷新 定时器
@end

@implementation WaterWaveView{

    CGFloat waterWaveHeight;
    CGFloat waterWaveWidth;
    CGFloat offsetX;
    
    float variable;     //可变参数 更加真实 模拟波纹
    BOOL increase;      // 增减变化
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds  = YES;
        waterWaveHeight = frame.size.height * 0.9;
        waterWaveWidth  = frame.size.width;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds  = YES;
        waterWaveHeight = self.frame.size.height * 0.5;
        waterWaveWidth  = self.frame.size.width;
        
    }
    return self;
}

/**
 *  开始动画
 */
-(void) wave{
    
    if (_firstWaveLayer == nil) {
        _firstWaveLayer = [CAShapeLayer layer];
        _firstWaveLayer.fillColor = [UIColor colorWithRed:0.507 green:0.690 blue:0.957 alpha:1.000].CGColor;
        [self.layer addSublayer:_firstWaveLayer];
    }
    
    if (_secondWaveLayer == nil) {
        _secondWaveLayer = [CAShapeLayer layer];
        _secondWaveLayer.fillColor = [UIColor whiteColor].CGColor;
        [self.layer addSublayer:_secondWaveLayer];
    }
    
    /**
     *  CADisplayLink是一个能让我们以和屏幕刷新率相同的频率将内容画到屏幕上的定时器。
     *  比起NSTimer，CADisplayLink可以确保系统渲染每一帧的时候我们的方法都被调用，从而保证了动画的流畅性。
     *  target 和selector 在屏幕刷新的时候调用
     */
    if (_waveDisplaylink == nil) {
        _waveDisplaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave:)];
        [_waveDisplaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

/**
 *  每帧之后调用该方法
 *
 */
-(void)getCurrentWave:(CADisplayLink *)displayLink{
    
    // 波浪位移
    offsetX += self.waveSpeed;
    
    NSLog(@"waterView.waveAmplitude==%f",self.waveAmplitude);
    if (self.waveAmplitude > 3.0) {
        self.waveAmplitude -= 0.05;
    }
    if (self.waveSpeed > 1.5) {
        self.waveSpeed -= 0.01;
    }
    
    _firstWaveLayer.path = [self getgetCurrentFirstWavePath];
    _secondWaveLayer.path = [self getgetCurrentSecondWavePath];
}

/**
 *  获取新的路径
 *
 */
-(CGPathRef)getgetCurrentFirstWavePath{
    
    UIBezierPath *p = [UIBezierPath bezierPath];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, waterWaveHeight); //初始线段的起点
    CGFloat y = 0.0f;
    for (float x = 0.0f; x <=  waterWaveWidth ; x++) {
        // 正弦波浪公式
        y = self.waveAmplitude* sinf((360/waterWaveWidth) *(x * M_PI / 180) - offsetX * M_PI / 180) + waterWaveHeight;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    
    p.CGPath = path;
    
    return path;
}

- (CGPathRef)getgetCurrentSecondWavePath {
    UIBezierPath *p = [UIBezierPath bezierPath];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, waterWaveHeight); //初始线段的起点
    CGFloat y = 0.0f;
    for (float x = 0.0f; x <=  waterWaveWidth ; x++) {
        // 余弦波浪公式
        y = self.waveAmplitude* cosf((360/waterWaveWidth) *(x * M_PI / 180) - offsetX * M_PI / 180) + waterWaveHeight;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    
    p.CGPath = path;
    
    return path;
}

/**
 *  结束动画
 */
-(void) stop{
    if (_waveDisplaylink) {
        [_waveDisplaylink invalidate];
        _waveDisplaylink = nil;
    }
}

@end
