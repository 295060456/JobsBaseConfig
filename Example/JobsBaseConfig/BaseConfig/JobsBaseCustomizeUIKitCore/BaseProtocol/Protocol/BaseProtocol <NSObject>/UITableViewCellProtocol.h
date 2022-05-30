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
/// UITableViewCell
@property(nonatomic,assign)CGRect detailTextLabelFrame;
@property(nonatomic,assign)CGRect textLabelFrame;
@property(nonatomic,assign)CGRect imageViewFrame;

+(instancetype)initTableViewCellWithStyle:(UITableViewCellStyle)style;
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END

#pragma mark —— @synthesize UITableViewCellProtocol
#ifndef UITableViewCellProtocol_synthesize
#define UITableViewCellProtocol_synthesize \
@synthesize detailTextLabelFrame = _detailTextLabelFrame;\
@synthesize textLabelFrame = _textLabelFrame;\
@synthesize imageViewFrame = _imageViewFrame;\

#endif
//
#pragma mark —— @dynamic UITableViewCellProtocol
#ifndef UITableViewCellProtocol_dynamic
#define UITableViewCellProtocol_dynamic \
\
@dynamic detailTextLabelFrame;\
@dynamic textLabelFrame;\
@dynamic imageViewFrame;\

#endif
