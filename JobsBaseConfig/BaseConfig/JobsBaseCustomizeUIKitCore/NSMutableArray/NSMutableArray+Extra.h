//
//  NSMutableArray+Extra.h
//  Casino
//
//  Created by Jobs on 2022/1/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (Extra)
/// 将数组里的某个元素移动到原数组的某个位
-(NSMutableArray *_Nullable)moveElementFromIndex:(NSInteger)fromIndex
                                         toIndex:(NSInteger)toIndex;

@end

NS_ASSUME_NONNULL_END
