//
//  ShowImageController.m
//  CFCustomTableView
//
//  Created by YF on 2017/7/7.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "ShowImageController.h"
#import "ShowImgView.h"

#import "UIImageView+WebCache.h"

#define SCROLLMAR 20
#define COLLECTIONMAR 10
#define MXIMAR 4

@interface ShowImageController ()<UIScrollViewDelegate,ShowImageDelegate>{
    ShowImgView *showimage;
    CGSize bigSize;
    CGSize smallSize;
    UIImageView *imageview;
    CGRect zframe;
    CGRect wyrame;
}

@end

@implementation ShowImageController
@synthesize tableCellSapce;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
}

-(void)initData{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width+SCROLLMAR, self.view.frame.size.height)];
    _scrollView.pagingEnabled=YES;
    _scrollView.delegate=self;
    [self.view addSubview:_scrollView];

    for (int i = 0 ; i < [_data count]; i++) {
     ShowImgView  * showimage = [[ShowImgView alloc]initWithFrame:CGRectMake(_scrollView.frame.size.width*i ,_scrollView.frame.origin.y, _scrollView.frame.size.width -SCROLLMAR,_scrollView.frame.size.height)];
        showimage.model = [_data objectAtIndex:i];
        showimage.delegate = self;
        [_scrollView addSubview:showimage];
    }
    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width* [_data count],_scrollView.frame.size.height)];
    [_scrollView setHidden:YES];
}

-(void)showImageView:(CGRect) initframe image:(UIImage *) image w:(CGFloat )w h :(CGFloat) h{
    if (w == 0) {
        w = 1000;
    }
    if (h == 0) {
        h = 1000;
    }
    CGRect frame = [UIScreen mainScreen].bounds;
    zframe = initframe;
    imageview = [[UIImageView alloc] initWithFrame:initframe];
    imageview.image = image;
    imageview.clipsToBounds = YES;
    imageview.backgroundColor = [UIColor lightGrayColor];
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageview];
    CGFloat iwidth = w;
    CGFloat iheight = h;
    if (iwidth > iheight) {
        CGFloat h = initframe.size.height;
        CGFloat w = iwidth / iheight * h;
        smallSize = CGSizeMake(w, h);
    }else{
        CGFloat w = initframe.size.width;
        CGFloat h = iheight / iwidth * w;
        smallSize = CGSizeMake(w, h);
    }
    if ((frame.size.height / frame.size.width) < (iheight / iwidth)) {
        CGFloat h = frame.size.height;
        CGFloat w = iwidth / iheight * h;
        bigSize = CGSizeMake(w, h);
    }else{
        CGFloat w = frame.size.width;
        CGFloat h = iheight / iwidth * w;
        bigSize = CGSizeMake(w, h);
    }
}

-(void)defaultImage:(CGRect) initframe frame:(CGRect )frame{
    UIImage *mrimg = [UIImage imageNamed:@"default"];
    CGFloat iwidth = mrimg.size.width;
    CGFloat iheight = mrimg.size.height;
    if (iwidth > iheight) {
        CGFloat h = initframe.size.height;
        CGFloat w = iwidth / iheight * h;
        smallSize = CGSizeMake(w, h);
    }else{
        CGFloat w = initframe.size.width;
        CGFloat h = iheight / iwidth * w;
        smallSize = CGSizeMake(w, h);
    }
    if ((frame.size.height / frame.size.width) < (iheight / iwidth)) {
        CGFloat h = frame.size.height;
        CGFloat w = iwidth / iheight * h;
        bigSize = CGSizeMake(w, h);
    }else{
        CGFloat w = frame.size.width;
        CGFloat h = iheight / iwidth * w;
        bigSize = CGSizeMake(w, h);
    }
    mrimg = nil;
}

-(void)goBig{
    //    img.center = CGPointMake(bigSize.width/2.0, bigSize.height/2.0);
    imageview.bounds = CGRectMake(0, 0, bigSize.width, bigSize.height);
    //markwyb隐藏NavBar
    CGFloat d = smallSize.height / bigSize.height;
    if (smallSize.width > smallSize.height) {
        d = smallSize.width / bigSize.width;
    }

    imageview.layer.transform = CATransform3DMakeScale(d, d, 1);
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:d initialSpringVelocity:d options:UIViewAnimationOptionCurveEaseInOut animations:^{
        imageview.layer.transform = CATransform3DIdentity;
    } completion:^(BOOL finished) {
        [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width*_index, 0)];
        [_scrollView setHidden:NO];
        [imageview setHidden:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    if (_pop_type == 1) {
        [self goNewBig];
    }else{
        CGPoint point = self.view.center;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            imageview.center = point;
        } completion:^(BOOL finished) {
            imageview.clipsToBounds = false;
            [self goBig];

        }];
    }
}

-(void)BackOnclick{
    if (_pop_type == 1) {
        [self didNewbig];
    }else{
        [self didbig];
    }
}

-(void)didbig{
    [imageview setHidden:NO];
    [_scrollView setHidden:YES];
    CGFloat d = smallSize.height / bigSize.height;
    if (smallSize.width > smallSize.height) {
        d = smallSize.width / bigSize.width;
    }
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        imageview.layer.transform = CATransform3DMakeScale(d,d,1.0);
        imageview.clipsToBounds = YES;
    } completion:^(BOOL finished) {
        [self goSmall];
    }];
}

-(void)goSmall{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (wyrame.size.width != 0) {
            imageview.frame = wyrame;
        }else{
            imageview.frame = zframe;
        }
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

/*
 *  scrollView代理方法区
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    //    NSUInteger page = [self pageCalWithScrollView:scrollView];
}


//10为图片的间距
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    NSUInteger page = [self pageCalWithScrollView:scrollView];

    ImageModel *model = [_data objectAtIndex:page];
    [imageview sd_setImageWithURL:[NSURL URLWithString:model.imageurl]];
    if (_type == 1) {
        NSInteger cha = page - _index;
        CGFloat y = zframe.origin.y + (cha * (zframe.size.height + tableCellSapce));
        wyrame = CGRectMake(zframe.origin.x, y, zframe.size.width, zframe.size.height);
    }else if(_type == 2){
        NSInteger a1 = _index % 3;
        NSInteger a = page % 3;
        NSInteger chax = a - a1;
        NSInteger b1 = _index /3;
        NSInteger b = page / 3;
        NSInteger chay = b - b1;
        CGFloat x = zframe.origin.x + (chax * (zframe.size.width + COLLECTIONMAR));
        CGFloat y = zframe.origin.y + (chay * (zframe.size.height + COLLECTIONMAR));
        wyrame = CGRectMake(x, y, zframe.size.width, zframe.size.height);
    }else if (_type == 3){
        NSInteger a1 = _index % 3;
        NSInteger a = page % 3;
        NSInteger chax = a - a1;
        NSInteger b1 = _index /3;
        NSInteger b = page / 3;
        NSInteger chay = b - b1;
        CGFloat x = zframe.origin.x + (chax * (zframe.size.width + MXIMAR));
        CGFloat y = zframe.origin.y + (chay * (zframe.size.height + MXIMAR));
        wyrame = CGRectMake(x, y, zframe.size.width, zframe.size.height);
    }else if (_type == 4){
        NSInteger a1 = _index % 2;
        NSInteger a = page % 2;
        NSInteger chax = a - a1;
        NSInteger b1 = _index /2;
        NSInteger b = page / 2;
        NSInteger chay = b - b1;
        CGFloat x = zframe.origin.x + (chax * (zframe.size.width + MXIMAR));
        CGFloat y = zframe.origin.y + (chay * (zframe.size.height + MXIMAR));
        wyrame = CGRectMake(x, y, zframe.size.width, zframe.size.height);
    }
}

-(NSUInteger)pageCalWithScrollView:(UIScrollView *)scrollView{

    NSUInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width + .5f;

    return page;
}

-(void)goNewBig{
    imageview.clipsToBounds = YES;
}

-(void)didNewbig{
    [_scrollView setHidden:YES];
    [imageview setHidden:NO];
    imageview.clipsToBounds = YES;
}

@end
