//
//  JobsAppDoorInputViewBaseStyle_1.h
//  My_BaseProj
//
//  Created by Jobs on 2020/12/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseViewProtocol.h"
#import "JobsDoorInputViewProtocol.h"
#import "JobsAppDoorInputViewBaseStyleModel.h"
#import "JobsAppDoorInputViewBaseStyle.h"
#import "UIButton+Timer.h"
#import "JobsMagicTextField.h"

NS_ASSUME_NONNULL_BEGIN
/// 输入框样式_1
@interface JobsAppDoorInputViewBaseStyle_1 : JobsAppDoorInputViewBaseStyle
/// 倒计时按钮（需要销毁定时器）
-(UIButton *)getCountDownBtn;

@end

NS_ASSUME_NONNULL_END
