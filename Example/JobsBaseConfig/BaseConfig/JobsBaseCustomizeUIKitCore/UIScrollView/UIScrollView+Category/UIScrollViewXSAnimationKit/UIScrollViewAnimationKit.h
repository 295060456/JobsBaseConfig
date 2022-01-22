//
//  UIScrollViewAnimationKit.h
//  Casino
//
//  Created by Jobs on 2022/1/7.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "JobsBlock.h"
#import "MacroDef_Strong@Weak.h"

#import "UIScrollView+Extra.h"
#import "UIScrollViewAnimationKitConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollViewAnimationKit : NSObject<UICollisionBehaviorDelegate>
/**
 class method to show the tableView animation

 @param animationType : animation type
 @param scrollView : the scrollView to show animation
 */
+(void)showWithAnimationType:(XSScrollViewAnimationType)animationType
                  scrollView:(nonnull UIScrollView *)scrollView;
#pragma mark —— moveAnimation
+(void)moveAnimationWithScrollView:(nonnull UIScrollView *)scrollView;

+(void)moveAnimWithScrollView:(nonnull UIScrollView *)scrollView
               animationBlock:(nullable NoResultBlock)animationBlock
              completionBlock:(nullable MKDataBlock)completionBlock;
#pragma mark —— moveSpringAnimation
+(void)moveSpringAnimationWithCollectionView:(nonnull UIScrollView *)scrollView;

+(void)moveSpringAnim:(nonnull UIScrollView *)scrollView
       animationBlock:(nullable NoResultBlock)animationBlock
      completionBlock:(nullable MKDataBlock)completionBlock;
#pragma mark —— alphaAnimation
+(void)alphaAnimationWithCollectionView:(nonnull UIScrollView *)scrollView;

+(void)alphaAnim:(nonnull UIScrollView *)scrollView
  animationBlock:(nullable NoResultBlock)animationBlock
 completionBlock:(nullable MKDataBlock)completionBlock;
#pragma mark —— fallAnimation
+(void)fallAnimationWithCollectionView:(nonnull UIScrollView *)scrollView;

+(void)fallAnim:(nonnull UIScrollView *)scrollView
 animationBlock:(nullable NoResultBlock)animationBlock
completionBlock:(nullable MKDataBlock)completionBlock;
#pragma mark —— shakeAnimation
+(void)shakeAnimationWithCollectionView:(nonnull UIScrollView *)scrollView;

+(void)shakeAnim:(nonnull UIScrollView *)scrollView
  animationBlock:(nullable NoResultBlock)animationBlock
 completionBlock:(nullable MKDataBlock)completionBlock;
#pragma mark —— overTurnAnimation
+(void)overTurnAnimationWithCollectionView:(nonnull UIScrollView *)scrollView;

+(void)overTurnAnim:(nonnull UIScrollView *)scrollView
     animationBlock:(nullable NoResultBlock)animationBlock
    completionBlock:(nullable MKDataBlock)completionBlock;
#pragma mark —— toTopAnimation
+(void)toTopAnimationWithCollectionView:(nonnull UIScrollView *)scrollView;

+(void)toTopAnim:(nonnull UIScrollView *)scrollView
  animationBlock:(nullable NoResultBlock)animationBlock
 completionBlock:(nullable MKDataBlock)completionBlock;
#pragma mark —— springListAnimation
+(void)springListAnimationWithCollectionView:(nonnull UIScrollView *)scrollView;

+(void)springListAnim:(nonnull UIScrollView *)scrollView
       animationBlock:(nullable NoResultBlock)animationBlock
      completionBlock:(nullable MKDataBlock)completionBlock;
#pragma mark —— shrinkToTopAnimation
+(void)shrinkToTopAnimationWithCollectionView:(nonnull UIScrollView *)scrollView;

+(void)shrinkToTopAnim:(nonnull UIScrollView *)scrollView
        animationBlock:(nullable NoResultBlock)animationBlock;
#pragma mark —— layDownAnimation
+(void)layDownAnimationWithCollectionView:(nonnull UIScrollView *)scrollView;

+(void)layDownAnim:(nonnull UIScrollView *)scrollView
    animationBlock:(nullable NoResultBlock)animationBlock
   completionBlock:(nullable MKDataBlock)completionBlock;
#pragma mark —— roteAnimation
+(void)roteAnimationWithCollectionView:(nonnull UIScrollView *)scrollView;

+(void)roteAnim:(nonnull UIScrollView *)scrollView
 animationBlock:(nullable NoResultBlock)animationBlock
completionBlock:(nullable MKDataBlock)completionBlock;

@end

NS_ASSUME_NONNULL_END
