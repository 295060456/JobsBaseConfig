//
//  PagingViewTableHeaderView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "PagingViewTableHeaderView.h"

@interface PagingViewTableHeaderView()

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,assign)CGRect imageViewFrame;

@end

@implementation PagingViewTableHeaderView

static dispatch_once_t dispatchOnce;
-(instancetype)init{
    if (self = [super init]) {
        dispatchOnce = 0;
    }return self;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    dispatch_once(&dispatchOnce, ^{
        self.imageView.alpha = 1;
    });
}

- (void)scrollViewDidScroll:(CGFloat)contentOffsetY {
    if (self.isZoom) {
        CGRect frame = self.imageViewFrame;
        frame.size.height -= contentOffsetY;
        frame.origin.y = contentOffsetY;
        self.imageView.frame = frame;
    }
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = UIImageView.new;
        _imageView.image = KIMG(@"lufei.jpg");
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
        if (self.isZoom) {
            _imageView.frame = CGRectMake(0, 0, self.mj_w, self.mj_h);
            self.imageViewFrame = _imageView.frame;
        }else{
            [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
        }
    }return _imageView;
}

@end
