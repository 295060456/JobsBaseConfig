//
//  UITableViewCellProtocol.h
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/5/30.
//

#import <Foundation/Foundation.h>
#import "BaseCellProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol UITableViewCellProtocol <BaseCellProtocol>

@optional
/// ⚠️执行return的顺序依照下列👇🏻属性的排序⚠️
///【组 1】 UITableViewCell单独自定义设置系统自带控件的Frame 【形成Frame后直接return，避免被其他中间过程修改】❤️与组2、3属性互斥❤️
@property(nonatomic,assign)CGRect textLabelFrame;
@property(nonatomic,assign)CGRect detailTextLabelFrame;
@property(nonatomic,assign)CGRect imageViewFrame;
///【组 2】UITableViewCell单独自定义设置系统自带控件的Size【形成Frame后直接return，避免被其他中间过程修改】❤️与组1、3属性互斥❤️
@property(nonatomic,assign)CGSize textLabelSize;
@property(nonatomic,assign)CGSize detailTextLabelSize;
@property(nonatomic,assign)CGSize imageViewSize;
///【组 3】UITableViewCell单独自定义设置系统自带控件的宽高【形成Frame后直接return，避免被其他中间过程修改】❤️与组1、2属性互斥❤️
@property(nonatomic,assign)CGFloat textLabelWidth;
@property(nonatomic,assign)CGFloat textLabelHeight;
@property(nonatomic,assign)CGFloat detailTextLabelWidth;
@property(nonatomic,assign)CGFloat detailTextLabelHeight;
@property(nonatomic,assign)CGFloat imageViewWidth;
@property(nonatomic,assign)CGFloat imageViewHeight;
///【组 4】UITableViewCell单独自定义设置系统自带控件的偏移量
@property(nonatomic,assign)CGFloat textLabelFrameOffsetX;
@property(nonatomic,assign)CGFloat textLabelFrameOffsetY;
@property(nonatomic,assign)CGFloat textLabelFrameOffsetWidth;
@property(nonatomic,assign)CGFloat textLabelFrameOffsetHeight;

@property(nonatomic,assign)CGFloat detailTextLabelOffsetX;
@property(nonatomic,assign)CGFloat detailTextLabelOffsetY;
@property(nonatomic,assign)CGFloat detailTextLabelOffsetWidth;
@property(nonatomic,assign)CGFloat detailTextLabelOffsetHeight;

@property(nonatomic,assign)CGFloat imageViewFrameOffsetX;
@property(nonatomic,assign)CGFloat imageViewFrameOffsetY;
@property(nonatomic,assign)CGFloat imageViewFrameOffsetWidth;
@property(nonatomic,assign)CGFloat imageViewFrameOffsetHeight;

+(instancetype)initTableViewCellWithStyle:(UITableViewCellStyle)style;
+(instancetype)cellWithTableView:(UITableView *)tableView;
+(instancetype)cellWithTableView:(UITableView *)tableView
           cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END

#pragma mark —— @synthesize UITableViewCellProtocol
#ifndef UITableViewCellProtocol_synthesize
#define UITableViewCellProtocol_synthesize \
\
@synthesize textLabelFrame = _textLabelFrame;\
@synthesize detailTextLabelFrame = _detailTextLabelFrame;\
@synthesize imageViewFrame = _imageViewFrame;\
\
@synthesize textLabelSize = _textLabelSize;\
@synthesize detailTextLabelSize = _detailTextLabelSize;\
@synthesize imageViewSize = _imageViewSize;\
\
@synthesize textLabelWidth = _textLabelWidth;\
@synthesize textLabelHeight = _textLabelHeight;\
@synthesize detailTextLabelWidth = _detailTextLabelWidth;\
@synthesize detailTextLabelHeight = _detailTextLabelHeight;\
@synthesize imageViewWidth = _imageViewWidth;\
@synthesize imageViewHeight = _imageViewHeight;\
\
@synthesize textLabelFrameOffsetX = _textLabelFrameOffsetX;\
@synthesize textLabelFrameOffsetY = _textLabelFrameOffsetY;\
@synthesize textLabelFrameOffsetWidth = _textLabelFrameOffsetWidth;\
@synthesize textLabelFrameOffsetHeight = _textLabelFrameOffsetHeight;\
\
@synthesize detailTextLabelOffsetX = _detailTextLabelOffsetX;\
@synthesize detailTextLabelOffsetY = _detailTextLabelOffsetY;\
@synthesize detailTextLabelOffsetWidth = _detailTextLabelOffsetWidth;\
@synthesize detailTextLabelOffsetHeight = _detailTextLabelOffsetHeight;\
\
@synthesize imageViewFrameOffsetX = _imageViewFrameOffsetX;\
@synthesize imageViewFrameOffsetY = _imageViewFrameOffsetY;\
@synthesize imageViewFrameOffsetWidth = _imageViewFrameOffsetWidth;\
@synthesize imageViewFrameOffsetHeight = _imageViewFrameOffsetHeight;\

#endif
//
#pragma mark —— @dynamic UITableViewCellProtocol
#ifndef UITableViewCellProtocol_dynamic
#define UITableViewCellProtocol_dynamic \
\
@dynamic textLabelFrame;\
@dynamic detailTextLabelFrame;\
@dynamic imageViewFrame;\
\
@dynamic textLabelSize;\
@dynamic detailTextLabelSize;\
@dynamic imageViewSize;\
\
@dynamic textLabelWidth;\
@dynamic textLabelHeight;\
@dynamic detailTextLabelWidth;\
@dynamic detailTextLabelHeight;\
@dynamic imageViewWidth;\
@dynamic imageViewHeight;\
\
@dynamic textLabelFrameOffsetX;\
@dynamic textLabelFrameOffsetY;\
@dynamic textLabelFrameOffsetWidth;\
@dynamic textLabelFrameOffsetHeight;\
\
@dynamic detailTextLabelOffsetX;\
@dynamic detailTextLabelOffsetY;\
@dynamic detailTextLabelOffsetWidth;\
@dynamic detailTextLabelOffsetHeight;\
\
@dynamic imageViewFrameOffsetX;\
@dynamic imageViewFrameOffsetY;\
@dynamic imageViewFrameOffsetWidth;\
@dynamic imageViewFrameOffsetHeight;\

#endif
