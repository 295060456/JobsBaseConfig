//
//  UIView+Masonry.h
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/18.
//

#import <UIKit/UIKit.h>
#import "BaseViewProtocol.h"
#if __has_include(<Masonry/Masonry.h>)
#import <Masonry/Masonry.h>
#else
#import "Masonry.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Masonry)<BaseViewProtocol>
/// 卸载当前view上的某个方向的约束
-(void)uninstall:(NSLayoutAttribute)layoutAttribute;
/// 自动卸载当前view上的全部约束
-(void)uninstallAllLayoutAttribute;
/// 通过外界传入的约束包卸载当前view上的约束
-(void)unstallViewConstraint:(NSMutableArray <MASConstraint *>*)constraintMutArr;

@end

NS_ASSUME_NONNULL_END
