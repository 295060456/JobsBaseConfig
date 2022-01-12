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

NS_ASSUME_NONNULL_BEGIN

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
@property(nonatomic,strong,nullable)id __block data;//绑定的数据源
@property(nonatomic,strong,nullable)id __block requestParams;//绑定的数据源
@property(nonatomic,strong,nullable)RACSignal __block *reqSignal;
@property(nonatomic,assign)BOOL __block selected;
@property(nonatomic,assign)BOOL __block isMultiLineShows;// 是否多行行显示【默认单行显示】
@property(nonatomic,strong,nullable)NSString __block *internationalizationKEY;/// 国际化的key
@property(nonatomic,assign)BOOL __block isTranslucent;//是否取消tabBar的透明效果
@property(nonatomic,assign)BOOL __block visible;

@end

NS_ASSUME_NONNULL_END
