//
//  TMSWalletCollectionReusableView.m
//  TMSWalletCollectionViewLayout
//
//  Created by TmmmS on 2019/8/8.
//  Copyright © 2019 TMS. All rights reserved.
//

#import "TMSWalletCollectionReusableView.h"

@interface TMSWalletCollectionReusableView ()

@property(nonatomic,strong)UILabel *label;

@end

@implementation TMSWalletCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = JobsBlueColor;
        self.label.alpha = 1;
    }return self;
}

- (void)setReusableViewTitle:(NSString *)title {
    self.label.text = title;
}
#pragma mark —— lazyLoad
-(UILabel *)label{
    if (!_label) {
        _label = UILabel.new;
        _label.font = UIFontWeightRegularSize(14);
        [self addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.centerY.equalTo(self);
        }];
    }return _label;
}

@end
