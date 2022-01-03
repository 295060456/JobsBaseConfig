//
//  JobsAppDoorInputViewBaseStyle_2.h
//  My_BaseProj
//
//  Created by Jobs on 2020/12/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JobsDoorInputViewProtocol.h"
#import "BaseViewProtocol.h"
#import "JobsAppDoorInputViewBaseStyleModel.h"
#import "JobsAppDoorInputViewBaseStyle.h"
#import "ImageCodeView.h"
#import "JobsMagicTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobsAppDoorInputViewBaseStyle_2 : JobsAppDoorInputViewBaseStyle
<
UITextFieldDelegate
,JobsDoorInputViewProtocol
>

-(void)changeTextFieldAnimationColor:(BOOL)toRegisterBtnSelected;

@end

NS_ASSUME_NONNULL_END
