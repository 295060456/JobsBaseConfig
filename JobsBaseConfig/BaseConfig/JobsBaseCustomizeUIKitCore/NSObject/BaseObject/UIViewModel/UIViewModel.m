//
//  UIViewModel.m
//  Casino
//
//  Created by Jobs on 2021/11/19.
//

#import "UIViewModel.h"

@implementation UIViewModel

#pragma mark —— UIViewModelProtocol
UIViewModelProtocol_synthesize
#pragma mark —— NTESVerifyCodeManagerProtocol
/// 【功能性】网易云盾回调数据
NTESVerifyCodeManagerProtocol_synthesize

#pragma mark —— lazyLoad
-(UIColor *)textCor{
    if (!_textCor) {
        _textCor = RGB_SAMECOLOR(51);
    }return _textCor;
}

-(UIColor *)subTextCor{
    if (!_subTextCor) {
        _subTextCor = RGB_SAMECOLOR(88);
    }return _subTextCor;
}

-(UIColor *)bgCor{
    if (!_bgCor) {
        _bgCor = RandomColor;
    }return _bgCor;
}

-(UIFont *)font{
    if (!_font) {
        _font = [UIFont systemFontOfSize:JobsWidth(12) weight:UIFontWeightRegular];
    }return _font;
}

-(NSString *)text{
    if (!_text) {
        _text = @"主文字默认占位内容";
    }return _text;
}

-(NSString *)subText{
    if (!_subText) {
        _subText = @"副文字默认占位内容";
    }return _subText;
}

-(UIImage *)image{
    if (!_image) {
//        _image = [UIImage imageWithColor:RandomColor];
    }return _image;
}

-(UIImage *)bgImage{
    if (!_bgImage) {
//        _bgImage = [UIImage imageWithColor:RandomColor];
    }return _bgImage;
}

-(CGFloat)cornerRadius{
    if (!_cornerRadius) {
        _cornerRadius = 3;
    }return _cornerRadius;
}

-(CGFloat)width{
    if (_jobsWidth == 0 && !CGSizeEqualToSize(self.jobsSize, CGSizeZero)) {
        _jobsWidth = self.jobsSize.width;
    }return _jobsWidth;
}

-(CGFloat)height{
    if (_jobsHeight == 0 && !CGSizeEqualToSize(self.jobsSize, CGSizeZero)) {
        _jobsHeight = self.jobsSize.height;
    }return _jobsHeight;
}

-(CGFloat)offsetXForEach{
    if (_offsetXForEach == 0) {
        _offsetXForEach = 8;
    }return _offsetXForEach;
}

-(CGFloat)offsetYForEach{
    if (_offsetYForEach == 0) {
        _offsetYForEach = 8;
    }return _offsetYForEach;
}

-(NSIndexPath *)indexPath{
    if (!_indexPath) {
        _indexPath = [NSIndexPath indexPathForRow:self.row
                                        inSection:self.section];
    }return _indexPath;
}

@end
