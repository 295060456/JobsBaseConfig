//
//  NSObject+AppTools.h
//  DouYin
//
//  Created by Jobs on 2021/4/6.
//

#import <Foundation/Foundation.h>

#import "AppToolsProtocol.h"
#import "NSObject+UserInfo.h"
#import "NSObject+Extras.h"
#import "UIView+Extras.h"

#import "AppDelegate.h"
#import "JobsAppDoorVC.h"
#import "AppInternationalizationVC.h"
#import "CasinoUpgradePopupView.h"
#import "JobsHotLabelWithSingleLine.h"
#import "JobsUpDownLab.h"
#import "JobsBaseConfigTestPopupView.h"

#import "UIViewModel.h"
#import "CasinoCustomerContactModel.h"

#if __has_include(<WMZCode/WMZCodeView.h>)
#import <WMZCode/WMZCodeView.h>
#else
#import "WMZCodeView.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AppTools)
<
AppToolsProtocol
,UITextViewDelegate
>
/// UI
@property(nonatomic,strong)JobsUpDownLab *titleLab;
@property(nonatomic,strong)UIButton *联系客服;
@property(nonatomic,strong)UIButton *立即注册;
@property(nonatomic,strong)UILabel *separateLab;/// 分割线
@property(nonatomic,strong)UITextView *connectionTipsTV;/// 承接富文本:如需幫助，請聯繫專屬客服
@property(nonatomic,strong)UITextView *agreementTipsTV;/// 承接富文本:我已閱讀並同意 相關條款 和 隱私政策
/// Data
@property(nonatomic,strong)CasinoCustomerContactModel *customerContactModel;
@property(nonatomic,strong)NSMutableArray<UIViewModel *> *hotLabelDataMutArr;
// 关于富文本:如需幫助，請聯繫專屬客服
@property(nonatomic,strong)NSMutableAttributedString *attributedStringData;
@property(nonatomic,strong)NSMutableArray <NSString *>*richTextMutArr;
@property(nonatomic,strong)NSMutableArray <RichTextConfig *>*richTextConfigMutArr;
// 关于富文本: 相關條款 和 隱私政策
@property(nonatomic,strong)NSMutableAttributedString *attributedStringData2;
@property(nonatomic,strong)NSMutableArray <NSString *>*richTextMutArr2;
@property(nonatomic,strong)NSMutableArray <RichTextConfig *>*richTextConfigMutArr2;
#pragma mark —— 一些公有化方法
/// 通过指定的图片，创建滑动验证模块UI
/// @param imageName 指定的图片名
/// @param successBlock 验证成功回调【如果验证成功，回传遮罩】
-(WMZCodeView *)createCodeViewWithImageName:(NSString *)imageName
                               successBlock:(jobsByIDBlock)successBlock;
/// 制造一个覆盖在keyWindow上的遮罩（已适配iPhoneX系列）
-(UIView *)maskViewWithColor:(UIColor *)color
                    coverNav:(BOOL)coverNav;
/// 制造承接富文本:如需幫助，請聯繫專屬客服
-(UITextView *)createConnectionTipsTV;
/// 制造承接富文本:我已閱讀並同意 相關條款 和 隱私政策
-(UITextView *)createAgreementTipsTV;
#pragma mark —— 弹出框。为了防止业务层的变化，弹出框定义在NSObject层
/// Debug模式下的弹出框 及其相关的数据封装。在外层进行调用，[ 需要被展现的视图 popupWithView:popupView];
-(JobsBaseConfigTestPopupView *)JobsTestPopView:(NSString *)string;
/// 在外层进行调用，[ 需要被展现的视图 popupWithView:popupView];
-(JobsBaseConfigTestPopupView *)jobsTestPopView:(UIViewModel *_Nullable)viewModel;
/// 测试和业务密切相关的弹窗 ：在外层进行调用，[ 需要被展现的视图 popupWithView:popupView];
/// @param popViewClass 被测试的弹窗视图
/// @param viewModel 此视图所绑定的数据。传nil则使用testPopViewData的数据、传UIViewModel.new则使用popViewClass预埋的数据
-(UIView<BaseViewProtocol> *)jobsPopView:(Class<BaseViewProtocol> _Nullable)popViewClass
                               viewModel:(UIViewModel *_Nullable)viewModel;
#pragma mark —— 网络通讯方面的

@end

static inline UIFont *notoSansBold(CGFloat fontSize){
    return fontName(@"NotoSans-Bold", JobsWidth(fontSize));
}

static inline UIFont *notoSansRegular(CGFloat fontSize){
    return fontName(@"NotoSans-Regular", JobsWidth(fontSize));
}

NS_ASSUME_NONNULL_END
