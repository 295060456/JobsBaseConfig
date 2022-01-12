//
//  BaseView.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2021/2/5.
//  Copyright © 2021 MonkeyKingVideo. All rights reserved.
//

#import "BaseView.h"

@interface BaseView ()

@end

@implementation BaseView

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

-(instancetype)init{
    if (self = [super init]) {

    }return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}
#pragma mark —— BaseViewProtocol
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInViewWithModel:(id _Nullable)model{}
/// 具体由子类进行复写【数据定宽】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGFloat)viewWidthWithModel:(id _Nullable)model{
    return 0;
}
/// 具体由子类进行复写【数据定高】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGFloat)viewHeightWithModel:(id _Nullable)model{
    return 0;
}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(id _Nullable)model{
    return CGSizeZero;
}
/// 具体由子类进行复写【数据Frame】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGRect)viewFrameWithModel:(id _Nullable)model{
    return CGRectZero;
}

@end
