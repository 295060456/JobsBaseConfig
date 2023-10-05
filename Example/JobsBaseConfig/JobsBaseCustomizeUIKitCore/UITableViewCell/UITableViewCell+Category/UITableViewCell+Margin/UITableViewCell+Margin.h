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
#pragma mark —— 一些公有的功能方法

@end

NS_ASSUME_NONNULL_END
