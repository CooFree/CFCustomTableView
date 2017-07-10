//
//  CFSlideTestCell.m
//  CFCustomTableView
//
//  Created by YF on 2017/7/6.
//  Copyright © 2017年 CooFree. All rights reserved.
//

#import "CFSlideTestCell.h"

@implementation CFSlideTestCell

- (UILabel *)nameL {
    if (!_nameL) {
        UILabel *label = [[UILabel alloc] init];
        [self.cellContentView addSubview:label];
        _nameL = label;
    }
    return _nameL;
}
- (UIImageView *)img {
    if (!_img) {
        UIImageView *img = [[UIImageView alloc]init];
        img.backgroundColor=[UIColor blueColor];
        img.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onclick:)];
        [img addGestureRecognizer:tap];
        [self.cellContentView addSubview:img];

        _img = img;
    }
    return _img;
}
-(void)onclick:(UITapGestureRecognizer *)tap{
    [_imgDelegate backindexPath:_indexPath];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.img.frame = CGRectMake(15, 5, 60, 60);

    self.nameL.frame = CGRectMake(CGRectGetMaxX(_img.frame)+15, 5, self.cellContentView.frame.size.width-CGRectGetMaxX(_img.frame)-30, self.cellContentView.frame.size.height-10);
}

- (void)setName:(NSString *)name {
    if (name == nil || [name isKindOfClass:[NSNull class]]) {
        return ;
    }
    _name = name.copy;
    self.nameL.text = name;
}

@end
