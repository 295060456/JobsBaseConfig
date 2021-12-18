//
//  NSObject+Association.h
//  Casino
//
//  Created by Jobs on 2021/12/17.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Association)

void objc_setAssociatedObject_weak(id _Nonnull object,
                              const void * _Nonnull key,
                              id _Nullable value,
                              objc_AssociationPolicy associationPolicy);

@end

NS_ASSUME_NONNULL_END
