//
//  UIViewModel.m
//  Casino
//
//  Created by Jobs on 2021/11/19.
//

#import "UIViewModel.h"

@implementation UIViewModel

#pragma mark —— UIViewModelProtocol
/// 主、副标题文字
@synthesize text = _text;
@synthesize subText = _subText;
@synthesize attributedText = _attributedText;
@synthesize subAttributedText = _subAttributedText;
@synthesize textCor = _textCor;
@synthesize subTextCor = _subTextCor;
@synthesize font = _font;
@synthesize subFont = _subFont;
@synthesize textAlignment = _textAlignment;
@synthesize subTextAlignment = _subTextAlignment;
@synthesize lineBreakMode = _lineBreakMode;
@synthesize subLineBreakMode = _subLineBreakMode;
@synthesize textLineSpacing = _textLineSpacing;
@synthesize subTextlineSpacing = _subTextlineSpacing;
/// 图片和背景颜色
@synthesize image = _image;
@synthesize bgImage = _bgImage;
@synthesize bgImageView = _bgImageView;
@synthesize bgSelectedImage = _bgSelectedImage;
@synthesize imageURLString = _imageURLString;
@synthesize bgImageURLString = _bgImageURLString;
@synthesize bgCor = _bgCor;
/// 方位
@synthesize cornerRadius = _cornerRadius;
@synthesize jobsWidth = _jobsWidth;
@synthesize jobsHeight = _jobsHeight;
@synthesize jobsTop = _jobsTop;
@synthesize jobsLeft = _jobsLeft;
@synthesize jobsRight = _jobsRight;
@synthesize jobsBottom = _jobsBottom;
@synthesize jobsSize = _jobsSize;
@synthesize jobsRect = _jobsRect;
@synthesize jobsPoint = _jobsPoint;
@synthesize offsetXForEach = _offsetXForEach;
@synthesize offsetYForEach = _offsetYForEach;
@synthesize offsetHeight = _offsetHeight;
@synthesize offsetWidth = _offsetWidth;
@synthesize axis = _axis;
@synthesize distribution = _distribution;
@synthesize alignment = _alignment;
/// 标记📌
@synthesize indexPath = _indexPath;
@synthesize section = _section;
@synthesize row = _row;
@synthesize item = _item;
@synthesize lastPoint = _lastPoint;
@synthesize index = _index;
@synthesize currentPage = _currentPage;
@synthesize pageSize = _pageSize;
/// 其他
@synthesize cls = _cls;
@synthesize data = _data;
@synthesize requestParams = _requestParams;
@synthesize reqSignal = _reqSignal;
@synthesize selected = _selected;
@synthesize isMultiLineShows = _isMultiLineShows;
@synthesize internationalizationKEY = _internationalizationKEY;
@synthesize isTranslucent = _isTranslucent;
@synthesize visible = _visible;

#pragma mark —— NTESVerifyCodeManagerProtocol
/// 【功能性】网易云盾回调数据
@synthesize ntesVerifyCodeFinishResult = _ntesVerifyCodeFinishResult;
@synthesize ntesVerifyCodeManagerStyle = _ntesVerifyCodeManagerStyle;
@synthesize ntesVerifyCodeValidate = _ntesVerifyCodeValidate;
@synthesize ntesVerifyCodeMessage = _ntesVerifyCodeMessage;
@synthesize ntesVerifyCodeError = _ntesVerifyCodeError;
@synthesize ntesVerifyCodeClose = _ntesVerifyCodeClose;

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
