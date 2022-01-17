//
//  NSArray+Extension.m
//  Clipyeu ++
//
//  Created by Josee on 22/03/2019.
//  Copyright © 2019 Josee. All rights reserved.
//

#import "NSArray+Safety.h"

@implementation NSArray (Safety)

+ (void)load{
    [super load];
    /// 替换不可变数组中的方法 objectAtIndex
    MethodSwizzle(objc_getClass("__NSArrayI"),
                  @selector(objectAtIndex:),
                  @selector(newObjectAtIndex:));
    /// 替换不可变数组中的方法 []调用的方法
    MethodSwizzle(objc_getClass("__NSArrayI"),
                  @selector(objectAtIndexedSubscript:),
                  @selector(newObjectAtIndexedSubscript:));
    /// 替换可变数组中的方法 objectAtIndex
    MethodSwizzle(objc_getClass("__NSArrayI"),
                  @selector(objectAtIndex:),
                  @selector(newMutableObjectAtIndex:));
    
    /// 替换可变数组中的方法  []调用的方法
    MethodSwizzle(objc_getClass("__NSArrayI"),
                  @selector(objectAtIndexedSubscript:),
                  @selector(newMutableObjectAtIndexedSubscript:));
}

- (id)newObjectAtIndex:(NSUInteger)index{
    if (index > self.count - 1 || !self.count){
        @try {
            return [self newObjectAtIndex:index];
        } @catch (NSException *exception) {
            NSLog(@"不可数组越界了");
            return nil;
        } @finally {
            
        }
    }else return [self newObjectAtIndex:index];
}

- (id)newObjectAtIndexedSubscript:(NSUInteger)index{
    if (index > self.count - 1 || !self.count){
        @try {
            return [self newObjectAtIndexedSubscript:index];
        } @catch (NSException *exception) {
            NSLog(@"不可数组越界了");
            return nil;
        } @finally {
        }
    }else return [self newObjectAtIndexedSubscript:index];
}

- (id)newMutableObjectAtIndex:(NSUInteger)index{
    if (index > self.count - 1 || !self.count){
        @try {
            return [self newMutableObjectAtIndex:index];
        } @catch (NSException *exception) {
            NSLog(@"可变数组越界了");
            return nil;
        } @finally {}
    } else return [self newMutableObjectAtIndex:index];
}

- (id)newMutableObjectAtIndexedSubscript:(NSUInteger)index{
    if (index > self.count - 1 || !self.count){
        @try {
            return [self newMutableObjectAtIndexedSubscript:index];
        } @catch (NSException *exception) {
            NSLog(@"可变数组越界了");
            return nil;
        } @finally {}
    }else return [self newMutableObjectAtIndexedSubscript:index];
}

@end
