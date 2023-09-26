//
//  DDPostDelView.m
//  DouDong-II
//
//  Created by Jobs on 2021/1/1.
//

#import "DDPostDelView.h"

@interface DDPostDelView ()
/// UI
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIImageView *imageView;
/// Data

@end

@implementation DDPostDelView

-(void)richElementsInViewWithModel:(NSNumber *)model{
    self.backgroundColor = JobsRedColor;
    self.imageView.highlighted = model;
    self.imageView.image = model.boolValue ? JobsIMG(@"hx_photo_edit_trash_open") : JobsIMG(@"hx_photo_edit_trash_close");
    self.titleLab.text = model.boolValue ? Internationalization(@"松手即可删除") : Internationalization(@"拖动到此处删除");
}
#pragma mark —— lazyLoad
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = UIImageView.new;
        _imageView.image = JobsIMG(@"hx_photo_edit_trash_close");
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(20), JobsWidth(20)));
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(JobsWidth(5));
        }];
    }return _imageView;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.backgroundColor = JobsRedColor;
        _titleLab.text = Internationalization(@"拖动到此处删除");
        _titleLab.textColor = JobsWhiteColor;
        _titleLab.textAlignment = NSTextAlignmentCenter;
//        _detailTextLab.font =
        [_titleLab sizeToFit];
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageView.mas_bottom).offset(JobsWidth(5));
            make.centerX.equalTo(self);
        }];
    }return _titleLab;
}

@end
