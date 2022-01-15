//
//  JobsAppDoorInputViewBaseStyle_5.h
//  DouDong-II
//
//  Created by Jobs on 2020/12/17.
//

#import "BaseViewProtocol.h"
#import "JobsDoorInputViewProtocol.h"
#import "JobsAppDoorInputViewBaseStyle.h"
#import "ZYTextField.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    InputViewStyle_5_1 = 0,
    InputViewStyle_5_2
} InputViewStyle_5;
/// 输入框样式_5
@interface JobsAppDoorInputViewBaseStyle_5 : JobsAppDoorInputViewBaseStyle

@property(nonatomic,assign)InputViewStyle_5 style_5;

@end

NS_ASSUME_NONNULL_END
