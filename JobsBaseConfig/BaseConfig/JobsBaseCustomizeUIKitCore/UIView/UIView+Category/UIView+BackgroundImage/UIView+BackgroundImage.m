//
//  UIView+BackgroundImage.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2021/1/22.
//  Copyright © 2021 MonkeyKingVideo. All rights reserved.
//

#import "UIView+BackgroundImage.h"

@implementation UIView (BackgroundImage)

static char *UIView_BackgroundImage_backgroundImageView = "UIView_BackgroundImage_backgroundImageView";
@dynamic backgroundImageView;
/**
 【特别指出】
 如果self 是 诸如UICollectionViewCell 或者UITableViewCell,即：
 存在 self.contentView
 如果上面覆盖一个按钮，则需要[self.contentView addSubview:self.backgroundImageView];
 否则按钮点击事件被截断
 */
-(UIImageView *)backgroundImageView{
    UIImageView *BackgroundImageView = objc_getAssociatedObject(self, UIView_BackgroundImage_backgroundImageView);
    if (!BackgroundImageView) {
        BackgroundImageView = UIImageView.new;
        BackgroundImageView.userInteractionEnabled = YES;
        BackgroundImageView.contentMode = UIViewContentModeScaleToFill;

        if ([self isKindOfClass:UICollectionViewCell.class]) {
            UICollectionViewCell *cell = (UICollectionViewCell *)self;
            [cell.contentView addSubview:BackgroundImageView];
        }else if ([self isKindOfClass:UITableViewCell.class]){
            UITableViewCell *cell = (UITableViewCell *)self;
            [cell.contentView addSubview:BackgroundImageView];
        }else{
            [self addSubview:BackgroundImageView];
        }
        
        BackgroundImageView.layer.zPosition = -1;// 设置层级关系
        
        [BackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        objc_setAssociatedObject(self,
                                 UIView_BackgroundImage_backgroundImageView,
                                 BackgroundImageView,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return BackgroundImageView;
}

-(void)setBackgroundImageView:(UIImageView *)backgroundImageView{
    objc_setAssociatedObject(self,
                             UIView_BackgroundImage_backgroundImageView,
                             backgroundImageView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
