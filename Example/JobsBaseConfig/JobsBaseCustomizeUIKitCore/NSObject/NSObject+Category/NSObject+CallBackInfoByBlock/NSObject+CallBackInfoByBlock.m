//
//  NSObject+CallBackInfoByBlock.m
//  DouDong-II
//
//  Created by Jobs on 2021/2/26.
//

#import "NSObject+CallBackInfoByBlock.h"

@implementation NSObject (CallBackInfoByBlock)
#pragma mark —— 没有返回值的Block | Set
/// 1、没有入参、没有返回值的回调
-(void)actionVoidBlock:(jobsByVoidBlock)voidBlock{
    self.voidBlock = voidBlock;
}
/// 2、有（单一）入参、没有返回值的回调
-(void)actionObjectBlock:(jobsByIDBlock)objectBlock{
    self.objectBlock = objectBlock;
}

-(void)actionGestureRecognizerBlock:(jobsByGestureRecognizerBlock)gestureRecognizerBlock{
    self.gestureRecognizerBlock = gestureRecognizerBlock;
}

-(void)actionSELBlock:(jobsBySELBlock)selBlock{
    self.selBlock = selBlock;
}

-(void)actionStringBlock:(jobsByStringBlock)stringBlock{
    self.stringBlock = stringBlock;
}
/// 3、入参为基本数据类型、 且没有返回值的Block定义
-(void)actionNSIntegerBlock:(jobsByNSIntegerBlock)NSIntegerBlock{
    self.NSIntegerBlock = NSIntegerBlock;
}

-(void)actionNSUIntegerBlock:(jobsByNSUIntegerBlock)NSUIntegerBlock{
    self.NSUIntegerBlock = NSUIntegerBlock;
}

-(void)actionCGFloatBlock:(jobsByCGFloatBlock)CGFloatBlock{
    self.CGFloatBlock = CGFloatBlock;
}

-(void)actionBOOLBlock:(jobsByBOOLBlock)BOOLBlock{
    self.BOOLBlock = BOOLBlock;
}

-(void)actionIntBlock:(jobsByIntBlock)IntBlock{
    self.IntBlock = IntBlock;
}

-(void)actionUnsignedIntBlock:(jobsByUnsignedIntBlock)UnsignedIntBlock{
    self.UnsignedIntBlock = UnsignedIntBlock;
}

-(void)actionFloatBlock:(jobsByFloatBlock)FloatBlock{
    self.FloatBlock = FloatBlock;
}

-(void)actionDoubleBlock:(jobsByDoubleBlock)DoubleBlock{
    self.DoubleBlock = DoubleBlock;
}

-(void)actionCharBlock:(jobsByCharBlock)CharBlock{
    self.CharBlock = CharBlock;
}

-(void)actionUnsignedCharBlock:(jobsByUnsignedCharBlock)UnsignedCharBlock{
    self.UnsignedCharBlock = UnsignedCharBlock;
}

-(void)actionShortBlock:(jobsByShortBlock)ShortBlock{
    self.ShortBlock = ShortBlock;
}

-(void)actionUnsignedShortBlock:(jobsByUnsignedShortBlock)UnsignedShortBlock{
    self.UnsignedShortBlock = UnsignedShortBlock;
}

-(void)actionLongBlock:(jobsByLongBlock)LongBlock{
    self.LongBlock = LongBlock;
}

-(void)actionUnsignedLongBlock:(jobsByUnsignedLongBlock)UnsignedLongBlock{
    self.UnsignedLongBlock = UnsignedLongBlock;
}

-(void)actionUnsignedLongLongBlock:(jobsByUnsignedLongLongBlock)UnsignedLongLongBlock{
    self.UnsignedLongLongBlock = UnsignedLongLongBlock;
}
#pragma mark —— 有返回值的Block | Set
/// 4、无入参、有返回值的回调
-(void)actionReturnIDByVoidBlock:(JobsReturnIDByVoidBlock)returnObjectByVoidBlock{
    self.returnObjectByVoidBlock = returnObjectByVoidBlock;
}
/// 5、有（单一）入参、有返回值的回调【返回其他类型】
-(void)actionReturnIDByGestureRecognizerBlock:(JobsReturnIDByGestureRecognizerBlock)returnObjectByGestureRecognizerBlock{
    self.returnObjectByGestureRecognizerBlock = returnObjectByGestureRecognizerBlock;
}

-(void)actionReturnIDBySELBlock:(JobsReturnIDBySELBlock)returnObjectBySELBlock{
    self.returnObjectBySELBlock = returnObjectBySELBlock;
}

-(void)actionReturnIDByStringBlock:(JobsReturnIDByStringBlock)returnObjectByStringBlock{
    self.returnObjectByStringBlock = returnObjectByStringBlock;
}

-(void)actionReturnNSIntegerByIDBlock:(JobsReturnNSIntegerByIDBlock)returnNSIntegerByIDBlock{
    self.returnNSIntegerByIDBlock = returnNSIntegerByIDBlock;
}

-(void)actionReturnNSUIntegerByIDBlock:(JobsReturnNSUIntegerByIDBlock)returnNSUIntegerByIDBlock{
    self.returnNSUIntegerByIDBlock = returnNSUIntegerByIDBlock;
}

-(void)actionReturnCGFloatByIDBlock:(JobsReturnCGFloatByIDBlock)returnCGFloatByIDBlock{
    self.returnCGFloatByIDBlock = returnCGFloatByIDBlock;
}

-(void)actionReturnBOOLByIDBlock:(JobsReturnBOOLByIDBlock)returnBOOLByIDBlock{
    self.returnBOOLByIDBlock = returnBOOLByIDBlock;
}

-(void)actionReturnIntByIDBlock:(JobsReturnIntByIDBlock)returnIntByIDBlock{
    self.returnIntByIDBlock = returnIntByIDBlock;
}

-(void)actionReturnUnsignedIntByIDBlock:(JobsReturnUnsignedIntByIDBlock)returnUnsignedIntByIDBlock{
    self.returnUnsignedIntByIDBlock = returnUnsignedIntByIDBlock;
}

-(void)actionReturnFloatByIDBlock:(JobsReturnFloatByIDBlock)returnFloatByIDBlock{
    self.returnFloatByIDBlock = returnFloatByIDBlock;
}

-(void)actionReturnDoubleByIDBlock:(JobsReturnDoubleByIDBlock)returnDoubleByIDBlock{
    self.returnDoubleByIDBlock = returnDoubleByIDBlock;
}

-(void)actionReturnCharByIDBlock:(JobsReturnCharByIDBlock)returnCharByIDBlock{
    self.returnCharByIDBlock = returnCharByIDBlock;
}

-(void)actionReturnUnsignedCharByIDBlock:(JobsReturnUnsignedCharByIDBlock)returnUnsignedCharByIDBlock{
    self.returnUnsignedCharByIDBlock = returnUnsignedCharByIDBlock;
}

-(void)actionReturnShortByIDBlock:(JobsReturnShortByIDBlock)returnShortByIDBlock{
    self.returnShortByIDBlock = returnShortByIDBlock;
}

-(void)actionReturnUnsignedShortByIDBlock:(JobsReturnUnsignedShortByIDBlock)returnUnsignedShortByIDBlock{
    self.returnUnsignedShortByIDBlock = returnUnsignedShortByIDBlock;
}

-(void)actionReturnLongByIDBlock:(JobsReturnLongByIDBlock)returnLongByIDBlock{
    self.returnLongByIDBlock = returnLongByIDBlock;
}

-(void)actionReturnUnsignedLongByIDBlock:(JobsReturnUnsignedLongByIDBlock)returnUnsignedLongByIDBlock{
    self.returnUnsignedLongByIDBlock = returnUnsignedLongByIDBlock;
}

-(void)actionReturnUnsignedLongLongByIDBlock:(JobsReturnUnsignedLongLongByIDBlock)returnUnsignedLongLongByIDBlock{
    self.returnUnsignedLongLongByIDBlock = returnUnsignedLongLongByIDBlock;
}
/// 6、有（单一）入参、有返回值的回调【返回入参类型】
-(void)actionReturnObjectBlock:(JobsReturnIDByIDBlock)returnObjectBlock{
    self.returnObjectBlock = returnObjectBlock;
}

-(void)actionReturnNSIntegerBlock:(JobsReturnByNSIntegerBlock)returnNSIntegerBlock{
    self.returnNSIntegerBlock = returnNSIntegerBlock;
}

-(void)actionReturnNSUIntegerBlock:(JobsReturnByNSUIntegerBlock)returnNSUIntegerBlock{
    self.returnNSUIntegerBlock = returnNSUIntegerBlock;
}

-(void)actionReturnCGFloatBlock:(JobsReturnByCGFloatBlock)returnCGFloatBlock{
    self.returnCGFloatBlock = returnCGFloatBlock;
}

-(void)actionReturnBOOLBlock:(JobsReturnByBOOLBlock)returnBOOLBlock{
    self.returnBOOLBlock = returnBOOLBlock;
}

-(void)actionReturnIntBlock:(JobsReturnByIntBlock)returnIntBlock{
    self.returnIntBlock = returnIntBlock;
}

-(void)actionReturnUnsignedIntBlock:(JobsReturnByUnsignedIntBlock)returnUnsignedIntBlock{
    self.returnUnsignedIntBlock = returnUnsignedIntBlock;
}

-(void)actionReturnFloatBlock:(JobsReturnByFloatBlock)returnFloatBlock{
    self.returnFloatBlock = returnFloatBlock;
}

-(void)actionReturnDoubleBlock:(JobsReturnByDoubleBlock)returnDoubleBlock{
    self.returnDoubleBlock = returnDoubleBlock;
}

-(void)actionReturnCharBlock:(JobsReturnByCharBlock)returnCharBlock{
    self.returnCharBlock = returnCharBlock;
}

-(void)actionReturnUnsignedCharBlock:(JobsReturnByUnsignedCharBlock)returnUnsignedCharBlock{
    self.returnUnsignedCharBlock = returnUnsignedCharBlock;
}

-(void)actionReturnShortBlock:(JobsReturnByShortBlock)returnShortBlock{
    self.returnShortBlock = returnShortBlock;
}

-(void)actionReturnUnsignedShortBlock:(JobsReturnByUnsignedShortBlock)returnUnsignedShortBlock{
    self.returnUnsignedShortBlock = returnUnsignedShortBlock;
}

-(void)actionReturnLongBlock:(JobsReturnByLongBlock)returnLongBlock{
    self.returnLongBlock = returnLongBlock;
}

-(void)actionReturnUnsignedLongBlock:(JobsReturnByUnsignedLongBlock)returnUnsignedLongBlock{
    self.returnUnsignedLongBlock = returnUnsignedLongBlock;
}

-(void)actionReturnUnsignedLongLongBlock:(JobsReturnByUnsignedLongLongBlock)returnUnsignedLongLongBlock{
    self.returnUnsignedLongLongBlock = returnUnsignedLongLongBlock;
}
/// 1、没有入参、没有返回值的回调
#pragma mark —— @property(nonatomic,assign)jobsByVoidBlock voidBlock;/// 无入参，无返回值的回调
JobsKey(_voidBlock)
@dynamic voidBlock;
-(jobsByVoidBlock)voidBlock{
    return Jobs_getAssociatedObject(_voidBlock);
}

-(void)setVoidBlock:(jobsByVoidBlock)voidBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_voidBlock, voidBlock)
}
/// 2、有（单一）入参、没有返回值的回调
#pragma mark —— @property(nonatomic,assign)jobsByIDBlock objectBlock;/// 入参为ID类型，无返回值的回调
JobsKey(_objectBlock)
@dynamic objectBlock;
-(jobsByIDBlock)objectBlock{
    return Jobs_getAssociatedObject(_objectBlock);
}

-(void)setObjectBlock:(jobsByIDBlock)objectBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_objectBlock, objectBlock)
}
#pragma mark —— @property(nonatomic,assign)jobsBySELBlock selBlock;///入参为SEL，无返回值的回调
JobsKey(_selBlock)
@dynamic selBlock;
-(jobsBySELBlock)selBlock{
    return Jobs_getAssociatedObject(_selBlock);
}

-(void)setSelBlock:(jobsBySELBlock)selBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_selBlock, selBlock);
}
#pragma mark —— @property(nonatomic,assign)jobsByStringBlock stringBlock;///入参为NSString，无返回值的回调
JobsKey(_stringBlock)
@dynamic stringBlock;
-(jobsByStringBlock)stringBlock{
    return Jobs_getAssociatedObject(_stringBlock);
}

-(void)setStringBlock:(jobsByStringBlock)stringBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_stringBlock, stringBlock)
}
#pragma mark —— @property(nonatomic,assign)jobsByGestureRecognizerBlock gestureRecognizerBlock;/// 入参为UIGestureRecognizer，无返回值的回调
JobsKey(_gestureRecognizerBlock)
@dynamic gestureRecognizerBlock;
-(jobsByGestureRecognizerBlock)gestureRecognizerBlock{
    return Jobs_getAssociatedObject(_gestureRecognizerBlock);
}

-(void)setGestureRecognizerBlock:(jobsByGestureRecognizerBlock)gestureRecognizerBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_gestureRecognizerBlock, gestureRecognizerBlock)
}
/// 3、入参为基本数据类型、 且没有返回值的Block定义
#pragma mark —— @property(nonatomic,assign)jobsByNSIntegerBlock NSIntegerBlock;/// 入参为NSInteger，无返回值的回调
JobsKey(_NSIntegerBlock)
@dynamic NSIntegerBlock;
-(jobsByNSIntegerBlock)NSIntegerBlock{
    return Jobs_getAssociatedObject(_NSIntegerBlock);
}

-(void)setNSIntegerBlock:(jobsByNSIntegerBlock)NSIntegerBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_NSIntegerBlock, NSIntegerBlock)
}
#pragma mark —— @property(nonatomic,assign)jobsByNSUIntegerBlock NSUIntegerBlock;/// 入参为NSUInteger，无返回值的回调
JobsKey(_NSUIntegerBlock)
@dynamic NSUIntegerBlock;
-(jobsByNSUIntegerBlock)NSUIntegerBlock{
    return Jobs_getAssociatedObject(_NSUIntegerBlock);
}

-(void)setNSUIntegerBlock:(jobsByNSUIntegerBlock)NSUIntegerBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_NSUIntegerBlock, NSUIntegerBlock)
}
#pragma mark —— @property(nonatomic,assign)jobsByCGFloatBlock CGFloatBlock;/// 入参CGFloat，无返回值的回调
JobsKey(_CGFloatBlock)
@dynamic CGFloatBlock;
-(jobsByCGFloatBlock)CGFloatBlock{
    return Jobs_getAssociatedObject(_CGFloatBlock);
}

-(void)setCGFloatBlock:(jobsByCGFloatBlock)CGFloatBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_CGFloatBlock, CGFloatBlock)
}
#pragma mark —— @property(nonatomic,assign)jobsByBOOLBlock BOOLBlock;/// 入参为BOOL，无返回值的回调
JobsKey(_BOOLBlock)
@dynamic BOOLBlock;
-(jobsByBOOLBlock)BOOLBlock{
    return Jobs_getAssociatedObject(_BOOLBlock);
}

-(void)setBOOLBlock:(jobsByBOOLBlock)BOOLBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_BOOLBlock, BOOLBlock)
}
#pragma mark —— @property(nonatomic,assign)jobsByIntBlock IntBlock;/// 入参为Int，无返回值的回调
JobsKey(_IntBlock)
@dynamic IntBlock;
-(jobsByIntBlock)IntBlock{
    return Jobs_getAssociatedObject(_IntBlock);
}

-(void)setIntBlock:(jobsByIntBlock)IntBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_IntBlock, IntBlock)
}
#pragma mark —— @property(nonatomic,assign)jobsByUnsignedIntBlock UnsignedIntBlock;/// 入参为UnsignedInt，无返回值的回调
JobsKey(_UnsignedIntBlock)
@dynamic UnsignedIntBlock;
-(jobsByUnsignedIntBlock)UnsignedIntBlock{
    return Jobs_getAssociatedObject(_UnsignedIntBlock);
}

-(void)setUnsignedIntBlock:(jobsByUnsignedIntBlock)UnsignedIntBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_UnsignedIntBlock, UnsignedIntBlock)
}
#pragma mark —— @property(nonatomic,assign)jobsByFloatBlock FloatBlock;/// 入参为Float，无返回值的回调
JobsKey(_FloatBlock)
@dynamic FloatBlock;
-(jobsByFloatBlock)FloatBlock{
    return Jobs_getAssociatedObject(_FloatBlock);
}

-(void)setFloatBlock:(jobsByFloatBlock)FloatBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_FloatBlock, FloatBlock)
}
#pragma mark —— @property(nonatomic,assign)jobsByDoubleBlock DoubleBlock;/// 入参为Double，无返回值的回调
JobsKey(_DoubleBlock)
@dynamic DoubleBlock;
-(jobsByDoubleBlock)DoubleBlock{
    return Jobs_getAssociatedObject(_DoubleBlock);
}

-(void)setDoubleBlock:(jobsByDoubleBlock)DoubleBlock{
 Jobs_setAssociatedCOPY_NONATOMIC(_DoubleBlock, DoubleBlock)
}
#pragma mark —— @property(nonatomic,assign)jobsByCharBlock CharBlock;/// 入参为Char，无返回值的回调
JobsKey(_CharBlock)
@dynamic CharBlock;
-(jobsByCharBlock)CharBlock{
    return Jobs_getAssociatedObject(_CharBlock);
}

-(void)setCharBlock:(jobsByCharBlock)CharBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_CharBlock, CharBlock)
}
#pragma mark —— @property(nonatomic,assign)jobsByUnsignedCharBlock UnsignedCharBlock;/// 入参为IUnsignedChar，无返回值的回调
JobsKey(_UnsignedCharBlock)
@dynamic UnsignedCharBlock;
-(jobsByUnsignedCharBlock)UnsignedCharBlock{
    return Jobs_getAssociatedObject(_UnsignedCharBlock);
}

-(void)setUnsignedCharBlock:(jobsByUnsignedCharBlock)UnsignedCharBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_UnsignedCharBlock, UnsignedCharBlock)
}
#pragma mark —— @property(nonatomic,assign)jobsByShortBlock ShortBlock;/// 入参为Short，无返回值的回调
JobsKey(_ShortBlock)
@dynamic ShortBlock;
-(jobsByShortBlock)ShortBlock{
    return Jobs_getAssociatedObject(_ShortBlock);
}

-(void)setShortBlock:(jobsByShortBlock)ShortBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_ShortBlock, ShortBlock)
}
#pragma mark —— @property(nonatomic,assign)jobsByUnsignedShortBlock UnsignedShortBlock;/// 入参为UnsignedShort，无返回值的回调
JobsKey(_UnsignedShortBlock)
@dynamic UnsignedShortBlock;
-(jobsByUnsignedShortBlock)UnsignedShortBlock{
    return Jobs_getAssociatedObject(_UnsignedShortBlock);
}

-(void)setUnsignedShortBlock:(jobsByUnsignedShortBlock)UnsignedShortBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_UnsignedShortBlock, UnsignedShortBlock)
}
#pragma mark —— @property(nonatomic,assign)jobsByLongBlock LongBlock;/// 入参为Long，无返回值的回调
JobsKey(_LongBlock)
@dynamic LongBlock;
-(jobsByLongBlock)LongBlock{
    return Jobs_getAssociatedObject(_LongBlock);
}

-(void)setLongBlock:(jobsByLongBlock)LongBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_LongBlock, LongBlock)
}
#pragma mark —— @property(nonatomic,assign)jobsByUnsignedLongBlock UnsignedLongBlock;/// 入参为UnsignedLong，无返回值的回调
JobsKey(_UnsignedLongBlock)
@dynamic UnsignedLongBlock;
-(jobsByUnsignedLongBlock)UnsignedLongBlock{
    return Jobs_getAssociatedObject(_UnsignedLongBlock);
}

-(void)setUnsignedLongBlock:(jobsByUnsignedLongBlock)UnsignedLongBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_UnsignedLongBlock, UnsignedLongBlock)
}
#pragma mark —— @property(nonatomic,assign)jobsByUnsignedLongLongBlock UnsignedLongLongBlock;/// 入参为IUnsignedLongLong，无返回值的回调
JobsKey(_UnsignedLongLongBlock)
@dynamic UnsignedLongLongBlock;
-(jobsByUnsignedLongLongBlock)UnsignedLongLongBlock{
    return Jobs_getAssociatedObject(_UnsignedLongLongBlock);
}

-(void)setUnsignedLongLongBlock:(jobsByUnsignedLongLongBlock)UnsignedLongLongBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_UnsignedLongLongBlock, UnsignedLongLongBlock)
}
/// 4、无入参、有返回值的回调
#pragma mark —— @property(nonatomic,assign)JobsReturnIDByVoidBlock returnObjectByVoidBlock;/// 无入参，返回值为ID的回调
JobsKey(_returnObjectByVoidBlock)
@dynamic returnObjectByVoidBlock;
-(JobsReturnIDByVoidBlock)returnObjectByVoidBlock{
    return Jobs_getAssociatedObject(_returnObjectByVoidBlock);
}

-(void)setReturnObjectByVoidBlock:(JobsReturnIDByVoidBlock)returnObjectByVoidBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnObjectByVoidBlock, returnObjectByVoidBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnIDByGestureRecognizerBlock returnObjectByGestureRecognizerBlock;/// 入参为UIGestureRecognizer，返回值为ID的回调
JobsKey(_returnObjectByGestureRecognizerBlock)
@dynamic returnObjectByGestureRecognizerBlock;
-(JobsReturnIDByGestureRecognizerBlock)returnObjectByGestureRecognizerBlock{
    return Jobs_getAssociatedObject(_returnObjectByGestureRecognizerBlock);
}

-(void)setReturnObjectByGestureRecognizerBlock:(JobsReturnIDByGestureRecognizerBlock)returnObjectByGestureRecognizerBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnObjectByGestureRecognizerBlock, returnObjectByGestureRecognizerBlock)
}

#pragma mark —— @property(nonatomic,assign)JobsReturnIDBySELBlock returnObjectBySELBlock;/// 入参为SEL，返回值为ID的回调
JobsKey(_returnObjectBySELBlock)
@dynamic returnObjectBySELBlock;
-(JobsReturnIDBySELBlock)returnObjectBySELBlock{
    return Jobs_getAssociatedObject(_returnObjectBySELBlock);
}

-(void)setReturnObjectBySELBlock:(JobsReturnIDBySELBlock)returnObjectBySELBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnObjectBySELBlock, returnObjectBySELBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnIDByStringBlock returnObjectByStringBlock;/// 入参为NSString，返回值为ID的回调
JobsKey(_returnObjectByStringBlock)
@dynamic returnObjectByStringBlock;
-(JobsReturnIDByStringBlock)returnObjectByStringBlock{
    return Jobs_getAssociatedObject(_returnObjectByStringBlock);
}

-(void)setReturnObjectByStringBlock:(JobsReturnIDByStringBlock)returnObjectByStringBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnObjectByStringBlock, returnObjectByStringBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnNSIntegerByIDBlock returnNSIntegerByIDBlock;
JobsKey(_returnNSIntegerByIDBlock)
@dynamic returnNSIntegerByIDBlock;
-(JobsReturnNSIntegerByIDBlock)returnNSIntegerByIDBlock{
    return Jobs_getAssociatedObject(_returnNSIntegerByIDBlock);
}

-(void)setReturnNSIntegerByIDBlock:(JobsReturnNSIntegerByIDBlock)returnNSIntegerByIDBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnNSIntegerByIDBlock, returnNSIntegerByIDBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnNSUIntegerByIDBlock returnNSUIntegerByIDBlock;
JobsKey(_returnNSUIntegerByIDBlock)
@dynamic returnNSUIntegerByIDBlock;
-(JobsReturnNSUIntegerByIDBlock)returnNSUIntegerByIDBlock{
    return Jobs_getAssociatedObject(_returnNSUIntegerByIDBlock);
}

-(void)setReturnNSUIntegerByIDBlock:(JobsReturnNSUIntegerByIDBlock)returnNSUIntegerByIDBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnNSUIntegerByIDBlock, returnNSUIntegerByIDBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnCGFloatByIDBlock returnCGFloatByIDBlock;
JobsKey(_returnCGFloatByIDBlock)
@dynamic returnCGFloatByIDBlock;
-(JobsReturnCGFloatByIDBlock)returnCGFloatByIDBlock{
    return Jobs_getAssociatedObject(_returnCGFloatByIDBlock);
}

-(void)setReturnCGFloatByIDBlock:(JobsReturnCGFloatByIDBlock)returnCGFloatByIDBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnCGFloatByIDBlock, returnCGFloatByIDBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnBOOLByIDBlock returnBOOLByIDBlock;
JobsKey(_returnBOOLByIDBlock)
@dynamic returnBOOLByIDBlock;
-(JobsReturnBOOLByIDBlock)returnBOOLByIDBlock{
    return Jobs_getAssociatedObject(_returnBOOLByIDBlock);
}

-(void)setReturnBOOLByIDBlock:(JobsReturnBOOLByIDBlock)returnBOOLByIDBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnBOOLByIDBlock, returnBOOLByIDBlock);
}
#pragma mark —— @property(nonatomic,assign)JobsReturnIntByIDBlock returnIntByIDBlock;
JobsKey(_returnIntByIDBlock)
@dynamic returnIntByIDBlock;
-(JobsReturnIntByIDBlock)returnIntByIDBlock{
    return Jobs_getAssociatedObject(_returnIntByIDBlock);
}

-(void)setReturnIntByIDBlock:(JobsReturnIntByIDBlock)returnIntByIDBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnIntByIDBlock, returnIntByIDBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnUnsignedIntByIDBlock returnUnsignedIntByIDBlock;
JobsKey(_returnUnsignedIntByIDBlock)
@dynamic returnUnsignedIntByIDBlock;
-(JobsReturnUnsignedIntByIDBlock)returnUnsignedIntByIDBlock{
    return Jobs_getAssociatedObject(_returnUnsignedIntByIDBlock);
}

-(void)setReturnUnsignedIntByIDBlock:(JobsReturnUnsignedIntByIDBlock)returnUnsignedIntByIDBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnUnsignedIntByIDBlock,returnUnsignedIntByIDBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnFloatByIDBlock returnFloatByIDBlock;
JobsKey(_returnFloatByIDBlock)
@dynamic returnFloatByIDBlock;
-(JobsReturnFloatByIDBlock)returnFloatByIDBlock{
    return Jobs_getAssociatedObject(_returnFloatByIDBlock);
}

-(void)setReturnFloatByIDBlock:(JobsReturnFloatByIDBlock)returnFloatByIDBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnFloatByIDBlock, returnFloatByIDBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnDoubleByIDBlock returnDoubleByIDBlock;
JobsKey(_returnDoubleByIDBlock)
@dynamic returnDoubleByIDBlock;
-(JobsReturnDoubleByIDBlock)returnDoubleByIDBlock{
    return Jobs_getAssociatedObject(_returnDoubleByIDBlock);
}

-(void)setReturnDoubleByIDBlock:(JobsReturnDoubleByIDBlock)returnDoubleByIDBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnDoubleByIDBlock, returnDoubleByIDBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnCharByIDBlock returnCharByIDBlock;
JobsKey(_returnCharByIDBlock)
@dynamic returnCharByIDBlock;
-(JobsReturnCharByIDBlock)returnCharByIDBlock{
    return Jobs_getAssociatedObject(_returnCharByIDBlock);
}

-(void)setReturnCharByIDBlock:(JobsReturnCharByIDBlock)returnCharByIDBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnCharByIDBlock, returnCharByIDBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnUnsignedCharByIDBlock returnUnsignedCharByIDBlock;
JobsKey(_returnUnsignedCharByIDBlock)
@dynamic returnUnsignedCharByIDBlock;
-(JobsReturnUnsignedCharByIDBlock)returnUnsignedCharByIDBlock{
    return Jobs_getAssociatedObject(_returnUnsignedCharByIDBlock);
}

-(void)setReturnUnsignedCharByIDBlock:(JobsReturnUnsignedCharByIDBlock)returnUnsignedCharByIDBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnUnsignedCharByIDBlock, returnUnsignedCharByIDBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnShortByIDBlock returnShortByIDBlock;
JobsKey(_returnShortByIDBlock)
@dynamic returnShortByIDBlock;
-(JobsReturnShortByIDBlock)returnShortByIDBlock{
    return Jobs_getAssociatedObject(_returnShortByIDBlock);
}

-(void)setReturnShortByIDBlock:(JobsReturnShortByIDBlock)returnShortByIDBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnShortByIDBlock, returnShortByIDBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnUnsignedShortByIDBlock returnUnsignedShortByIDBlock;
JobsKey(_returnUnsignedShortByIDBlock)
@dynamic returnUnsignedShortByIDBlock;
-(JobsReturnUnsignedShortByIDBlock)returnUnsignedShortByIDBlock{
    return Jobs_getAssociatedObject(_returnUnsignedShortByIDBlock);
}

-(void)setReturnUnsignedShortByIDBlock:(JobsReturnUnsignedShortByIDBlock)returnUnsignedShortByIDBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnUnsignedShortByIDBlock, returnUnsignedShortByIDBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnLongByIDBlock returnLongByIDBlock;
JobsKey(_returnLongByIDBlock)
@dynamic returnLongByIDBlock;
-(JobsReturnLongByIDBlock)returnLongByIDBlock{
    return Jobs_getAssociatedObject(_returnLongByIDBlock);
}

-(void)setReturnLongByIDBlock:(JobsReturnLongByIDBlock)returnLongByIDBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnLongByIDBlock, returnLongByIDBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnUnsignedLongByIDBlock returnUnsignedLongByIDBlock;
JobsKey(_returnUnsignedLongByIDBlock)
@dynamic returnUnsignedLongByIDBlock;
-(JobsReturnUnsignedLongByIDBlock)returnUnsignedLongByIDBlock{
    return Jobs_getAssociatedObject(_returnUnsignedLongByIDBlock);
}

-(void)setReturnUnsignedLongByIDBlock:(JobsReturnUnsignedLongByIDBlock)returnUnsignedLongByIDBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnUnsignedLongByIDBlock, returnUnsignedLongByIDBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnUnsignedLongLongByIDBlock returnUnsignedLongLongByIDBlock;
JobsKey(_returnUnsignedLongLongByIDBlock)
@dynamic returnUnsignedLongLongByIDBlock;
-(JobsReturnUnsignedLongLongByIDBlock)returnUnsignedLongLongByIDBlock{
    return Jobs_getAssociatedObject(_returnUnsignedLongLongByIDBlock);
}

-(void)setReturnUnsignedLongLongByIDBlock:(JobsReturnUnsignedLongLongByIDBlock)returnUnsignedLongLongByIDBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnUnsignedLongLongByIDBlock, returnUnsignedLongLongByIDBlock)
}
/// 6、有（单一）入参、有返回值的回调【返回入参类型】
#pragma mark —— @property(nonatomic,assign)JobsReturnIDByIDBlock returnObjectBlock;
JobsKey(_returnObjectBlock)
@dynamic returnObjectBlock;
-(JobsReturnIDByIDBlock)returnObjectBlock{
    return Jobs_getAssociatedObject(_returnObjectBlock);
}

-(void)setReturnObjectBlock:(JobsReturnIDByIDBlock)returnObjectBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnObjectBlock, returnObjectBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByNSIntegerBlock returnNSIntegerBlock;/// 返回值为NSInteger的回调
JobsKey(_returnNSIntegerBlock)
@dynamic returnNSIntegerBlock;
-(JobsReturnByNSIntegerBlock)returnNSIntegerBlock{
    return Jobs_getAssociatedObject(_returnNSIntegerBlock);
}

-(void)setReturnNSIntegerBlock:(JobsReturnByNSIntegerBlock)returnNSIntegerBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnNSIntegerBlock, returnNSIntegerBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByUIntegerBlock returnNSUIntegerBlock;/// 返回值为UInteger的回调
JobsKey(_returnNSUIntegerBlock)
@dynamic returnNSUIntegerBlock;
-(JobsReturnByNSUIntegerBlock)returnNSUIntegerBlock{
    return Jobs_getAssociatedObject(_returnNSUIntegerBlock);
}

-(void)setReturnUIntegerBlock:(JobsReturnByNSUIntegerBlock)returnNSUIntegerBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnNSUIntegerBlock, returnNSUIntegerBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByCGFloatBlock returnCGFloatBlock;/// 返回值为CGFloat的回调
JobsKey(_returnCGFloatBlock)
@dynamic returnCGFloatBlock;
-(JobsReturnByCGFloatBlock)returnCGFloatBlock{
    return Jobs_getAssociatedObject(_returnCGFloatBlock);
}

-(void)setReturnCGFloatBlock:(JobsReturnByCGFloatBlock)returnCGFloatBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnCGFloatBlock, returnCGFloatBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByBOOLBlock returnBOOLBlock;/// 返回值为BOOL的回调
JobsKey(_returnBOOLBlock)
@dynamic returnBOOLBlock;
-(JobsReturnByBOOLBlock)returnBOOLBlock{
    return Jobs_getAssociatedObject(_returnBOOLBlock);
}

-(void)setReturnBOOLBlock:(JobsReturnByBOOLBlock)returnBOOLBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnBOOLBlock, returnBOOLBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByIntBlock returnIntBlock;/// 返回值为Int的回调
JobsKey(_returnIntBlock)
@dynamic returnIntBlock;
-(JobsReturnByIntBlock)returnIntBlock{
    return Jobs_getAssociatedObject(_returnIntBlock);
}

-(void)setReturnIntBlock:(JobsReturnByIntBlock)returnIntBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnIntBlock, returnIntBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByUnsignedIntBlock returnUnsignedIntBlock;/// 返回值为UnsignedInt的回调
JobsKey(_returnUnsignedIntBlock)
@dynamic returnUnsignedIntBlock;
-(JobsReturnByUnsignedIntBlock)returnUnsignedIntBlock{
    return Jobs_getAssociatedObject(_returnUnsignedIntBlock);
}

-(void)setReturnUnsignedIntBlock:(JobsReturnByUnsignedIntBlock)returnUnsignedIntBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnUnsignedIntBlock, returnUnsignedIntBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByFloatBlock returnFloatBlock;/// 返回值为Float的回调
JobsKey(_returnFloatBlock)
@dynamic returnFloatBlock;
-(JobsReturnByFloatBlock)returnFloatBlock{
    return Jobs_getAssociatedObject(_returnFloatBlock);
}

-(void)setReturnFloatBlock:(JobsReturnByFloatBlock)returnFloatBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnFloatBlock, returnFloatBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByDoubleBlock returnDoubleBlock;/// 返回值为Double的回调
JobsKey(_returnDoubleBlock)
@dynamic returnDoubleBlock;
-(JobsReturnByDoubleBlock)returnDoubleBlock{
    return Jobs_getAssociatedObject(_returnDoubleBlock);
}

-(void)setReturnDoubleBlock:(JobsReturnByDoubleBlock)returnDoubleBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnDoubleBlock, returnDoubleBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByCharBlock returnCharBlock;/// 返回值为Char的回调
JobsKey(_returnCharBlock)
@dynamic returnCharBlock;
-(JobsReturnByCharBlock)returnCharBlock{
    return Jobs_getAssociatedObject(_returnCharBlock);
}

-(void)setReturnCharBlock:(JobsReturnByCharBlock)returnCharBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnCharBlock, returnCharBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByUnsignedCharBlock returnUnsignedCharBlock;/// 返回值为UnsignedChar的回调
JobsKey(_returnUnsignedCharBlock)
@dynamic returnUnsignedCharBlock;
-(JobsReturnByUnsignedCharBlock)returnUnsignedCharBlock{
    return Jobs_getAssociatedObject(_returnUnsignedCharBlock);
}

-(void)setReturnUnsignedCharBlock:(JobsReturnByUnsignedCharBlock)returnUnsignedCharBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnUnsignedCharBlock, returnUnsignedCharBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByShortBlock returnShortBlock;/// 返回值为Short的回调
JobsKey(_returnShortBlock)
@dynamic returnShortBlock;
-(JobsReturnByShortBlock)returnShortBlock{
    return Jobs_getAssociatedObject(_returnShortBlock);
}

-(void)setReturnShortBlock:(JobsReturnByShortBlock)returnShortBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnShortBlock, returnShortBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByUnsignedShortBlock returnUnsignedShortBlock;/// 返回值为UnsignedShort的回调
JobsKey(_returnUnsignedShortBlock)
@dynamic returnUnsignedShortBlock;
-(JobsReturnByUnsignedShortBlock)returnUnsignedShortBlock{
    return Jobs_getAssociatedObject(_returnUnsignedShortBlock);
}

-(void)setReturnUnsignedShortBlock:(JobsReturnByUnsignedShortBlock)returnUnsignedShortBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnUnsignedShortBlock, returnUnsignedShortBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByLongBlock returnLongBlock;/// 返回值为Long的回调
JobsKey(_returnLongBlock)
@dynamic returnLongBlock;
-(JobsReturnByNSIntegerBlock)returnLongBlock{
    return Jobs_getAssociatedObject(_returnLongBlock);
}

-(void)setReturnLongBlock:(JobsReturnByNSIntegerBlock)returnLongBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnLongBlock, returnLongBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByUnsignedLongBlock returnUnsignedLongBlock;/// 返回值为UnsignedLong的回调
JobsKey(_returnUnsignedLongBlock)
@dynamic returnUnsignedLongBlock;
-(JobsReturnByUnsignedLongBlock)returnUnsignedLongBlock{
    return Jobs_getAssociatedObject(_returnUnsignedLongBlock);
}

-(void)setReturnUnsignedLongBlock:(JobsReturnByUnsignedLongBlock)returnUnsignedLongBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnUnsignedLongBlock, returnUnsignedLongBlock)
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByUnsignedLongLongBlock returnUnsignedLongLongBlock;/// 返回值为UnsignedLongLong的回调
JobsKey(_returnUnsignedLongLongBlock)
@dynamic returnUnsignedLongLongBlock;
-(JobsReturnByUnsignedLongLongBlock)returnUnsignedLongLongBlock{
    return Jobs_getAssociatedObject(_returnUnsignedLongLongBlock);
}

-(void)setReturnUnsignedLongLongBlock:(JobsReturnByUnsignedLongLongBlock)returnUnsignedLongLongBlock{
    Jobs_setAssociatedCOPY_NONATOMIC(_returnUnsignedLongLongBlock, returnUnsignedLongLongBlock)
}

@end
