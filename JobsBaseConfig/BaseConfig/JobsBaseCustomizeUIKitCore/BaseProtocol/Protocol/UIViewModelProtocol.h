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

NS_ASSUME_NONNULL_BEGIN

@protocol UIViewModelProtocol <NSObject>

@optional

/// 主、副标题文字
@property(nonatomic,strong)NSString *text;//主文字内容
@property(nonatomic,strong)NSString *subText;//副文字内容
@property(nonatomic,strong)NSAttributedString *attributedText API_AVAILABLE(ios(6.0));//主文字富文本
@property(nonatomic,strong)NSAttributedString *subAttributedText API_AVAILABLE(ios(6.0));//副文字富文本
@property(nonatomic,strong)UIColor *textCor;//主字体颜色
@property(nonatomic,strong)UIColor *subTextCor;//副字体颜色
@property(nonatomic,strong)UIFont *font;//主文字字体
@property(nonatomic,strong)UIFont *subFont;//副文字字体
@property(nonatomic,assign)NSTextAlignment textAlignment;//主文字对齐方式
@property(nonatomic,assign)NSTextAlignment subTextAlignment;//副文字对齐方式
@property(nonatomic,assign)NSLineBreakMode lineBreakMode;//主文字提行方式
@property(nonatomic,assign)NSLineBreakMode subLineBreakMode;//副文字提行方式
@property(nonatomic,assign)CGFloat textLineSpacing;
@property(nonatomic,assign)CGFloat subTextlineSpacing;
/// 图片和背景颜色
@property(nonatomic,strong)UIImage *image;//图片
@property(nonatomic,strong)UIImage *bgImage;//selected == NO，状态下的背景图片
@property(nonatomic,strong)UIImage *bgSelectedImage;//selected == YES，状态下的背景图片
@property(nonatomic,strong)NSString *imageURLString;//图片URL(字符串形式)
@property(nonatomic,strong)NSString *bgImageURLString;//背景图片URL(字符串形式)
@property(nonatomic,strong)UIColor *bgCor;//背景颜色
/// Size
@property(nonatomic,assign)CGFloat cornerRadius;//圆切角
@property(nonatomic,assign)CGFloat width;//宽
@property(nonatomic,assign)CGFloat height;//高
@property(nonatomic,assign)CGSize size;//二维尺寸
@property(nonatomic,assign)CGFloat offsetXForEach;//控件之间的左右距离
@property(nonatomic,assign)CGFloat offsetYForEach;//控件之间的上下距离
@property(nonatomic,assign)CGFloat offsetHeight;
@property(nonatomic,assign)CGFloat offsetWidth;
@property(nonatomic,assign)BOOL isTranslucent;//是否取消tabBar的透明效果
/// 标记📌
@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,assign)NSInteger section;
@property(nonatomic,assign)NSInteger row;
@property(nonatomic,assign)NSInteger item;
/// 其他
@property(nonatomic,strong)Class cls;//绑定的class
@property(nonatomic,strong)id data;//绑定的数据源
@property(nonatomic,assign)BOOL selected;
@property(nonatomic,assign)BOOL isMultiLineShows;// 是否多行行显示【默认单行显示】

@end

NS_ASSUME_NONNULL_END
