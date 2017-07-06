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

- (void)layoutSubviews {
    [super layoutSubviews];
    self.nameL.frame = self.cellContentView.bounds;
}

- (void)setName:(NSString *)name {
    if (name == nil || [name isKindOfClass:[NSNull class]]) {
        return ;
    }
    _name = name.copy;
    self.nameL.text = name;
}

@end
