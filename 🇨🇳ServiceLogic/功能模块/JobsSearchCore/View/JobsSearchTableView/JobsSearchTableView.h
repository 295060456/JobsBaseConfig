//
//  JobsSearchTableView.h
//  JobsSearch
//
//  Created by Jobs on 2020/10/6.
//

#import <UIKit/UIKit.h>
#import "BaseViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobsSearchTableView : UITableView
<
BaseViewProtocol
,UIGestureRecognizerDelegate
>

@end

NS_ASSUME_NONNULL_END
