//
//  CollectionViewAnimationKit.h
//  CollectionViewAnimationKit-OC
//
//  Created by alanwang on 2017/7/11.
//  Copyright © 2017年 com.cn.fql. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "AABlock.h"
#import "MacroDef_Strong@Weak.h"

#import "CollectionViewAnimationKitConfig.h"

@interface CollectionViewAnimationKit : NSObject<UICollisionBehaviorDelegate>
/**
 class method to show the CollectionView animation

 @param animationType : animation type
 @param CollectionView : the CollectionView to show animation
 */
+(void)showWithAnimationType:(XSCollectionViewAnimationType)animationType
              collectionView:(nonnull UICollectionView *)CollectionView;
#pragma mark —— moveAnimation
+(void)moveAnimWithCollectionView:(nonnull UICollectionView *)CollectionView
              animationBlock:(nullable NoResultBlock)animationBlock
             completionBlock:(nullable MKDataBlock)completionBlock;
#pragma mark —— moveSpringAnimation
+(void)moveSpringAnim:(nonnull UICollectionView *)CollectionView
       animationBlock:(nullable NoResultBlock)animationBlock
      completionBlock:(nullable MKDataBlock)completionBlock;
#pragma mark —— alphaAnimation
+(void)alphaAnim:(nonnull UICollectionView *)CollectionView
  animationBlock:(nullable NoResultBlock)animationBlock
 completionBlock:(nullable MKDataBlock)completionBlock;
#pragma mark —— fallAnimation
+(void)fallAnim:(nonnull UICollectionView *)CollectionView
 animationBlock:(nullable NoResultBlock)animationBlock
completionBlock:(nullable MKDataBlock)completionBlock;
#pragma mark —— shakeAnimation
+(void)shakeAnim:(nonnull UICollectionView *)CollectionView
  animationBlock:(nullable NoResultBlock)animationBlock
 completionBlock:(nullable MKDataBlock)completionBlock;
#pragma mark —— overTurnAnimation
+(void)overTurnAnim:(nonnull UICollectionView *)CollectionView
     animationBlock:(nullable NoResultBlock)animationBlock
    completionBlock:(nullable MKDataBlock)completionBlock;
#pragma mark —— toTopAnimation
+(void)toTopAnim:(nonnull UICollectionView *)CollectionView
  animationBlock:(nullable NoResultBlock)animationBlock
 completionBlock:(nullable MKDataBlock)completionBlock;
#pragma mark —— springListAnimation
+(void)springListAnim:(nonnull UICollectionView *)CollectionView
       animationBlock:(nullable NoResultBlock)animationBlock
      completionBlock:(nullable MKDataBlock)completionBlock;
#pragma mark —— shrinkToTopAnimation
+(void)shrinkToTopAnim:(nonnull UICollectionView *)CollectionView
        animationBlock:(nullable NoResultBlock)animationBlock;
#pragma mark —— layDownAnimation
+(void)layDownAnim:(nonnull UICollectionView *)CollectionView
    animationBlock:(nullable NoResultBlock)animationBlock
   completionBlock:(nullable MKDataBlock)completionBlock;
#pragma mark —— roteAnimation
+(void)roteAnim:(nonnull UICollectionView *)CollectionView
 animationBlock:(nullable NoResultBlock)animationBlock
completionBlock:(nullable MKDataBlock)completionBlock;


@end
