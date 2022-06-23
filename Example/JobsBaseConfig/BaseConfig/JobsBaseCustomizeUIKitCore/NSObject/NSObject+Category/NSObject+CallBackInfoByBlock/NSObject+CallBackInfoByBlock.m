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
static char *NSObject_CallBackInfoByBlock_voidBlock = "NSObject_CallBackInfoByBlock_voidBlock";
@dynamic voidBlock;
-(jobsByVoidBlock)voidBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_voidBlock);
}

-(void)setVoidBlock:(jobsByVoidBlock)voidBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_voidBlock,
                             voidBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
/// 2、有（单一）入参、没有返回值的回调
#pragma mark —— @property(nonatomic,assign)jobsByIDBlock objectBlock;/// 入参为ID类型，无返回值的回调
static char *NSObject_CallBackInfoByBlock_objectBlock = "NSObject_CallBackInfoByBlock_objectBlock";
@dynamic objectBlock;
-(jobsByIDBlock)objectBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_objectBlock);
}

-(void)setObjectBlock:(jobsByIDBlock)objectBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_objectBlock,
                             objectBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)jobsBySELBlock selBlock;///入参为SEL，无返回值的回调
static char *NSObject_CallBackInfoByBlock_jobsBySELBlock = "NSObject_CallBackInfoByBlock_jobsBySELBlock";
@dynamic selBlock;
-(jobsBySELBlock)selBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_jobsBySELBlock);
}

-(void)setSelBlock:(jobsBySELBlock)selBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_jobsBySELBlock,
                             selBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)jobsByStringBlock stringBlock;///入参为NSString，无返回值的回调
static char *NSObject_CallBackInfoByBlock_stringBlock = "NSObject_CallBackInfoByBlock_stringBlock";
@dynamic stringBlock;
-(jobsByStringBlock)stringBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_stringBlock);
}

-(void)setStringBlock:(jobsByStringBlock)stringBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_stringBlock,
                             stringBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)jobsByGestureRecognizerBlock gestureRecognizerBlock;/// 入参为UIGestureRecognizer，无返回值的回调
static char *NSObject_CallBackInfoByBlock_gestureRecognizerBlock = "NSObject_CallBackInfoByBlock_gestureRecognizerBlock";
@dynamic gestureRecognizerBlock;
-(jobsByGestureRecognizerBlock)gestureRecognizerBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_gestureRecognizerBlock);
}

-(void)setGestureRecognizerBlock:(jobsByGestureRecognizerBlock)gestureRecognizerBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_gestureRecognizerBlock,
                             gestureRecognizerBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
/// 3、入参为基本数据类型、 且没有返回值的Block定义
#pragma mark —— @property(nonatomic,assign)jobsByNSIntegerBlock NSIntegerBlock;/// 入参为NSInteger，无返回值的回调
static char *NSObject_CallBackInfoByBlock_NSIntegerBlock = "NSObject_CallBackInfoByBlock_NSIntegerBlock";
@dynamic NSIntegerBlock;
-(jobsByNSIntegerBlock)NSIntegerBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_NSIntegerBlock);
}

-(void)setNSIntegerBlock:(jobsByNSIntegerBlock)NSIntegerBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_NSIntegerBlock,
                             NSIntegerBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)jobsByNSUIntegerBlock NSUIntegerBlock;/// 入参为NSUInteger，无返回值的回调
static char *NSObject_CallBackInfoByBlock_NSUIntegerBlock = "NSObject_CallBackInfoByBlock_NSUIntegerBlock";
@dynamic NSUIntegerBlock;
-(jobsByNSUIntegerBlock)NSUIntegerBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_NSUIntegerBlock);
}

-(void)setNSUIntegerBlock:(jobsByNSUIntegerBlock)NSUIntegerBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_NSUIntegerBlock,
                             NSUIntegerBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)jobsByCGFloatBlock CGFloatBlock;/// 入参CGFloat，无返回值的回调
static char *NSObject_CallBackInfoByBlock_CGFloatBlock = "NSObject_CallBackInfoByBlock_CGFloatBlock";
@dynamic CGFloatBlock;
-(jobsByCGFloatBlock)CGFloatBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_CGFloatBlock);
}

-(void)setCGFloatBlock:(jobsByCGFloatBlock)CGFloatBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_CGFloatBlock,
                             CGFloatBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)jobsByBOOLBlock BOOLBlock;/// 入参为BOOL，无返回值的回调
static char *NSObject_CallBackInfoByBlock_BOOLBlock = "NSObject_CallBackInfoByBlock_BOOLBlock";
@dynamic BOOLBlock;
-(jobsByBOOLBlock)BOOLBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_BOOLBlock);
}

-(void)setBOOLBlock:(jobsByBOOLBlock)BOOLBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_BOOLBlock,
                             BOOLBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)jobsByIntBlock IntBlock;/// 入参为Int，无返回值的回调
static char *NSObject_CallBackInfoByBlock_IntBlock = "NSObject_CallBackInfoByBlock_IntBlock";
@dynamic IntBlock;
-(jobsByIntBlock)IntBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_IntBlock);
}

-(void)setIntBlock:(jobsByIntBlock)IntBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_IntBlock,
                             IntBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)jobsByUnsignedIntBlock UnsignedIntBlock;/// 入参为UnsignedInt，无返回值的回调
static char *NSObject_CallBackInfoByBlock_UnsignedIntBlock = "NSObject_CallBackInfoByBlock_UnsignedIntBlock";
@dynamic UnsignedIntBlock;
-(jobsByUnsignedIntBlock)UnsignedIntBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_UnsignedIntBlock);
}

-(void)setUnsignedIntBlock:(jobsByUnsignedIntBlock)UnsignedIntBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_UnsignedIntBlock,
                             UnsignedIntBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)jobsByFloatBlock FloatBlock;/// 入参为Float，无返回值的回调
static char *NSObject_CallBackInfoByBlock_FloatBlock = "NSObject_CallBackInfoByBlock_FloatBlock";
@dynamic FloatBlock;
-(jobsByFloatBlock)FloatBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_FloatBlock);
}

-(void)setFloatBlock:(jobsByFloatBlock)FloatBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_FloatBlock,
                             FloatBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)jobsByDoubleBlock DoubleBlock;/// 入参为Double，无返回值的回调
static char *NSObject_CallBackInfoByBlock_DoubleBlock = "NSObject_CallBackInfoByBlock_DoubleBlock";
@dynamic DoubleBlock;
-(jobsByDoubleBlock)DoubleBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_DoubleBlock);
}

-(void)setDoubleBlock:(jobsByDoubleBlock)DoubleBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_DoubleBlock,
                             DoubleBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)jobsByCharBlock CharBlock;/// 入参为Char，无返回值的回调
static char *NSObject_CallBackInfoByBlock_CharBlock = "NSObject_CallBackInfoByBlock_CharBlock";
@dynamic CharBlock;
-(jobsByCharBlock)CharBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_CharBlock);
}

-(void)setCharBlock:(jobsByCharBlock)CharBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_CharBlock,
                             CharBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)jobsByUnsignedCharBlock UnsignedCharBlock;/// 入参为IUnsignedChar，无返回值的回调
static char *NSObject_CallBackInfoByBlock_UnsignedCharBlock = "NSObject_CallBackInfoByBlock_UnsignedCharBlock";
@dynamic UnsignedCharBlock;
-(jobsByUnsignedCharBlock)UnsignedCharBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_UnsignedCharBlock);
}

-(void)setUnsignedCharBlock:(jobsByUnsignedCharBlock)UnsignedCharBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_UnsignedCharBlock,
                             UnsignedCharBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)jobsByShortBlock ShortBlock;/// 入参为Short，无返回值的回调
static char *NSObject_CallBackInfoByBlock_ShortBlock = "NSObject_CallBackInfoByBlock_ShortBlock";
@dynamic ShortBlock;
-(jobsByShortBlock)ShortBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_ShortBlock);
}

-(void)setShortBlock:(jobsByShortBlock)ShortBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_ShortBlock,
                             ShortBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)jobsByUnsignedShortBlock UnsignedShortBlock;/// 入参为UnsignedShort，无返回值的回调
static char *NSObject_CallBackInfoByBlock_UnsignedShortBlock = "NSObject_CallBackInfoByBlock_UnsignedShortBlock";
@dynamic UnsignedShortBlock;
-(jobsByUnsignedShortBlock)UnsignedShortBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_UnsignedShortBlock);
}

-(void)setUnsignedShortBlock:(jobsByUnsignedShortBlock)UnsignedShortBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_UnsignedShortBlock,
                             UnsignedShortBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)jobsByLongBlock LongBlock;/// 入参为Long，无返回值的回调
static char *NSObject_CallBackInfoByBlock_LongBlock = "NSObject_CallBackInfoByBlock_LongBlock";
@dynamic LongBlock;
-(jobsByLongBlock)LongBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_LongBlock);
}

-(void)setLongBlock:(jobsByLongBlock)LongBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_LongBlock,
                             LongBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)jobsByUnsignedLongBlock UnsignedLongBlock;/// 入参为UnsignedLong，无返回值的回调
static char *NSObject_CallBackInfoByBlock_UnsignedLongBlock = "NSObject_CallBackInfoByBlock_UnsignedLongBlock";
@dynamic UnsignedLongBlock;
-(jobsByUnsignedLongBlock)UnsignedLongBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_UnsignedLongBlock);
}

-(void)setUnsignedLongBlock:(jobsByUnsignedLongBlock)UnsignedLongBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_UnsignedLongBlock,
                             UnsignedLongBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)jobsByUnsignedLongLongBlock UnsignedLongLongBlock;/// 入参为IUnsignedLongLong，无返回值的回调
static char *NSObject_CallBackInfoByBlock_UnsignedLongLongBlock = "NSObject_CallBackInfoByBlock_UnsignedLongLongBlock";
@dynamic UnsignedLongLongBlock;
-(jobsByUnsignedLongLongBlock)UnsignedLongLongBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_UnsignedLongLongBlock);
}

-(void)setUnsignedLongLongBlock:(jobsByUnsignedLongLongBlock)UnsignedLongLongBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_UnsignedLongLongBlock,
                             UnsignedLongLongBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
/// 4、无入参、有返回值的回调
#pragma mark —— @property(nonatomic,assign)JobsReturnIDByVoidBlock returnObjectByVoidBlock;/// 无入参，返回值为ID的回调
static char *NSObject_CallBackInfoByBlock_returnObjectByVoidBlock = "NSObject_CallBackInfoByBlock_returnObjectByVoidBlock";
@dynamic returnObjectByVoidBlock;
-(JobsReturnIDByVoidBlock)returnObjectByVoidBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_returnObjectByVoidBlock);
}

-(void)setReturnObjectByVoidBlock:(JobsReturnIDByVoidBlock)returnObjectByVoidBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_returnObjectByVoidBlock,
                             returnObjectByVoidBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)JobsReturnIDByGestureRecognizerBlock returnObjectByGestureRecognizerBlock;/// 入参为UIGestureRecognizer，返回值为ID的回调
static char *NSObject_CallBackInfoByBlock_returnObjectByGestureRecognizerBlock = "NSObject_CallBackInfoByBlock_returnObjectByGestureRecognizerBlock";
@dynamic returnObjectByGestureRecognizerBlock;
-(JobsReturnIDByGestureRecognizerBlock)returnObjectByGestureRecognizerBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_returnObjectByGestureRecognizerBlock);
}

-(void)setReturnObjectByGestureRecognizerBlock:(JobsReturnIDByGestureRecognizerBlock)returnObjectByGestureRecognizerBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_returnObjectByGestureRecognizerBlock,
                             returnObjectByGestureRecognizerBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark —— @property(nonatomic,assign)JobsReturnIDBySELBlock returnObjectBySELBlock;/// 入参为SEL，返回值为ID的回调
static char *NSObject_CallBackInfoByBlock_returnObjectBySELBlock = "NSObject_CallBackInfoByBlock_returnObjectBySELBlock";
@dynamic returnObjectBySELBlock;
-(JobsReturnIDBySELBlock)returnObjectBySELBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_returnObjectBySELBlock);
}

-(void)setReturnObjectBySELBlock:(JobsReturnIDBySELBlock)returnObjectBySELBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_returnObjectBySELBlock,
                             returnObjectBySELBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)JobsReturnIDByStringBlock returnObjectByStringBlock;/// 入参为NSString，返回值为ID的回调
static char *NSObject_CallBackInfoByBlock_returnObjectByStringBlock = "NSObject_CallBackInfoByBlock_returnObjectByStringBlock";
@dynamic returnObjectByStringBlock;
-(JobsReturnIDByStringBlock)returnObjectByStringBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_returnObjectByStringBlock);
}

-(void)setReturnObjectByStringBlock:(JobsReturnIDByStringBlock)returnObjectByStringBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_returnObjectByStringBlock,
                             returnObjectByStringBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
/// 6、有（单一）入参、有返回值的回调【返回入参类型】
#pragma mark —— @property(nonatomic,assign)JobsReturnIDByIDBlock returnObjectBlock;
static char *NSObject_CallBackInfoByBlock_returnObjectBlock = "NSObject_CallBackInfoByBlock_returnObjectBlock";
@dynamic returnObjectBlock;
-(JobsReturnIDByIDBlock)returnObjectBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_returnObjectBlock);
}

-(void)setReturnObjectBlock:(JobsReturnIDByIDBlock)returnObjectBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_returnObjectBlock,
                             returnObjectBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByNSIntegerBlock returnNSIntegerBlock;/// 返回值为NSInteger的回调
static char *NSObject_CallBackInfoByBlock_returnNSIntegerBlock = "NSObject_CallBackInfoByBlock_returnNSIntegerBlock";
@dynamic returnNSIntegerBlock;
-(JobsReturnByNSIntegerBlock)returnNSIntegerBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_returnNSIntegerBlock);
}

-(void)setReturnNSIntegerBlock:(JobsReturnByNSIntegerBlock)returnNSIntegerBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_returnNSIntegerBlock,
                             returnNSIntegerBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByUIntegerBlock returnNSUIntegerBlock;/// 返回值为UInteger的回调
static char *NSObject_CallBackInfoByBlock_returnNSUIntegerBlock = "NSObject_CallBackInfoByBlock_returnNSUIntegerBlock";
@dynamic returnNSUIntegerBlock;
-(JobsReturnByNSUIntegerBlock)returnNSUIntegerBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_returnNSUIntegerBlock);
}

-(void)setReturnUIntegerBlock:(JobsReturnByNSUIntegerBlock)returnNSUIntegerBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_returnNSUIntegerBlock,
                             returnNSUIntegerBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByCGFloatBlock returnCGFloatBlock;/// 返回值为CGFloat的回调
static char *NSObject_CallBackInfoByBlock_returnCGFloatBlock = "NSObject_CallBackInfoByBlock_returnCGFloatBlock";
@dynamic returnCGFloatBlock;
-(JobsReturnByCGFloatBlock)returnCGFloatBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_returnCGFloatBlock);
}

-(void)setReturnCGFloatBlock:(JobsReturnByCGFloatBlock)returnCGFloatBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_returnCGFloatBlock,
                             returnCGFloatBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByBOOLBlock returnBOOLBlock;/// 返回值为BOOL的回调
static char *NSObject_CallBackInfoByBlock_returnBOOLBlock = "NSObject_CallBackInfoByBlock_returnBOOLBlock";
@dynamic returnBOOLBlock;
-(JobsReturnByBOOLBlock)returnBOOLBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_returnBOOLBlock);
}

-(void)setReturnBOOLBlock:(JobsReturnByBOOLBlock)returnBOOLBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_returnBOOLBlock,
                             returnBOOLBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByIntBlock returnIntBlock;/// 返回值为Int的回调
static char *NSObject_CallBackInfoByBlock_returnIntBlock = "NSObject_CallBackInfoByBlock_returnIntBlock";
@dynamic returnIntBlock;
-(JobsReturnByIntBlock)returnIntBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_returnIntBlock);
}

-(void)setReturnIntBlock:(JobsReturnByIntBlock)returnIntBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_returnIntBlock,
                             returnIntBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByUnsignedIntBlock returnUnsignedIntBlock;/// 返回值为UnsignedInt的回调
static char *NSObject_CallBackInfoByBlock_returnUnsignedIntBlock = "NSObject_CallBackInfoByBlock_returnUnsignedIntBlock";
@dynamic returnUnsignedIntBlock;
-(JobsReturnByUnsignedIntBlock)returnUnsignedIntBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_returnUnsignedIntBlock);
}

-(void)setReturnUnsignedIntBlock:(JobsReturnByUnsignedIntBlock)returnUnsignedIntBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_returnUnsignedIntBlock,
                             returnUnsignedIntBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByFloatBlock returnFloatBlock;/// 返回值为Float的回调
static char *NSObject_CallBackInfoByBlock_returnFloatBlock = "NSObject_CallBackInfoByBlock_returnFloatBlock";
@dynamic returnFloatBlock;
-(JobsReturnByFloatBlock)returnFloatBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_returnFloatBlock);
}

-(void)setReturnFloatBlock:(JobsReturnByFloatBlock)returnFloatBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_returnFloatBlock,
                             returnFloatBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByDoubleBlock returnDoubleBlock;/// 返回值为Double的回调
static char *NSObject_CallBackInfoByBlock_returnDoubleBlock = "NSObject_CallBackInfoByBlock_returnDoubleBlock";
@dynamic returnDoubleBlock;
-(JobsReturnByDoubleBlock)returnDoubleBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_returnDoubleBlock);
}

-(void)setReturnDoubleBlock:(JobsReturnByDoubleBlock)returnDoubleBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_returnDoubleBlock,
                             returnDoubleBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByCharBlock returnCharBlock;/// 返回值为Char的回调
static char *NSObject_CallBackInfoByBlock_returnCharBlock = "NSObject_CallBackInfoByBlock_returnCharBlock";
@dynamic returnCharBlock;
-(JobsReturnByCharBlock)returnCharBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_returnCharBlock);
}

-(void)setReturnCharBlock:(JobsReturnByCharBlock)returnCharBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_returnCharBlock,
                             returnCharBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByUnsignedCharBlock returnUnsignedCharBlock;/// 返回值为UnsignedChar的回调
static char *NSObject_CallBackInfoByBlock_returnUnsignedCharBlock = "NSObject_CallBackInfoByBlock_returnUnsignedCharBlock";
@dynamic returnUnsignedCharBlock;
-(JobsReturnByUnsignedCharBlock)returnUnsignedCharBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_returnUnsignedCharBlock);
}

-(void)setReturnUnsignedCharBlock:(JobsReturnByUnsignedCharBlock)returnUnsignedCharBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_returnUnsignedCharBlock,
                             returnUnsignedCharBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByShortBlock returnShortBlock;/// 返回值为Short的回调
static char *NSObject_CallBackInfoByBlock_returnShortBlock = "NSObject_CallBackInfoByBlock_returnShortBlock";
@dynamic returnShortBlock;
-(JobsReturnByShortBlock)returnShortBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_returnShortBlock);
}

-(void)setReturnShortBlock:(JobsReturnByShortBlock)returnShortBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_returnShortBlock,
                             returnShortBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByUnsignedShortBlock returnUnsignedShortBlock;/// 返回值为UnsignedShort的回调
static char *NSObject_CallBackInfoByBlock_returnUnsignedShortBlock = "NSObject_CallBackInfoByBlock_returnUnsignedShortBlock";
@dynamic returnUnsignedShortBlock;
-(JobsReturnByUnsignedShortBlock)returnUnsignedShortBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_returnUnsignedShortBlock);
}

-(void)setReturnUnsignedShortBlock:(JobsReturnByUnsignedShortBlock)returnUnsignedShortBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_returnUnsignedShortBlock,
                             returnUnsignedShortBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByLongBlock returnLongBlock;/// 返回值为Long的回调
static char *NSObject_CallBackInfoByBlock_returnLongBlock = "NSObject_CallBackInfoByBlock_returnLongBlock";
@dynamic returnLongBlock;
-(JobsReturnByNSIntegerBlock)returnLongBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_returnLongBlock);
}

-(void)setReturnLongBlock:(JobsReturnByNSIntegerBlock)returnLongBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_returnLongBlock,
                             returnLongBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByUnsignedLongBlock returnUnsignedLongBlock;/// 返回值为UnsignedLong的回调
static char *NSObject_CallBackInfoByBlock_returnUnsignedLongBlock = "NSObject_CallBackInfoByBlock_returnUnsignedLongBlock";
@dynamic returnUnsignedLongBlock;
-(JobsReturnByUnsignedLongBlock)returnUnsignedLongBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_returnUnsignedLongBlock);
}

-(void)setReturnUnsignedLongBlock:(JobsReturnByUnsignedLongBlock)returnUnsignedLongBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_returnUnsignedLongBlock,
                             returnUnsignedLongBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)JobsReturnByUnsignedLongLongBlock returnUnsignedLongLongBlock;/// 返回值为UnsignedLongLong的回调
static char *NSObject_CallBackInfoByBlock_returnUnsignedLongLongBlock = "NSObject_CallBackInfoByBlock_returnUnsignedLongLongBlock";
@dynamic returnUnsignedLongLongBlock;
-(JobsReturnByUnsignedLongLongBlock)returnUnsignedLongLongBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_returnUnsignedLongLongBlock);
}

-(void)setReturnUnsignedLongLongBlock:(JobsReturnByUnsignedLongLongBlock)returnUnsignedLongLongBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_returnUnsignedLongLongBlock,
                             returnUnsignedLongLongBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
