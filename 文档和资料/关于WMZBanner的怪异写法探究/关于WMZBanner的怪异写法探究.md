# 关于WMZBanner的怪异写法探究

## 1、看懂宏定义

*定义部分*

```objective-c
#define WMZBannerPropSetFuncImplementation(className,propertyPointerType,propertyName)                                       - (className * (^) (propertyPointerType propertyName))propertyName##Set{ \
return ^(propertyPointerType propertyName) { \
self->_##propertyName = propertyName; \
return self; \
}; \
}
```

*调用环节*

```objective-c
WMZBannerPropSetFuncImplementation(NSMutableArray, int, ss); 
```

*以上写法等同于👇🏻*

```objective-c
- (NSMutableArray * (^)(int ss))ssSet{
    return ^(int ss) {
        self->_ss = ss;
        return self;
    };
}
```

## 2、点语法的外界调用

*定义部分*

```objective-c
typedef id(^JobsReturnIDByIDBlock)(id data);
```

```objective-c
/// 用于 @interface
#define JobsInterface(className,propertyModifier,propertyPointerType,propertyName) \
@property(nonatomic,propertyModifier)propertyPointerType  propertyName; \
-(className *(^)(propertyPointerType propertyName)) propertyName##Set;
```

```objective-c
/// 用于 @implementation
#define JobsImplementation(className,propertyPointerType,propertyName) \
- (className * (^) (propertyPointerType propertyName))propertyName##Set{ \
return ^(propertyPointerType propertyName) { \
self->_##propertyName = propertyName; \
return self; \
}; \
}
```

*Hello.h文件*

```objective-c
#import <Foundation/Foundation.h>
#import "WMZBannerConfig.h"
#import "JobsBlock.h"

NS_ASSUME_NONNULL_BEGIN
@interface Hello : NSObject
JobsInterface(Hello, assign, JobsReturnIDByIDBlock, block)
@end
NS_ASSUME_NONNULL_END
```

*Hello.m文件*

```objective-c
#import "Hello.h"

@implementation Hello
JobsImplementation(Hello, JobsReturnIDByIDBlock, block)
@end
```

*调用环节*

*在其他的类引入Hello.h*

```objective-c
Hello *hello = Hello.new.blockSet(^(id data) {
	return @"";
});
```
