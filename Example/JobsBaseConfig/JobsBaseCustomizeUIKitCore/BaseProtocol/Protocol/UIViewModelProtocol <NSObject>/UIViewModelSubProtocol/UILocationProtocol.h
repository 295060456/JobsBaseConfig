//
//  UILocationProtocol.h
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIButton+ImageTitleSpacing.h"

NS_ASSUME_NONNULL_BEGIN

@protocol UILocationProtocol <NSObject>
@optional
#pragma mark —— 方位和大小
@property(nonatomic,assign)CGFloat __block cornerRadius;/// 圆切角（全角）
@property(nonatomic,assign)UIRectCorner __block rectCorner;/// 设置切哪个直角
@property(nonatomic,assign)CGSize __block cornerRadii;/// 设置切哪个直角的切角矩形
@property(nonatomic,assign)CGFloat __block jobsWidth;/// 宽
@property(nonatomic,assign)CGFloat __block jobsHeight;/// 高
@property(nonatomic,assign)CGFloat __block jobsTop;
@property(nonatomic,assign)CGFloat __block jobsLeft;
@property(nonatomic,assign)CGFloat __block jobsRight;
@property(nonatomic,assign)CGFloat __block jobsBottom;
@property(nonatomic,assign)CGFloat __block jobsOffsetX;
@property(nonatomic,assign)CGFloat __block jobsOffsetY;
@property(nonatomic,assign)CGSize __block jobsSize;/// 二维尺寸
@property(nonatomic,assign)CGRect __block jobsRect;
@property(nonatomic,assign)CGPoint __block jobsPoint;
@property(nonatomic,assign)UILayoutConstraintAxis __block axis;
@property(nonatomic,assign)UIStackViewDistribution __block distribution;
@property(nonatomic,assign)UIStackViewAlignment __block alignment;
#pragma mark —— UIButton 专用属性 — 图文的相对位置
@property(nonatomic,assign)GLButtonEdgeInsetsStyle __block buttonEdgeInsetsStyle;
@property(nonatomic,assign)CGFloat __block imageTitleSpace;
#pragma mark —— 关于 UITableViewCell 和 UICollectionViewCell
@property(nonatomic,assign)CGFloat __block cellHeight;
@property(nonatomic,assign)CGFloat __block heightForHeaderInSection;
@property(nonatomic,assign)CGSize __block cellSize;
@property(nonatomic,assign)CGSize __block tableHeaderViewSize;
@property(nonatomic,assign)CGSize __block tableFooterViewSize;
@property(nonatomic,assign)BOOL __block usesTableViewHeaderView;/// 默认不使用
@property(nonatomic,assign)BOOL __block usesTableViewFooterView;/// 默认不使用
/**
 控件之间的左右距离 offsetXForEach 和 offsetYForEach
 ❤️对单个cell的偏移，需要在cell的子类里面复写父类方法-(void)setFrame:(CGRect)frame；详见@implementation UITableViewCell (Margin)
 ❤️但是对于以section为单位基准的圆角处理，参见
 
 +(void)tableView:(UITableView *_Nonnull)tableView
 makeSectionFirstAndLastCell:(UITableViewCell *_Nonnull)cell
      atIndexPath:(NSIndexPath *_Nonnull)indexPath
        cellBgCor:(UIColor *_Nullable)cellBgCor
    bottomLineCor:(UIColor *_Nullable)bottomLineCor
   cellOutLineCor:(UIColor *_Nullable)cellOutLineCor
      roundCorner:(CGFloat)radius
               dx:(CGFloat)dx
               dy:(CGFloat)dy
 */
@property(nonatomic,assign)CGFloat __block offsetXForEach;
@property(nonatomic,assign)CGFloat __block offsetYForEach;
@property(nonatomic,assign)CGFloat __block offsetHeight;
@property(nonatomic,assign)CGFloat __block offsetWidth;

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
@synthesize jobsOffsetX = _jobsOffsetX;\
@synthesize jobsOffsetY = _jobsOffsetY;\
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
@synthesize buttonEdgeInsetsStyle;\
@synthesize imageTitleSpace;\
@synthesize cellHeight = _cellHeight;\
@synthesize heightForHeaderInSection = _heightForHeaderInSection;\
@synthesize cellSize = _cellSize;\
@synthesize tableHeaderViewSize = _tableHeaderViewSize;\
@synthesize tableFooterViewSize = _tableFooterViewSize;\
@synthesize usesTableViewHeaderView = _usesTableViewHeaderView;\
@synthesize usesTableViewFooterView = _usesTableViewFooterView;\

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
@dynamic jobsOffsetX;\
@dynamic jobsOffsetY;\
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
@dynamic buttonEdgeInsetsStyle;\
@dynamic imageTitleSpace;\
@dynamic cellHeight;\
@dynamic heightForHeaderInSection;\
@dynamic cellSize;\
@dynamic tableHeaderViewSize;\
@dynamic tableFooterViewSize;\
@dynamic usesTableViewHeaderView;\
@dynamic usesTableViewFooterView;\

#endif

