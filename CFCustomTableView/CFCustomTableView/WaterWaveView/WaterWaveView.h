//
//  WaterWaveView.h
//  WaterWave
//
//  Created by sunhong on 16/6/21.
//  Copyright © 2016年 Sunhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterWaveView : UIView

/**
 *  The speed of wave 波浪的快慢
 */
@property (nonatomic,assign)CGFloat waveSpeed;

/**
 *  The amplitude of wave 波浪的震荡幅度
 */
@property (nonatomic,assign)CGFloat waveAmplitude; // 波浪的震荡幅度

/**
 *  Start waving
 */
-(void) wave;

/**
 *  Stop waving
 */
-(void) stop;

@end
