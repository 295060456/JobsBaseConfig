//
//  NSObject+CallBackInfoByBlock.h
//  DouDong-II
//
//  Created by Jobs on 2021/2/26.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "JobsBlock.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (CallBackInfoByBlock)

#pragma mark —— 不确定参数
#pragma mark —— 确定参数
@property(nonatomic,assign)jobsByIDBlock objectBlock;/// 入参为ID类型，无返回值的回调
@property(nonatomic,assign)jobsByNSIntegerBlock NSIntegerBlock;/// 入参为NSInteger，无返回值的回调
@property(nonatomic,assign)jobsByNSUIntegerBlock NSUIntegerBlock;/// 入参为NSUInteger，无返回值的回调
@property(nonatomic,assign)jobsByCGFloatBlock CGFloatBlock;/// 入参CGFloat，无返回值的回调
@property(nonatomic,assign)jobsByBOOLBlock BOOLBlock;/// 入参为BOOL，无返回值的回调
@property(nonatomic,assign)jobsByIntBlock IntBlock;/// 入参为Int，无返回值的回调
@property(nonatomic,assign)jobsByUnsignedIntBlock UnsignedIntBlock;/// 入参为UnsignedInt，无返回值的回调
@property(nonatomic,assign)jobsByFloatBlock FloatBlock;/// 入参为Float，无返回值的回调
@property(nonatomic,assign)jobsByDoubleBlock DoubleBlock;/// 入参为Double，无返回值的回调
@property(nonatomic,assign)jobsByCharBlock CharBlock;/// 入参为Char，无返回值的回调
@property(nonatomic,assign)jobsByUnsignedCharBlock UnsignedCharBlock;/// 入参为IUnsignedChar，无返回值的回调
@property(nonatomic,assign)jobsByShortBlock ShortBlock;/// 入参为Short，无返回值的回调
@property(nonatomic,assign)jobsByUnsignedShortBlock UnsignedShortBlock;/// 入参为UnsignedShort，无返回值的回调
@property(nonatomic,assign)jobsByLongBlock LongBlock;/// 入参为Long，无返回值的回调
@property(nonatomic,assign)jobsByUnsignedLongBlock UnsignedLongBlock;/// 入参为UnsignedLong，无返回值的回调
@property(nonatomic,assign)jobsByUnsignedLongLongBlock UnsignedLongLongBlock;/// 入参为IUnsignedLongLong，无返回值的回调

@property(nonatomic,assign)JobsReturnIDByIDBlock returnObjectBlock;/// 返回值为ID的回调
@property(nonatomic,assign)JobsReturnByNSIntegerBlock returnNSIntegerBlock;/// 返回值为NSInteger的回调
@property(nonatomic,assign)JobsReturnByNSUIntegerBlock returnNSUIntegerBlock;/// 返回值为UInteger的回调
@property(nonatomic,assign)JobsReturnByCGFloatBlock returnCGFloatBlock;/// 返回值为CGFloat的回调
@property(nonatomic,assign)JobsReturnByBOOLBlock returnBOOLBlock;/// 返回值为BOOL的回调
@property(nonatomic,assign)JobsReturnByIntBlock returnIntBlock;/// 返回值为Int的回调
@property(nonatomic,assign)JobsReturnByUnsignedIntBlock returnUnsignedIntBlock;/// 返回值为UnsignedInt的回调
@property(nonatomic,assign)JobsReturnByFloatBlock returnFloatBlock;/// 返回值为Float的回调
@property(nonatomic,assign)JobsReturnByDoubleBlock returnDoubleBlock;/// 返回值为Double的回调
@property(nonatomic,assign)JobsReturnByCharBlock returnCharBlock;/// 返回值为Char的回调
@property(nonatomic,assign)JobsReturnByUnsignedCharBlock returnUnsignedCharBlock;/// 返回值为UnsignedChar的回调
@property(nonatomic,assign)JobsReturnByShortBlock returnShortBlock;/// 返回值为Short的回调
@property(nonatomic,assign)JobsReturnByUnsignedShortBlock returnUnsignedShortBlock;/// 返回值为UnsignedShort的回调
@property(nonatomic,assign)JobsReturnByLongBlock returnLongBlock;/// 返回值为Long的回调
@property(nonatomic,assign)JobsReturnByUnsignedLongBlock returnUnsignedLongBlock;/// 返回值为UnsignedLong的回调
@property(nonatomic,assign)JobsReturnByUnsignedLongLongBlock returnUnsignedLongLongBlock;/// 返回值为UnsignedLongLong的回调
#pragma mark —— block的set
-(void)actionObjectBlock:(jobsByIDBlock)objectBlock;
-(void)actionNSIntegerBlock:(jobsByNSIntegerBlock)NSIntegerBlock;
-(void)actionNSUIntegerBlock:(jobsByNSUIntegerBlock)NSUIntegerBlock;
-(void)actionCGFloatBlock:(jobsByCGFloatBlock)CGFloatBlock;
-(void)actionBOOLBlock:(jobsByBOOLBlock)BOOLBlock;
-(void)actionIntBlock:(jobsByIntBlock)IntBlock;
-(void)actionUnsignedIntBlock:(jobsByUnsignedIntBlock)UnsignedIntBlock;
-(void)actionFloatBlock:(jobsByFloatBlock)FloatBlock;
-(void)actionDoubleBlock:(jobsByDoubleBlock)DoubleBlock;
-(void)actionCharBlock:(jobsByCharBlock)CharBlock;
-(void)actionUnsignedCharBlock:(jobsByUnsignedCharBlock)UnsignedCharBlock;
-(void)actionShortBlock:(jobsByShortBlock)ShortBlock;
-(void)actionUnsignedShortBlock:(jobsByUnsignedShortBlock)UnsignedShortBlock;
-(void)actionLongBlock:(jobsByLongBlock)LongBlock;
-(void)actionUnsignedLongBlock:(jobsByUnsignedLongBlock)UnsignedLongBlock;
-(void)actionUnsignedLongLongBlock:(jobsByUnsignedLongLongBlock)UnsignedLongLongBlock;

-(void)actionReturnObjectBlock:(JobsReturnIDByIDBlock)returnObjectBlock;
-(void)actionReturnNSIntegerBlock:(JobsReturnByNSIntegerBlock)returnNSIntegerBlock;
-(void)actionReturnNSUIntegerBlock:(JobsReturnByNSUIntegerBlock)returnNSUIntegerBlock;
-(void)actionReturnCGFloatBlock:(JobsReturnByCGFloatBlock)returnCGFloatBlock;
-(void)actionReturnBOOLBlock:(JobsReturnByBOOLBlock)returnBOOLBlock;
-(void)actionReturnIntBlock:(JobsReturnByIntBlock)returnIntBlock;
-(void)actionReturnUnsignedIntBlock:(JobsReturnByUnsignedIntBlock)returnUnsignedIntBlock;
-(void)actionReturnFloatBlock:(JobsReturnByFloatBlock)returnFloatBlock;
-(void)actionReturnDoubleBlock:(JobsReturnByDoubleBlock)returnDoubleBlock;
-(void)actionReturnCharBlock:(JobsReturnByCharBlock)returnCharBlock;
-(void)actionReturnUnsignedCharBlock:(JobsReturnByUnsignedCharBlock)returnUnsignedCharBlock;
-(void)actionReturnShortBlock:(JobsReturnByShortBlock)returnShortBlock;
-(void)actionReturnUnsignedShortBlock:(JobsReturnByUnsignedShortBlock)returnUnsignedShortBlock;
-(void)actionReturnLongBlock:(JobsReturnByLongBlock)returnLongBlock;
-(void)actionReturnUnsignedLongBlock:(JobsReturnByUnsignedLongBlock)returnUnsignedLongBlock;
-(void)actionReturnUnsignedLongLongBlock:(JobsReturnByUnsignedLongLongBlock)returnUnsignedLongLongBlock;

@end

NS_ASSUME_NONNULL_END
