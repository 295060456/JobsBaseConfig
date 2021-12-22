//
//  CollectionViewAnimationKit.m
//  CollectionViewAnimationKit-OC
//
//  Created by alanwang on 2017/7/11.
//  Copyright © 2017年 com.cn.fql. All rights reserved.
//

#import "CollectionViewAnimationKit.h"

#define XS_SCREEN_WIDTH UIScreen.mainScreen.bounds.size.width
#define XS_SCREEN_HEIGHT UIScreen.mainScreen.bounds.size.height

@interface CollectionViewAnimationKit ()

@end

@implementation CollectionViewAnimationKit

+(void)showWithAnimationType:(XSCollectionViewAnimationType)animationType
              collectionView:(nonnull UICollectionView *)collectionView{
    unsigned int count = 0;
    Method *methodlist = class_copyMethodList(object_getClass(self.class), &count);
    int tag= 0;
    for (int i = 0; i < count; i++) {
        Method method = methodlist[i];
        SEL selector = method_getName(method);
        NSString *methodName = NSStringFromSelector(selector);
        if ([methodName rangeOfString:@"AnimationWithCollectionView"].location != NSNotFound) {
            if (tag == animationType) {
                ((void (*)(id,SEL,UICollectionView *))objc_msgSend)(self,selector,collectionView);
                break;
            }tag++;
        }
    }free(methodlist);
}
#pragma mark —— moveAnimation
+(void)moveAnimationWithCollectionView:(nonnull UICollectionView *)CollectionView{
    [self moveAnimWithCollectionView:CollectionView
                 animationBlock:nil
                completionBlock:nil];
}

+(void)moveAnimWithCollectionView:(nonnull UICollectionView *)CollectionView
              animationBlock:(nullable NoResultBlock)animationBlock
             completionBlock:(nullable MKDataBlock)completionBlock{

    NSArray *cells = CollectionView.visibleCells;
    for (int i = 0; i < cells.count; i++) {
        CGFloat totalTime = 0.3;
        UICollectionViewCell *cell = [CollectionView.visibleCells objectAtIndex:i];
        cell.transform = CGAffineTransformMakeTranslation(-XS_SCREEN_WIDTH, 0);
        @jobs_weakify(cell)
        [UIView animateWithDuration:0.25
                              delay:i * (totalTime/cells.count)
                            options:0
                         animations:^{
            @jobs_strongify(cell)
            cell.transform = CGAffineTransformIdentity;
            if (animationBlock) animationBlock();
        } completion:^(BOOL finished) {
            if (completionBlock) completionBlock(@(finished));
        }];
    }
}
#pragma mark —— moveSpringAnimation
+(void)moveSpringAnimationWithCollectionView:(nonnull UICollectionView *)CollectionView{
    [self moveSpringAnim:CollectionView
          animationBlock:nil
         completionBlock:nil];
}

+(void)moveSpringAnim:(nonnull UICollectionView *)CollectionView
       animationBlock:(nullable NoResultBlock)animationBlock
      completionBlock:(nullable MKDataBlock)completionBlock{
    NSArray *cells = CollectionView.visibleCells;
    for (int i = 0; i < cells.count; i++) {
        CGFloat totalTime = 0.4;
        UICollectionViewCell *cell = [CollectionView.visibleCells objectAtIndex:i];
        cell.transform = CGAffineTransformMakeTranslation(-XS_SCREEN_WIDTH, 0);
        @jobs_weakify(cell)
        [UIView animateWithDuration:0.4
                              delay:i*(totalTime/cells.count)
             usingSpringWithDamping:0.7
              initialSpringVelocity:1/0.7
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
            @jobs_strongify(cell)
            cell.transform = CGAffineTransformIdentity;
            if (animationBlock) animationBlock();
        } completion:^(BOOL finished) {
            if (completionBlock) completionBlock(@(finished));
        }];
    }
}
#pragma mark —— alphaAnimation
+(void)alphaAnimationWithCollectionView:(nonnull UICollectionView *)CollectionView{
    [self alphaAnim:CollectionView
     animationBlock:nil
    completionBlock:nil];
}

+(void)alphaAnim:(nonnull UICollectionView *)CollectionView
  animationBlock:(nullable NoResultBlock)animationBlock
 completionBlock:(nullable MKDataBlock)completionBlock{
    NSArray *cells = CollectionView.visibleCells;
    for (int i = 0; i < cells.count; i++) {
        UICollectionViewCell *cell = [CollectionView.visibleCells objectAtIndex:i];
        cell.alpha = 0.0;
        @jobs_weakify(cell)
        [UIView animateWithDuration:0.3
                              delay:i * 0.05
                            options:0
                         animations:^{
            @jobs_strongify(cell)
            cell.alpha = 1.0;
            if (animationBlock) animationBlock();
        } completion:^(BOOL finished) {
            if (completionBlock) completionBlock(@(finished));
        }];
    }
}
#pragma mark —— fallAnimation
+(void)fallAnimationWithCollectionView:(nonnull UICollectionView *)CollectionView{
    [self fallAnim:CollectionView
    animationBlock:nil
   completionBlock:nil];
}

+(void)fallAnim:(nonnull UICollectionView *)CollectionView
 animationBlock:(nullable NoResultBlock)animationBlock
    completionBlock:(nullable MKDataBlock)completionBlock{
    NSArray *cells = CollectionView.visibleCells;
    NSTimeInterval totalTime = 0.8;
    for (int i = 0; i < cells.count; i++) {
        UICollectionViewCell *cell = [CollectionView.visibleCells objectAtIndex:i];
        cell.transform = CGAffineTransformMakeTranslation(0, - XS_SCREEN_HEIGHT);
        @jobs_weakify(cell)
        [UIView animateWithDuration:0.3
                              delay:(cells.count - i) * (totalTime / cells.count)
                            options:0
                         animations:^{
            @jobs_strongify(cell)
            cell.transform = CGAffineTransformIdentity;
            if (animationBlock) animationBlock();
        } completion:^(BOOL finished) {
            if (completionBlock) completionBlock(@(finished));
        }];
    }
}
#pragma mark —— shakeAnimation
+(void)shakeAnimationWithCollectionView:(nonnull UICollectionView *)CollectionView{
    [self shakeAnim:CollectionView
     animationBlock:nil
    completionBlock:nil];
}

+(void)shakeAnim:(nonnull UICollectionView *)CollectionView
  animationBlock:(nullable NoResultBlock)animationBlock
 completionBlock:(nullable MKDataBlock)completionBlock{
    NSArray *cells = CollectionView.visibleCells;
    for (int i = 0; i < cells.count; i++) {
        UICollectionViewCell *cell = [cells objectAtIndex:i];
        if (i % 2 == 0) {
            cell.transform = CGAffineTransformMakeTranslation(-XS_SCREEN_WIDTH,0);
        }else {
            cell.transform = CGAffineTransformMakeTranslation(XS_SCREEN_WIDTH,0);
        }
        @jobs_weakify(cell)
        [UIView animateWithDuration:0.4
                              delay:i * 0.03
             usingSpringWithDamping:0.75
              initialSpringVelocity:1 / 0.75
                            options:0
                         animations:^{
            @jobs_strongify(cell)
            cell.transform = CGAffineTransformIdentity;
            if (animationBlock) animationBlock();
        } completion:^(BOOL finished) {
            if (completionBlock) completionBlock(@(finished));
        }];
    }
}
#pragma mark —— overTurnAnimation
+(void)overTurnAnimationWithCollectionView:(nonnull UICollectionView *)CollectionView{
    [self overTurnAnim:CollectionView
        animationBlock:nil
       completionBlock:nil];
}

+(void)overTurnAnim:(nonnull UICollectionView *)CollectionView
     animationBlock:(nullable NoResultBlock)animationBlock
    completionBlock:(nullable MKDataBlock)completionBlock{
    NSArray *cells = CollectionView.visibleCells;
    for (int i = 0; i < cells.count; i++) {
        UICollectionViewCell *cell = [cells objectAtIndex:i];
        cell.layer.opacity = 0.0;
        cell.layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
        NSTimeInterval totalTime = 0.7;
        @jobs_weakify(cell)
        [UIView animateWithDuration:0.3
                              delay:i * (totalTime / cells.count)
                            options:0
                         animations:^{
            @jobs_strongify(cell)
            cell.layer.opacity = 1.0;
            cell.layer.transform = CATransform3DIdentity;
            if (animationBlock) animationBlock();
        } completion:^(BOOL finished) {
            if (completionBlock) completionBlock(@(finished));
        }];
    }
}
#pragma mark —— toTopAnimation
+(void)toTopAnimationWithCollectionView:(nonnull UICollectionView *)CollectionView{
    [self toTopAnim:CollectionView
     animationBlock:nil
    completionBlock:nil];
}

+(void)toTopAnim:(nonnull UICollectionView *)CollectionView
  animationBlock:(nullable NoResultBlock)animationBlock
 completionBlock:(nullable MKDataBlock)completionBlock{
    NSArray *cells = CollectionView.visibleCells;
    NSTimeInterval totalTime = 0.8;
    for (int i = 0; i < cells.count; i++) {
        UICollectionViewCell *cell = [CollectionView.visibleCells objectAtIndex:i];
        cell.transform = CGAffineTransformMakeTranslation(0,XS_SCREEN_HEIGHT);
        @jobs_weakify(cell)
        [UIView animateWithDuration:0.35
                              delay:i*(totalTime/cells.count)
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
            @jobs_strongify(cell)
            cell.transform = CGAffineTransformIdentity;
            if (animationBlock) animationBlock();
        } completion:^(BOOL finished) {
            if (completionBlock) completionBlock(@(finished));
        }];
    }
}
#pragma mark —— springListAnimation
+(void)springListAnimationWithCollectionView:(nonnull UICollectionView *)CollectionView{
    [self springListAnim:CollectionView
          animationBlock:nil
         completionBlock:nil];
}

+(void)springListAnim:(nonnull UICollectionView *)CollectionView
       animationBlock:(nullable NoResultBlock)animationBlock
      completionBlock:(nullable MKDataBlock)completionBlock{
    NSArray *cells = CollectionView.visibleCells;
    for (int i = 0; i < cells.count; i++) {
        UICollectionViewCell *cell = [cells objectAtIndex:i];
        cell.layer.opacity = 0.7;
        cell.layer.transform = CATransform3DMakeTranslation(0, -XS_SCREEN_HEIGHT, 20);
        NSTimeInterval totalTime = 1.0;
        @jobs_weakify(cell)
        [UIView animateWithDuration:0.4
                              delay:i * (totalTime/cells.count)
             usingSpringWithDamping:0.65
              initialSpringVelocity:1 / 0.65
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
            @jobs_strongify(cell)
            cell.layer.opacity = 1.0;
            cell.layer.transform = CATransform3DMakeTranslation(0, 0, 20);
            if (animationBlock) animationBlock();
        } completion:^(BOOL finished) {
            if (completionBlock) completionBlock(@(finished));
        }];
    }
}
#pragma mark —— shrinkToTopAnimation
+(void)shrinkToTopAnimationWithCollectionView:(nonnull UICollectionView *)CollectionView{
    [self shrinkToTopAnim:CollectionView animationBlock:nil];
}

+(void)shrinkToTopAnim:(nonnull UICollectionView *)CollectionView
        animationBlock:(nullable NoResultBlock)animationBlock{
    NSArray *cells = CollectionView.visibleCells;
    for (int i = 0; i < cells.count; i++) {
        UICollectionViewCell *cell = [cells objectAtIndex:i];
        CGRect rect = [cell convertRect:cell.bounds fromView:CollectionView];
        cell.transform = CGAffineTransformMakeTranslation(0, -rect.origin.y);
        @jobs_weakify(cell)
        [UIView animateWithDuration:0.5
                         animations:^{
            @jobs_strongify(cell)
            cell.transform = CGAffineTransformIdentity;
            if (animationBlock) animationBlock();
        }];
    }
}
#pragma mark —— layDownAnimation
+(void)layDownAnimationWithCollectionView:(nonnull UICollectionView *)CollectionView{
    [self layDownAnim:CollectionView
       animationBlock:nil
      completionBlock:nil];
}

+(void)layDownAnim:(nonnull UICollectionView *)CollectionView
    animationBlock:(nullable NoResultBlock)animationBlock
   completionBlock:(nullable MKDataBlock)completionBlock{
    NSArray *cells = CollectionView.visibleCells;
    NSMutableArray *rectArr = NSMutableArray.array;
    for (int i = 0; i < cells.count; i++) {
        UICollectionViewCell *cell = [cells objectAtIndex:i];
        CGRect rect = cell.frame;
        [rectArr addObject:[NSValue valueWithCGRect:rect]];
        rect.origin.y = i * 10;
        cell.frame = rect;
        cell.layer.transform = CATransform3DMakeTranslation(0, 0, i * 5);
    }
    NSTimeInterval totalTime = 0.8;
    for (int i = 0; i < cells.count; i++) {
        UICollectionViewCell *cell = [cells objectAtIndex:i];
        CGRect rect = [[rectArr objectAtIndex:i] CGRectValue];
        @jobs_weakify(cell)
        [UIView animateWithDuration:(totalTime/cells.count) * i
                         animations:^{
            @jobs_strongify(cell)
            cell.frame = rect;
            if (animationBlock) animationBlock();
        } completion:^(BOOL finished) {
            @jobs_strongify(cell)
            cell.layer.transform = CATransform3DIdentity;
            if (completionBlock) completionBlock(@(finished));
        }];
    }
}
#pragma mark —— roteAnimation
+(void)roteAnimationWithCollectionView:(nonnull UICollectionView *)CollectionView{
    [self roteAnim:CollectionView
    animationBlock:nil
   completionBlock:nil];
}

+(void)roteAnim:(nonnull UICollectionView *)CollectionView
 animationBlock:(nullable NoResultBlock)animationBlock
    completionBlock:(nullable MKDataBlock)completionBlock{
    NSArray *cells = CollectionView.visibleCells;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.fromValue = @(-M_PI);
    animation.toValue = 0;
    animation.duration = 0.3;
    animation.removedOnCompletion = NO;
    animation.repeatCount = 3;
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses = NO;
    for (int i = 0; i < cells.count; i++) {
        UICollectionViewCell *cell = [cells objectAtIndex:i];
        cell.alpha = 0.0;
        @jobs_weakify(cell)
        [UIView animateWithDuration:0.1
                              delay:i * 0.25
                            options:0
                         animations:^{
            @jobs_strongify(cell)
            cell.alpha = 1.0;
            if (animationBlock) animationBlock();
        } completion:^(BOOL finished) {
            @jobs_strongify(cell)
            [cell.layer addAnimation:animation
                              forKey:@"rotationYkey"];
            if (completionBlock) completionBlock(@(finished));
        }];
    }
}

@end
