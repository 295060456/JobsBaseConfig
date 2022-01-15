//
//  JobsAppDoorInputViewBaseStyle.h
//  My_BaseProj
//
//  Created by Jobs on 2020/12/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobsDoorInputViewProtocol.h"
#import "BaseView.h"
#import "JobsAppDoorInputViewBaseStyleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobsAppDoorInputViewTFModel : NSObject

@property(nonatomic,strong)NSString *resString;
@property(nonatomic,strong)NSString *PlaceHolder;

@end

@interface JobsAppDoorInputViewBaseStyle : BaseView
<
JobsDoorInputViewProtocol
,UITextFieldDelegate
>

@property(nonatomic,strong)JobsAppDoorInputViewTFModel *textFieldInputModel;

@end

NS_ASSUME_NONNULL_END
