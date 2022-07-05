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

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AppTools)
<
AppToolsProtocol
,UITextViewDelegate
>
// UI
@property(nonatomic,strong)JobsUpDownLab *titleLab;
@property(nonatomic,strong)UIButton *联系客服;
@property(nonatomic,strong)UIButton *立即注册;
@property(nonatomic,strong)UILabel *separateLab;/// 分割线
@property(nonatomic,strong)UITextView *connectionTipsTV;/// 承接富文本:如需幫助，請聯繫專屬客服
// Data
@property(nonatomic,strong)CasinoCustomerContactModel *customerContactModel;
@property(nonatomic,strong)NSMutableArray<UIViewModel *> *hotLabelDataMutArr;
// 关于富文本:如需幫助，請聯繫專屬客服
@property(nonatomic,strong)NSMutableAttributedString *attributedStringData;
@property(nonatomic,strong)NSMutableArray <NSString *>*richTextMutArr;
@property(nonatomic,strong)NSMutableArray <RichTextConfig *>*richTextConfigMutArr;
#pragma mark —— 一些公有化方法
-(UITextView *)createConnectionTipsTV;
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
