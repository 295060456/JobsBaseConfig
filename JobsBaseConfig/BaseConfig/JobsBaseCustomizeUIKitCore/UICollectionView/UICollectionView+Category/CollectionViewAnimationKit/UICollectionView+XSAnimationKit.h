//
//  UICollectionView+XSAnimationKit.h
//  CollectionViewAnimationKit-OC
//
//  Created by 王小树 on 17/9/9.
//  Copyright © 2017年 com.cn.fql. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CollectionViewAnimationKitConfig.h"
#import "CollectionViewAnimationKit.h"

@interface UICollectionView (XSAnimationKit)
/**
 show the CollectionView animation
 
 @param animationType type of animation to show CollectionView
 */
- (void)xs_showCollectionViewAnimationWithType:(XSCollectionViewAnimationType )animationType;

@end
