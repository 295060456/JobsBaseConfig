//
//  JobsLabBaseModel.h
//  Casino
//
//  Created by Jobs on 2021/12/16.
//

#import "UIViewModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSInteger {
    /// 以头部或者左边为对齐基准
    JobsUpDownLabAlign_TopLeft = 0,
    /// 以中心线为对齐基准
    JobsUpDownLabAlign_MiddleLine,
    /// 以底部或者右边为对齐基准
    JobsUpDownLabAlign_BottomRight,
} JobsUpDownLabAlign;// JobsUpDownLabStyle的对齐基准

@interface JobsLabBaseModel : UIViewModel

@property(nonatomic,assign)CGFloat rate;// UpLab 和 DownLab的上下占比,默认为0.5（上下均等分）
@property(nonatomic,assign)CGFloat space;// 间距 【当对齐基准为JobsUpDownLabAlign_MiddleLine失效】
@property(nonatomic,assign)JobsUpDownLabAlign upLabVerticalAlign;// 上控件的垂直对齐基准
@property(nonatomic,assign)JobsUpDownLabAlign upLabLevelAlign;// 上控件的水平对齐基准
@property(nonatomic,assign)JobsUpDownLabAlign downLabVerticalAlign;// 下控件的垂直对齐基准
@property(nonatomic,assign)JobsUpDownLabAlign downLabLevelAlign;// 下控件的水平对齐基准
#pragma mark —— UpLab / LeftLab
@property(nonatomic,strong)UIColor *upLabTextCor;
@property(nonatomic,strong)UIColor *upLabBgCor;
@property(nonatomic,strong)UIFont *upLabFont;
@property(nonatomic,strong)NSString *upLabText;
@property(nonatomic,strong)UIImage *upLabImage;
@property(nonatomic,strong)UIImage *upLabBgImage;
@property(nonatomic,assign)NSTextAlignment upLabTextAlignment;
@property(nonatomic,assign)NSLineBreakMode upLabLineBreakMode;
@property(nonatomic,strong)NSAttributedString *upLabAttributedText;
//SuppressWdeprecatedDeclarationsWarning
@property(nonatomic)UIEdgeInsets upLabContentEdgeInsets API_DEPRECATED("This property is ignored when using UIButtonConfiguration", ios(2.0,15.0), tvos(2.0,15.0)) UI_APPEARANCE_SELECTOR; // default is UIEdgeInsetsZero. On tvOS 10 or later, default is nonzero except for custom buttons.
@property(nonatomic)UIEdgeInsets upLabTitleEdgeInsets API_DEPRECATED("This property is ignored when using UIButtonConfiguration", ios(2.0,15.0), tvos(2.0,15.0));                // default is UIEdgeInsetsZero
@property(nonatomic)UIEdgeInsets upLabImageEdgeInsets API_DEPRECATED("This property is ignored when using UIButtonConfiguration", ios(2.0,15.0), tvos(2.0,15.0));                // default is UIEdgeInsetsZero
@property(nonatomic,assign)BOOL isUpLabMultiLineShows;// 是否多行行显示【默认单行显示】
#pragma mark —— DownLab / RightLab
@property(nonatomic,strong)UIColor *downLabTextCor;
@property(nonatomic,strong)UIColor *downLabBgCor;
@property(nonatomic,strong)UIFont *downLabFont;
@property(nonatomic,strong)NSString *downLabText;
@property(nonatomic,strong)UIImage *downLabImage;
@property(nonatomic,strong)UIImage *downLabBgImage;
@property(nonatomic,assign)NSTextAlignment downLabTextAlignment;
@property(nonatomic,assign)NSLineBreakMode downLabLineBreakMode;
@property(nonatomic,strong)NSAttributedString *downLabAttributedText;
//SuppressWdeprecatedDeclarationsWarning
@property(nonatomic)UIEdgeInsets downLabContentEdgeInsets API_DEPRECATED("This property is ignored when using UIButtonConfiguration", ios(2.0,15.0), tvos(2.0,15.0)) UI_APPEARANCE_SELECTOR; // default is UIEdgeInsetsZero. On tvOS 10 or later, default is nonzero except for custom buttons.
@property(nonatomic)UIEdgeInsets downLabTitleEdgeInsets API_DEPRECATED("This property is ignored when using UIButtonConfiguration", ios(2.0,15.0), tvos(2.0,15.0));                // default is UIEdgeInsetsZero
@property(nonatomic)UIEdgeInsets downLabImageEdgeInsets API_DEPRECATED("This property is ignored when using UIButtonConfiguration", ios(2.0,15.0), tvos(2.0,15.0));                // default is UIEdgeInsetsZero
@property(nonatomic,assign)BOOL isDownLabMultiLineShows;// 是否多行行显示【默认单行显示】。如需多行显示，字符串内需要添加换行符，例如：@"開啟手勢密碼，系統將默認記住您的賬戶密碼\n進入免登陸狀態"

@end

NS_ASSUME_NONNULL_END
