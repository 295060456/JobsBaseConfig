//
//  ViewForTableViewHeader.h
//  UBallLive
//
//  Created by Jobs on 2020/10/27.
//

#import <UIKit/UIKit.h>
#import "JobsBlock.h"
#import "BaseProtocol.h"
#import "BaseViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewHeaderView : UITableViewHeaderFooterView
<
BaseViewProtocol,
BaseProtocol
>

@end

NS_ASSUME_NONNULL_END
