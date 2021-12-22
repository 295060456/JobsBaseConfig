//
//  UICollectionView+XSAnimationKit.m
//  CollectionViewAnimationKit-OC
//
//  Created by 王小树 on 17/9/9.
//  Copyright © 2017年 com.cn.fql. All rights reserved.
//

#import "UICollectionView+XSAnimationKit.h"

@implementation UICollectionView (XSAnimationKit)

-(void)xs_showCollectionViewAnimationWithType:(XSCollectionViewAnimationType)animationType{
    [CollectionViewAnimationKit showWithAnimationType:animationType collectionView:self];
}

@end
