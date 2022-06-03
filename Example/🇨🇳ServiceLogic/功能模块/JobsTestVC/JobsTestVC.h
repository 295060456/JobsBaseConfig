//
//  JobsTestVC.h
//  JobsBaseConfig
//
//  Created by Jobs on 2022/6/3.
//

#import "BaseViewController.h"
#import "MsgTBVCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobsTestVC : BaseViewController
<
BaseViewProtocol
,UITableViewDelegate
,UITableViewDataSource
>

@end

NS_ASSUME_NONNULL_END
