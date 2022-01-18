//
//  UIView+Masonry.h
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Masonry)

/// 卸载当前view上的某个方向的约束
-(void)uninstall:(NSLayoutAttribute)layoutAttribute;

@end

NS_ASSUME_NONNULL_END
