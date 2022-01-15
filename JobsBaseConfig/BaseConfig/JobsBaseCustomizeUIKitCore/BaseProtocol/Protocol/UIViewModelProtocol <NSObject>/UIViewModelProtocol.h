//
//  UIViewModelProtocol.h
//  Casino
//
//  Created by Jobs on 2022/1/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "MacroDef_App.h"
#import "MacroDef_Cor.h"
#import "MacroDef_Size.h"
#import "UIImage+Extras.h"

#if __has_include(<ReactiveObjC/ReactiveObjC.h>)
#import <ReactiveObjC/ReactiveObjC.h>
#else
#import "ReactiveObjC.h"
#endif

@class UIViewModel;

NS_ASSUME_NONNULL_BEGIN
/// 全局的共用的属性
@protocol UIViewModelProtocol <NSObject>

@optional
/// 主、副标题文字
@property(nonatomic,strong,nullable)NSString __block *text;//主文字内容
@property(nonatomic,strong,nullable)NSString __block *subText;//副文字内容
@property(nonatomic,strong,nullable)NSAttributedString __block *attributedText API_AVAILABLE(ios(6.0));//主文字富文本
@property(nonatomic,strong,nullable)NSAttributedString __block *subAttributedText API_AVAILABLE(ios(6.0));//副文字富文本
@property(nonatomic,strong,nullable)UIColor __block *textCor;//主字体颜色
@property(nonatomic,strong,nullable)UIColor __block *subTextCor;//副字体颜色
@property(nonatomic,strong,nullable)UIFont __block *font;//主文字字体
@property(nonatomic,strong,nullable)UIFont __block *subFont;//副文字字体
@property(nonatomic,assign)NSTextAlignment __block textAlignment;//主文字对齐方式
@property(nonatomic,assign)NSTextAlignment __block subTextAlignment;//副文字对齐方式
@property(nonatomic,assign)NSLineBreakMode __block lineBreakMode;//主文字提行方式
@property(nonatomic,assign)NSLineBreakMode __block subLineBreakMode;//副文字提行方式
@property(nonatomic,assign)CGFloat __block textLineSpacing;
@property(nonatomic,assign)CGFloat __block subTextlineSpacing;
/// 图片和背景颜色
@property(nonatomic,strong,nullable)UIImage __block *image;//图片
@property(nonatomic,strong,nullable)UIImage __block *bgImage;//selected == NO，状态下的背景图片
@property(nonatomic,strong,nullable)UIImageView __block *bgImageView;
@property(nonatomic,strong,nullable)UIImage __block *bgSelectedImage;//selected == YES，状态下的背景图片
@property(nonatomic,strong,nullable)NSString __block *imageURLString;//图片URL(字符串形式)
@property(nonatomic,strong,nullable)NSString __block *bgImageURLString;//背景图片URL(字符串形式)
@property(nonatomic,strong,nullable)UIColor __block *bgCor;//背景颜色
/// 方位
@property(nonatomic,assign)CGFloat __block cornerRadius;//圆切角
@property(nonatomic,assign)CGFloat __block jobsWidth;//宽
@property(nonatomic,assign)CGFloat __block jobsHeight;//高
@property(nonatomic,assign)CGFloat __block jobsTop;
@property(nonatomic,assign)CGFloat __block jobsLeft;
@property(nonatomic,assign)CGFloat __block jobsRight;
@property(nonatomic,assign)CGFloat __block jobsBottom;
@property(nonatomic,assign)CGSize __block jobsSize;//二维尺寸
@property(nonatomic,assign)CGRect __block jobsRect;
@property(nonatomic,assign)CGPoint __block jobsPoint;
@property(nonatomic,assign)CGFloat __block offsetXForEach;//控件之间的左右距离 offsetXForEach
@property(nonatomic,assign)CGFloat __block offsetYForEach;//控件之间的垂直距离 offsetYForEach
@property(nonatomic,assign)CGFloat __block offsetHeight;
@property(nonatomic,assign)CGFloat __block offsetWidth;
@property(nonatomic,assign)UILayoutConstraintAxis axis;
@property(nonatomic,assign)UIStackViewDistribution distribution;
@property(nonatomic,assign)UIStackViewAlignment alignment;
/// 标记📌
@property(nonatomic,strong,nullable)NSIndexPath __block *indexPath;
@property(nonatomic,assign)NSInteger __block section;
@property(nonatomic,assign)NSInteger __block row;
@property(nonatomic,assign)NSInteger __block item;
@property(nonatomic,assign)CGPoint __block lastPoint;
@property(nonatomic,assign)NSInteger __block index;
@property(nonatomic,assign)NSInteger __block currentPage;//网路请求分页数据的时候的当前页码
@property(nonatomic,assign)NSInteger __block pageSize;
/// 其他
@property(nonatomic,strong,nullable)Class __block cls;//绑定的class
@property(nonatomic,strong,nullable)UIViewModel __block *viewModel;
@property(nonatomic,strong,nullable)NSMutableArray <UIViewModel *> __block *viewModelMutArr;
@property(nonatomic,strong,nullable)RACSignal __block *reqSignal;
@property(nonatomic,strong,nullable)NSString __block *internationalizationKEY;/// 国际化的key
@property(nonatomic,strong,nullable)id __block data;//绑定的数据源
@property(nonatomic,strong,nullable)id __block requestParams;//绑定的数据源
@property(nonatomic,assign)BOOL __block selected;
@property(nonatomic,assign)BOOL __block isMultiLineShows;// 是否多行行显示【默认单行显示】
@property(nonatomic,assign)BOOL __block isTranslucent;//是否取消tabBar的透明效果
@property(nonatomic,assign)BOOL __block visible;

@end

NS_ASSUME_NONNULL_END

#pragma mark —— @synthesize UIViewModelProtocol
#ifndef UIViewModelProtocol_synthesize
#define UIViewModelProtocol_synthesize \
\
@synthesize text = _text;\
@synthesize subText = _subText;\
@synthesize attributedText = _attributedText;\
@synthesize subAttributedText = _subAttributedText;\
@synthesize textCor = _textCor;\
@synthesize subTextCor = _subTextCor;\
@synthesize font = _font;\
@synthesize subFont = _subFont;\
@synthesize textAlignment = _textAlignment;\
@synthesize subTextAlignment = _subTextAlignment;\
@synthesize lineBreakMode = _lineBreakMode;\
@synthesize subLineBreakMode = _subLineBreakMode;\
@synthesize textLineSpacing = _textLineSpacing;\
@synthesize subTextlineSpacing = _subTextlineSpacing;\
\
@synthesize image = _image;\
@synthesize bgImage = _bgImage;\
@synthesize bgImageView = _bgImageView;\
@synthesize bgSelectedImage = _bgSelectedImage;\
@synthesize imageURLString = _imageURLString;\
@synthesize bgImageURLString = _bgImageURLString;\
@synthesize bgCor = _bgCor;\
\
@synthesize cornerRadius = _cornerRadius;\
@synthesize jobsWidth = _jobsWidth;\
@synthesize jobsHeight = _jobsHeight;\
@synthesize jobsTop = _jobsTop;\
@synthesize jobsLeft = _jobsLeft;\
@synthesize jobsRight = _jobsRight;\
@synthesize jobsBottom = _jobsBottom;\
@synthesize jobsSize = _jobsSize;\
@synthesize jobsRect = _jobsRect;\
@synthesize jobsPoint = _jobsPoint;\
@synthesize offsetXForEach = _offsetXForEach;\
@synthesize offsetYForEach = _offsetYForEach;\
@synthesize offsetHeight = _offsetHeight;\
@synthesize offsetWidth = _offsetWidth;\
@synthesize axis = _axis;\
@synthesize distribution = _distribution;\
@synthesize alignment = _alignment;\
\
@synthesize indexPath = _indexPath;\
@synthesize section = _section;\
@synthesize row = _row;\
@synthesize item = _item;\
@synthesize lastPoint = _lastPoint;\
@synthesize index = _index;\
@synthesize currentPage = _currentPage;\
@synthesize pageSize = _pageSize;\
\
@synthesize cls = _cls;\
@synthesize viewModel = _viewModel;\
@synthesize viewModelMutArr = _viewModelMutArr;\
@synthesize reqSignal = _reqSignal;\
@synthesize internationalizationKEY = _internationalizationKEY;\
@synthesize data = _data;\
@synthesize requestParams = _requestParams;\
@synthesize selected = _selected;\
@synthesize isMultiLineShows = _isMultiLineShows;\
@synthesize isTranslucent = _isTranslucent;\
@synthesize visible = _visible;\

#endif

#pragma mark —— @dynamic UIViewModelProtocol
#ifndef UIViewModelProtocol_dynamic
#define UIViewModelProtocol_dynamic \
@dynamic text;\
@dynamic subText;\
@dynamic attributedText;\
@dynamic subAttributedText;\
@dynamic textCor;\
@dynamic subTextCor;\
@dynamic font;\
@dynamic subFont;\
@dynamic textAlignment;\
@dynamic subTextAlignment;\
@dynamic lineBreakMode;\
@dynamic subLineBreakMode;\
@dynamic textLineSpacing;\
@dynamic subTextlineSpacing;\
\
@dynamic image;\
@dynamic bgImage;\
@dynamic bgImageView;\
@dynamic bgSelectedImage;\
@dynamic imageURLString;\
@dynamic bgImageURLString;\
@dynamic bgCor;\
\
@dynamic cornerRadius;\
@dynamic jobsWidth;\
@dynamic jobsHeight;\
@dynamic jobsTop;\
@dynamic jobsLeft;\
@dynamic jobsRight;\
@dynamic jobsBottom;\
@dynamic jobsSize;\
@dynamic jobsRect;\
@dynamic jobsPoint;\
@dynamic offsetXForEach;\
@dynamic offsetYForEach;\
@dynamic offsetHeight;\
@dynamic offsetWidth;\
@dynamic axis;\
@dynamic distributio;\
@dynamic alignment;\
\
@dynamic indexPath;\
@dynamic section;\
@dynamic rowp;\
@dynamic item;\
@dynamic lastPoint;\
@dynamic index;\
@dynamic currentPage;\
@dynamic pageSize;\
\
@dynamic cls;\
@dynamic viewModel;\
@dynamic viewModelMutArr;\
@dynamic reqSignal;\
@dynamic internationalizationKEY;\
@dynamic data;\
@dynamic requestParams;\
@dynamic selected;\
@dynamic isMultiLineShows;\
@dynamic isTranslucent;\
@dynamic visible;\

#endif

