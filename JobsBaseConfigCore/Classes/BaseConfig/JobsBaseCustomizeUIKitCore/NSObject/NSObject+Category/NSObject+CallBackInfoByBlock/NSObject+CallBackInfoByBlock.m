//
//  NSObject+CallBackInfoByBlock.m
//  DouDong-II
//
//  Created by Jobs on 2021/2/26.
//

#import "NSObject+CallBackInfoByBlock.h"

@implementation NSObject (CallBackInfoByBlock)
#pragma mark —— 无返回值的回调
static char *NSObject_CallBackInfoByBlock_objectBlock = "NSObject_CallBackInfoByBlock_objectBlock";
@dynamic objectBlock;

static char *NSObject_CallBackInfoByBlock_viewBlock = "NSObject_CallBackInfoByBlock_viewBlock";
@dynamic viewBlock;

static char *NSObject_CallBackInfoByBlock_viewControllerBlock = "NSObject_CallBackInfoByBlock_viewControllerBlock";
@dynamic viewControllerBlock;
#pragma mark —— 有返回值的回调
static char *NSObject_CallBackInfoByBlock_returnObjectBlock = "NSObject_CallBackInfoByBlock_returnObjectBlock";
@dynamic returnObjectBlock;

static char *NSObject_CallBackInfoByBlock_returnViewBlock = "NSObject_CallBackInfoByBlock_returnViewBlock";
@dynamic returnViewBlock;

static char *NSObject_CallBackInfoByBlock_returnViewControllerBlock = "NSObject_CallBackInfoByBlock_returnViewControllerBlock";
@dynamic returnViewControllerBlock;
// 用于任何对象数据的回调
-(void)actionObjectBlock:(MKDataBlock)objectBlock{
    self.objectBlock = objectBlock;
}

-(void)actionReturnObjectBlock:(mkDataBlock)returnObjectBlock{
    self.returnObjectBlock = returnObjectBlock;
}
// 用于UIView数据的回调
-(void)actionViewBlock:(MKDataBlock)viewBlock{
    self.viewBlock = viewBlock;
}

-(void)actionReturnViewBlock:(mkDataBlock)returnViewBlock{
    self.returnViewBlock = returnViewBlock;
}
// 用于UIViewController数据的回调
-(void)actionViewControllerBlock:(MKDataBlock)viewControllerBlock{
    self.viewControllerBlock = viewControllerBlock;
}

-(void)actionReturnViewControllerBlock:(mkDataBlock)returnViewControllerBlock{
    self.returnViewControllerBlock = returnViewControllerBlock;
}
#pragma mark —— @property(nonatomic,assign)MKDataBlock objectBlock;
-(MKDataBlock)objectBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_objectBlock);
}

-(void)setObjectBlock:(MKDataBlock)objectBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_objectBlock,
                             objectBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)MKDataBlock viewBlock;
-(MKDataBlock)viewBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_viewBlock);
}

-(void)setViewBlock:(MKDataBlock)viewBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_viewBlock,
                             viewBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)MKDataBlock viewControllerBlock;
-(MKDataBlock)viewControllerBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_viewControllerBlock);
}

-(void)setViewControllerBlock:(MKDataBlock)viewControllerBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_viewControllerBlock,
                             viewControllerBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)mkDataBlock returnObjectBlock;
-(mkDataBlock)returnObjectBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_returnObjectBlock);
}

-(void)setReturnObjectBlock:(mkDataBlock)returnObjectBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_returnObjectBlock,
                             returnObjectBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)mkDataBlock returnViewBlock;
-(mkDataBlock)returnViewBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_returnViewBlock);
}

-(void)setReturnViewBlock:(mkDataBlock)returnViewBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_returnViewBlock,
                             returnViewBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)mkDataBlock returnViewControllerBlock;
-(mkDataBlock)returnViewControllerBlock{
    return objc_getAssociatedObject(self, NSObject_CallBackInfoByBlock_returnViewControllerBlock);
}

-(void)setReturnViewControllerBlock:(mkDataBlock)returnViewControllerBlock{
    objc_setAssociatedObject(self,
                             NSObject_CallBackInfoByBlock_returnViewControllerBlock,
                             returnViewControllerBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
