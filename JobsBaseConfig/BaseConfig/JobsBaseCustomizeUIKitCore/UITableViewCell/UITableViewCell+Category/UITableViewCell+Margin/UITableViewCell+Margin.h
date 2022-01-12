//
//  UITableViewCell+Margin.h
//  JobsIM
//
//  Created by Jobs on 2020/11/13.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "BaseCellProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (Margin)
<
BaseCellProtocol
,UIViewModelProtocol
>

@end

NS_ASSUME_NONNULL_END
