//
//  UIViewModelProtocol.h
//  Casino
//
//  Created by Jobs on 2022/1/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "JobsLabelDef.h"
#import "MacroDef_App.h"
#import "MacroDef_Cor.h"
#import "MacroDef_Size.h"
#import "MacroDef_Func.h"
#import "UIImage+Extras.h"

#if __has_include(<ReactiveObjC/ReactiveObjC.h>)
#import <ReactiveObjC/ReactiveObjC.h>
#else
#import "ReactiveObjC.h"
#endif

@class UIViewModel;
@class UITextModel;

NS_ASSUME_NONNULL_BEGIN
/// 全局的共用的属性
@protocol UIViewModelProtocol <NSObject>

@optional
#pragma mark —— 文字配置
@property(nonatomic,strong,nullable)UITextModel *textModel;
@property(nonatomic,strong,nullable)UITextModel *subTextModel;
@property(nonatomic,strong,nullable)UITextModel *backBtnTitleModel;
#pragma mark —— 图片和背景颜色
/// 选中状态
@property(nonatomic,strong,nullable)UIImage __block *selectedImage;///【选中状态】图片
@property(nonatomic,strong,nullable)UIImage __block *bgSelectedImage;///【选中状态】背景图片
@property(nonatomic,strong,nullable)NSString __block *selectedImageURLString;///【选中状态】图片URL(字符串形式)
@property(nonatomic,strong,nullable)NSString __block *bgSelectedImageURLString;///【选中状态】背景图片URL(字符串形式)
@property(nonatomic,strong,nullable)UIColor __block *bgSelectedCor;///【选中状态】背景颜色
@property(nonatomic,strong,nullable)UIImage __block *backBtnSelectedIMG;///【选中状态】返回按钮的图标
/// 未选中状态
@property(nonatomic,strong,nullable)UIImage __block *image;///【未选中状态】图片
@property(nonatomic,strong,nullable)UIImage __block *bgImage;///【未选中状态】背景图片
@property(nonatomic,strong,nullable)NSString __block *imageURLString;///【未选中状态】图片URL(字符串形式)
@property(nonatomic,strong,nullable)NSString __block *bgImageURLString;///【未选中状态】背景图片URL(字符串形式)
@property(nonatomic,strong,nullable)UIColor __block *bgCor;///【未选中状态】背景颜色
@property(nonatomic,strong,nullable)UIImage __block *backBtnIMG;///【未选中状态】返回按钮的图标
/// UI 控件
@property(nonatomic,strong,nullable)UIImageView __block *bgImageView;
#pragma mark —— 方位
@property(nonatomic,assign)CGFloat __block cornerRadius;/// 圆切角（全角）
@property(nonatomic,assign)UIRectCorner __block rectCorner;/// 设置切哪个直角
@property(nonatomic,assign)CGSize __block cornerRadii;/// 设置切哪个直角的切角矩形
@property(nonatomic,assign)CGFloat __block jobsWidth;/// 宽
@property(nonatomic,assign)CGFloat __block jobsHeight;/// 高
@property(nonatomic,assign)CGFloat __block jobsTop;
@property(nonatomic,assign)CGFloat __block jobsLeft;
@property(nonatomic,assign)CGFloat __block jobsRight;
@property(nonatomic,assign)CGFloat __block jobsBottom;
@property(nonatomic,assign)CGSize __block jobsSize;/// 二维尺寸
@property(nonatomic,assign)CGRect __block jobsRect;
@property(nonatomic,assign)CGPoint __block jobsPoint;
@property(nonatomic,assign)CGFloat __block offsetXForEach;/// 控件之间的左右距离 offsetXForEach
@property(nonatomic,assign)CGFloat __block offsetYForEach;/// 控件之间的垂直距离 offsetYForEach
@property(nonatomic,assign)CGFloat __block offsetHeight;
@property(nonatomic,assign)CGFloat __block offsetWidth;
@property(nonatomic,assign)UILayoutConstraintAxis axis;
@property(nonatomic,assign)UIStackViewDistribution distribution;
@property(nonatomic,assign)UIStackViewAlignment alignment;
#pragma mark —— 标记📌
@property(nonatomic,strong,nullable)NSIndexPath __block *indexPath;
@property(nonatomic,assign)NSInteger __block section;
@property(nonatomic,assign)NSInteger __block row;
@property(nonatomic,assign)NSInteger __block item;
@property(nonatomic,assign)CGPoint __block lastPoint;
@property(nonatomic,assign)NSInteger __block index;
@property(nonatomic,assign)NSInteger __block currentPage;/// 网路请求分页数据的时候的当前页码
@property(nonatomic,assign)NSInteger __block pageSize;
#pragma mark —— 其他
@property(nonatomic,strong,nullable)Class __block cls;/// 绑定的class
@property(nonatomic,strong,nullable)UIViewModel __block *viewModel;
@property(nonatomic,strong,nullable)NSMutableArray <UIViewModel *> __block *viewModelMutArr;
@property(nonatomic,strong,nullable)RACSignal __block *reqSignal;
@property(nonatomic,strong,nullable)NSString __block *internationalizationKEY;/// 国际化的key
@property(nonatomic,strong,nullable)id __block data;/// 绑定的数据源
@property(nonatomic,strong,nullable)id __block requestParams;/// 绑定的数据源
@property(nonatomic,assign)BOOL __block selected;
@property(nonatomic,assign)BOOL __block isMultiLineShows;/// 是否多行行显示【默认单行显示】
@property(nonatomic,assign)BOOL __block isTranslucent;/// 是否取消tabBar的透明效果
@property(nonatomic,assign)BOOL __block visible;
@property(nonatomic,strong,nullable)UIColor __block *layerBorderColour;
@property(nonatomic,assign)CGFloat layerBorderWidth;
@property(nonatomic,assign)UILabelShowingType labelShowingType;

@end

NS_ASSUME_NONNULL_END

#pragma mark —— @synthesize UIViewModelProtocol
#ifndef UIViewModelProtocol_synthesize
#define UIViewModelProtocol_synthesize \
\
@synthesize textModel = _textModel;\
@synthesize subTextModel = _subTextModel;\
@synthesize backBtnTitleModel = _backBtnTitleModel;\
\
@synthesize selectedImage = _selectedimage;\
@synthesize bgSelectedImage = _bgSelectedImage;\
@synthesize selectedImageURLString = _selectedImageURLString;\
@synthesize bgSelectedImageURLString = _bgSelectedImageURLString;\
@synthesize bgSelectedCor = _bgSelectedCor;\
@synthesize backBtnSelectedIMG = _backBtnSelectedIMG;\
@synthesize image = _image;\
@synthesize bgImage = _bgImage;\
@synthesize imageURLString = _imageURLString;\
@synthesize bgImageURLString = _bgImageURLString;\
@synthesize bgCor = _bgCor;\
@synthesize backBtnIMG = _backBtnIMG;\
@synthesize bgImageView = _bgImageView;\
\
@synthesize cornerRadius = _cornerRadius;\
@synthesize rectCorner = _rectCorner;\
@synthesize cornerRadii = _cornerRadii;\
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
@synthesize layerBorderColour = _layerBorderColour;\
@synthesize layerBorderWidth = _layerBorderWidth;\
@synthesize labelShowingType = _labelShowingType;\

#endif

#pragma mark —— @dynamic UIViewModelProtocol
#ifndef UIViewModelProtocol_dynamic
#define UIViewModelProtocol_dynamic \
@dynamic textModel;\
@dynamic subTextModel;\
@dynamic backBtnTitleModel;\
\
@dynamic selectedImage;\
@dynamic bgSelectedImage;\
@dynamic selectedImageURLString;\
@dynamic bgSelectedImageURLString;\
@dynamic bgSelectedCor;\
@dynamic backBtnSelectedIMG;\
@dynamic image;\
@dynamic bgImage;\
@dynamic imageURLString;\
@dynamic bgImageURLString;\
@dynamic bgCor;\
@dynamic backBtnIMG;\
@dynamic bgImageView;\
\
@dynamic cornerRadius;\
@dynamic rectCorner;\
@dynamic cornerRadii;\
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
@dynamic layerBorderColour;\
@dynamic layerBorderWidth;\
@dynamic labelShowingType;\

#endif

