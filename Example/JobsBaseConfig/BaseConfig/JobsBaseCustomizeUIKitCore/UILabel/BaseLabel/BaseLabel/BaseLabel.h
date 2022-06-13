//
//  AutoScrollLabel.h
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/18.
//

#import <UIKit/UIKit.h>
#import "UIView+Extras.h"
#import "UILabel+Extra.h"
#import "BaseViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN
/**
 自定义UILabel 实现显示偏移量和内边距
 https://www.jianshu.com/p/541ef795a1f2
 */
@interface BaseLabel : UILabel<BaseViewProtocol>

@property(nonatomic,assign)UIEdgeInsets edgeInsets;
@property(nonatomic,assign)CGFloat offsetY;
@property(nonatomic,assign)CGFloat offsetX;

@end

NS_ASSUME_NONNULL_END
