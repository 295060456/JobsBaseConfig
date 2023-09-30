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

/**
【命名规则】：
    1、无返回值省略Return 
    2、无入参标志为Void
    3、入参、返回值同一类型，标识为ReturnBy
    4、有返回值前缀Jobs、无返回值前缀jobs
 */
@interface NSObject (CallBackInfoByBlock)
/// 确定（单一）参数的Block属性定义
#pragma mark —— 没有返回值的Block属性定义
/// 1、没有入参、没有返回值的回调
@property(nonatomic,assign)jobsByVoidBlock voidBlock;/// 无入参，无返回值的回调
/// 2、有（单一）入参、没有返回值的回调
@property(nonatomic,assign)jobsByIDBlock objectBlock;/// 入参为ID类型，无返回值的回调
@property(nonatomic,assign)jobsByGestureRecognizerBlock gestureRecognizerBlock;/// 入参为UIGestureRecognizer，无返回值的回调
@property(nonatomic,assign)jobsBySELBlock selBlock;///入参为SEL，无返回值的回调
@property(nonatomic,assign)jobsByStringBlock stringBlock;///入参为NSString，无返回值的回调
/// 3、入参为基本数据类型、 且没有返回值的Block定义
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
#pragma mark —— 有返回值的Block属性定义
/// 4、无入参、有返回值的回调
@property(nonatomic,assign)JobsReturnIDByVoidBlock returnObjectByVoidBlock;/// 无入参，返回值为ID的回调
/// 5、有（单一）入参、有返回值的回调【返回其他类型】
@property(nonatomic,assign)JobsReturnIDByGestureRecognizerBlock returnObjectByGestureRecognizerBlock;/// 入参为UIGestureRecognizer，返回值为ID的回调
@property(nonatomic,assign)JobsReturnIDBySELBlock returnObjectBySELBlock;/// 入参为SEL，返回值为ID的回调
@property(nonatomic,assign)JobsReturnIDByStringBlock returnObjectByStringBlock;/// 入参为NSString，返回值为ID的回调
/// 6、有（单一）入参、有返回值的回调【返回入参类型】
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
#pragma mark —— 没有返回值的Block | Set
/// 1、没有入参、没有返回值的回调
-(void)actionVoidBlock:(jobsByVoidBlock)voidBlock;
/// 2、有（单一）入参、无返回值的回调
-(void)actionObjectBlock:(jobsByIDBlock)objectBlock;
-(void)actionGestureRecognizerBlock:(jobsByGestureRecognizerBlock)gestureRecognizerBlock;
-(void)actionSELBlock:(jobsBySELBlock)selBlock;
-(void)actionStringBlock:(jobsByStringBlock)stringBlock;
/// 3、入参为基本数据类型、 且没有返回值的回调
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
#pragma mark —— 有返回值的Block | Set
/// 4、无入参、有返回值的回调
-(void)actionReturnIDByVoidBlock:(JobsReturnIDByVoidBlock)returnObjectByVoidBlock;
/// 5、有（单一）入参、有返回值的回调【返回其他类型】
-(void)actionReturnIDByGestureRecognizerBlock:(JobsReturnIDByGestureRecognizerBlock)returnObjectByGestureRecognizerBlock;
-(void)actionReturnIDBySELBlock:(JobsReturnIDBySELBlock)returnObjectBySELBlock;
-(void)actionReturnIDByStringBlock:(JobsReturnIDByStringBlock)returnObjectByStringBlock;
/// 6、有（单一）入参、有返回值的回调【返回入参类型】
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
