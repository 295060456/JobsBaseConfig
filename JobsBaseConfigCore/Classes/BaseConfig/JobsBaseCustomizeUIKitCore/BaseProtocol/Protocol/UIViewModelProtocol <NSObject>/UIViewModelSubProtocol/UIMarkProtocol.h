//
//  UIMarkProtocol.h
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UIMarkProtocol <NSObject>
@optional
#pragma mark โโ ๆ ่ฎฐ๐
@property(nonatomic,strong,nullable)NSIndexPath __block *indexPath;
@property(nonatomic,assign)NSInteger __block section;
@property(nonatomic,assign)NSInteger __block row;
@property(nonatomic,assign)NSInteger __block item;
@property(nonatomic,assign)CGPoint __block lastPoint;
@property(nonatomic,assign)NSInteger __block index;
@property(nonatomic,assign)NSInteger __block currentPage;/// ็ฝ่ทฏ่ฏทๆฑๅ้กตๆฐๆฎ็ๆถๅ็ๅฝๅ้กต็ 
@property(nonatomic,assign)NSInteger __block pageSize;

@end

NS_ASSUME_NONNULL_END

#pragma mark โโ @synthesize UIMarkProtocol
#ifndef UIMarkProtocol_synthesize
#define UIMarkProtocol_synthesize \
\
@synthesize indexPath = _indexPath;\
@synthesize section = _section;\
@synthesize row = _row;\
@synthesize item = _item;\
@synthesize lastPoint = _lastPoint;\
@synthesize index = _index;\
@synthesize currentPage = _currentPage;\
@synthesize pageSize = _pageSize;\

#endif

#pragma mark โโ @dynamic UIMarkProtocol
#ifndef UIMarkProtocol_dynamic
#define UIMarkProtocol_dynamic \
\
@dynamic indexPath;\
@dynamic section;\
@dynamic rowp;\
@dynamic item;\
@dynamic lastPoint;\
@dynamic index;\
@dynamic currentPage;\
@dynamic pageSize;\

#endif

