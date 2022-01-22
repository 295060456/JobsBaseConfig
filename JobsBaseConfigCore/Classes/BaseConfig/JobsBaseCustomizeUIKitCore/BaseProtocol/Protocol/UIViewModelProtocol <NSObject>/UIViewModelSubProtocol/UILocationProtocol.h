//
//  UILocationProtocol.h
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UILocationProtocol <NSObject>
@optional
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

@end

NS_ASSUME_NONNULL_END

#pragma mark —— @synthesize UILocationProtocol
#ifndef UILocationProtocol_synthesize
#define UILocationProtocol_synthesize \
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

#endif

#pragma mark —— @dynamic UILocationProtocol
#ifndef UILocationProtocol_dynamic
#define UILocationProtocol_dynamic \
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

#endif

