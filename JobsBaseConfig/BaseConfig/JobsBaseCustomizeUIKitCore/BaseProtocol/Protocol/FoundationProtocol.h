//
//  FoundationProtocol.h
//  Casino
//
//  Created by Jobs on 2021/12/17.
//

#import <Foundation/Foundation.h>
#import "UIViewModel.h"

NS_ASSUME_NONNULL_BEGIN
/// 自定义的属性写在这一层，切不可写在FoundationProtocol层，如若不然，编译期错误
@protocol FoundationProtocol <NSObject>

@optional

@property(nonatomic,strong,nullable)UIViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
