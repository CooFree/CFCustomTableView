//
//  ShowImgView.h
//  CFCustomTableView
//
//  Created by YF on 2017/7/8.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageModel.h"

@protocol ShowImageDelegate <NSObject>

-(void)BackOnclick;

@end

@interface ShowImgView : UIView<UIScrollViewDelegate>

@property (strong, nonatomic)  UIScrollView *scrollview;
@property (strong, nonatomic) ImageModel *model;
@property (strong ,nonatomic) UIImageView *imageView;
@property (weak, nonatomic) id<ShowImageDelegate> delegate;


@end
