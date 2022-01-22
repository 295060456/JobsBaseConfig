//
//  UILabel+Extra.h
//  Casino
//
//  Created by Jobs on 2021/12/27.
//

#import <UIKit/UIKit.h>
#import "JobsLabelDef.h"
#import "UIView+Masonry.h"
#import "UIView+AutoSelfAdaptionSize.h"

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Extra)

@property(nonatomic,assign)UILabelShowingType labelShowingType;

-(void)lbBackgroundImage:(UIImage *)bgImage;
/**
 在Masonry以后拿到了frame
 */
-(void)makeLabelByShowingType:(UILabelShowingType)labelShowingType;

@end

NS_ASSUME_NONNULL_END
