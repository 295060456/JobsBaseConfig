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
#pragma mark —— 无返回值的回调
@property(nonatomic,assign)MKDataBlock objectBlock;
@property(nonatomic,assign)MKDataBlock viewBlock;
@property(nonatomic,assign)MKDataBlock viewControllerBlock;
#pragma mark —— 有返回值的回调
@property(nonatomic,assign)mkDataBlock returnObjectBlock;
@property(nonatomic,assign)mkDataBlock returnViewBlock;
@property(nonatomic,assign)mkDataBlock returnViewControllerBlock;
// 用于任何对象数据的回调
-(void)actionObjectBlock:(MKDataBlock)objectBlock;
-(void)actionReturnObjectBlock:(mkDataBlock)returnObjectBlock;
// 用于UIView数据的回调
-(void)actionViewBlock:(MKDataBlock)viewBlock;
-(void)actionReturnViewBlock:(mkDataBlock)returnViewBlock;
// 用于UIViewController数据的回调
-(void)actionViewControllerBlock:(MKDataBlock)viewControllerBlock;
-(void)actionReturnViewControllerBlock:(mkDataBlock)returnViewControllerBlock;

@end

NS_ASSUME_NONNULL_END
