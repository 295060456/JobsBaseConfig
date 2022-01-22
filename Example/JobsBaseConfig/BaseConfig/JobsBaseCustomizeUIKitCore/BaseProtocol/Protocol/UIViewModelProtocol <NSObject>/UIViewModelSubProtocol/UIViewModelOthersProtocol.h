//
//  UIViewModelOthersProtocol.h
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JobsLabelDef.h"

#if __has_include(<ReactiveObjC/ReactiveObjC.h>)
#import <ReactiveObjC/ReactiveObjC.h>
#else
#import "ReactiveObjC.h"
#endif

@class UIViewModel;

NS_ASSUME_NONNULL_BEGIN

@protocol UIViewModelOthersProtocol <NSObject>
@optional
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
@property(nonatomic,assign)UILabelShowingType labelShowingType;
// Layer
@property(nonatomic,strong,nullable)UIColor __block *layerBorderColour;
@property(nonatomic,assign)CGFloat layerBorderWidth;
@property(nonatomic,assign)CGFloat layerCornerRadius;


@end

NS_ASSUME_NONNULL_END

#pragma mark —— @synthesize UIViewModelOthersProtocol
#ifndef UIViewModelOthersProtocol_synthesize
#define UIViewModelOthersProtocol_synthesize \
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
@synthesize labelShowingType = _labelShowingType;\
@synthesize layerBorderColour = _layerBorderColour;\
@synthesize layerBorderWidth = _layerBorderWidth;\
@synthesize layerCornerRadius = _layerCornerRadius;\

#endif

#pragma mark —— @dynamic UIViewModelOthersProtocol
#ifndef UIViewModelOthersProtocol_dynamic
#define UIViewModelOthersProtocol_dynamic \
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
@dynamic labelShowingType;\
@dynamic layerBorderColour;\
@dynamic layerBorderWidth;\
@dynamic layerCornerRadius;\

#endif

