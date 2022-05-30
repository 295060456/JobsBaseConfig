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
/// UITableViewCell系统自带控件的自定义frame
@property(nonatomic,assign)CGRect detailTextLabelFrame;
@property(nonatomic,assign)CGRect textLabelFrame;
@property(nonatomic,assign)CGRect imageViewFrame;
/// UITableViewCell系统自带控件的自定义偏移量
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

@end

NS_ASSUME_NONNULL_END

#pragma mark —— @synthesize UITableViewCellProtocol
#ifndef UITableViewCellProtocol_synthesize
#define UITableViewCellProtocol_synthesize \
\
@synthesize detailTextLabelFrame = _detailTextLabelFrame;\
@synthesize textLabelFrame = _textLabelFrame;\
@synthesize imageViewFrame = _imageViewFrame;\
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
@dynamic detailTextLabelFrame;\
@dynamic textLabelFrame;\
@dynamic imageViewFrame;\
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
