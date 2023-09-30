//
//  CollectionViewCell.h
//  UBallLive
//
//  Created by Jobs on 2020/10/18.
//

#import <UIKit/UIKit.h>
#import "MacroDef_Func.h"
#import "UIView+Extras.h"
#import "UICollectionViewCellProtocol.h"
#import "UICollectionViewCell+ShakeAnimation.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseCollectionViewCell : UICollectionViewCell<UICollectionViewCellProtocol>

@property(nonatomic,assign)BOOL forceUsetextView;
@property(nonatomic,assign)BOOL forceUseBgBtn;

/// 利用UIBezierPath，对 UICollectionViewCell 描边 + 切角
/// 作用域 ：- (void)drawRect:(CGRect)rect
/// - Parameters:
///   - borderSideType: 描边方位
///   - cellBackgroundCor: UICollectionViewCell 的背景色
///   - borderColor: 描边颜色
///   - borderWidth: 描边线宽
///   - cornerRadiusSize: 切角弧度
///   - roundingCorners: 切角方位
-(void)outlineByBezierPath:(UIBorderSideType)borderSideType
         cellBackgroundCor:(UIColor *)cellBackgroundCor
               borderColor:(UIColor *)borderColor
               borderWidth:(CGFloat)borderWidth
          cornerRadiusSize:(CGSize)cornerRadiusSize
           roundingCorners:(UIRectCorner)roundingCorners;
/// 利用CALayer，对 UICollectionViewCell 只描边、不切角
/// 作用域 ：- (void)drawRect:(CGRect)rect
/// - Parameters:
///   - borderSideType: 描边方位
///   - borderColor: 描边颜色
///   - borderWidth: 描边线宽
-(void)outlineByLayer:(UIBorderSideType)borderSideType
          borderColor:(UIColor *)borderColor
          borderWidth:(CGFloat)borderWidth;

@end

NS_ASSUME_NONNULL_END
