//
//  self.m
//  Casino
//
//  Created by Jobs on 2022/1/7.
//

#import "UIScrollViewAnimationKit.h"

#define XS_SCREEN_WIDTH UIScreen.mainScreen.bounds.size.width
#define XS_SCREEN_HEIGHT UIScreen.mainScreen.bounds.size.height

@implementation UIScrollViewAnimationKit
/**
 class method to show the tableView animation

 @param animationType : animation type
 @param scrollView : the scrollView to show animation
 */
+(void)showWithAnimationType:(XSScrollViewAnimationType)animationType
                  scrollView:(nonnull UIScrollView *)scrollView{
    unsigned int count = 0;
    Method *methodlist = class_copyMethodList(object_getClass(self.class), &count);
    int tag= 0;
    for (int i = 0; i < count; i++) {
        Method method = methodlist[i];
        SEL selector = method_getName(method);
        NSString *methodName = NSStringFromSelector(selector);
        if ([methodName rangeOfString:@"AnimationWithCollectionView"].location != NSNotFound) {
            if (tag == animationType) {
                ((void (*)(id,SEL,UIScrollView *))objc_msgSend)(self,selector,scrollView);
                break;
            }tag++;
        }
    }free(methodlist);
}
#pragma mark —— moveAnimation
+(void)moveAnimationWithScrollView:(nonnull UIScrollView *)scrollView{
    [self moveAnimWithScrollView:scrollView
                  animationBlock:nil
                 completionBlock:nil];
}

+(void)moveAnimWithScrollView:(nonnull UIScrollView *)scrollView
               animationBlock:(nullable NoResultBlock)animationBlock
              completionBlock:(nullable MKDataBlock)completionBlock{
    
    NSArray *cells = [UIScrollView cellsWithScrollView:scrollView];
    CGFloat totalTime = 0.3;
    
    for (int i = 0; i < cells.count; i++) {
        UIView *cell = [UIScrollView cellWithScrollView:scrollView atIndex:i];
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
+(void)moveSpringAnimationWithCollectionView:(nonnull UIScrollView *)scrollView{
    [self moveSpringAnim:scrollView
          animationBlock:nil
         completionBlock:nil];
}

+(void)moveSpringAnim:(nonnull UIScrollView *)scrollView
       animationBlock:(nullable NoResultBlock)animationBlock
      completionBlock:(nullable MKDataBlock)completionBlock{
    NSArray <UIView *>*cells = [UIScrollView cellsWithScrollView:scrollView];
    CGFloat totalTime = 0.4;
    for (int i = 0; i < cells.count; i++) {
        UIView *cell = [UIScrollView cellWithScrollView:scrollView atIndex:i];
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
+(void)alphaAnimationWithCollectionView:(nonnull UIScrollView *)scrollView{
    [self alphaAnim:scrollView
     animationBlock:nil
    completionBlock:nil];
}

+(void)alphaAnim:(nonnull UIScrollView *)scrollView
  animationBlock:(nullable NoResultBlock)animationBlock
 completionBlock:(nullable MKDataBlock)completionBlock{
    NSArray *cells = [UIScrollView cellsWithScrollView:scrollView];
    for (int i = 0; i < cells.count; i++) {
        UIView *cell = [UIScrollView cellWithScrollView:scrollView atIndex:i];
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
+(void)fallAnimationWithCollectionView:(nonnull UIScrollView *)scrollView{
    [self fallAnim:scrollView
    animationBlock:nil
   completionBlock:nil];
}

+(void)fallAnim:(nonnull UIScrollView *)scrollView
 animationBlock:(nullable NoResultBlock)animationBlock
    completionBlock:(nullable MKDataBlock)completionBlock{
    NSArray *cells = [UIScrollView cellsWithScrollView:scrollView];
    NSTimeInterval totalTime = 0.8;
    for (int i = 0; i < cells.count; i++) {
        UIView *cell = [UIScrollView cellWithScrollView:scrollView atIndex:i];
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
+(void)shakeAnimationWithCollectionView:(nonnull UIScrollView *)scrollView{
    [self shakeAnim:scrollView
     animationBlock:nil
    completionBlock:nil];
}

+(void)shakeAnim:(nonnull UIScrollView *)scrollView
  animationBlock:(nullable NoResultBlock)animationBlock
 completionBlock:(nullable MKDataBlock)completionBlock{
    NSArray *cells = [UIScrollView cellsWithScrollView:scrollView];
    for (int i = 0; i < cells.count; i++) {
        UIView *cell = [UIScrollView cellWithScrollView:scrollView atIndex:i];
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
+(void)overTurnAnimationWithCollectionView:(nonnull UIScrollView *)scrollView{
    [self overTurnAnim:scrollView
        animationBlock:nil
       completionBlock:nil];
}

+(void)overTurnAnim:(nonnull UIScrollView *)scrollView
     animationBlock:(nullable NoResultBlock)animationBlock
    completionBlock:(nullable MKDataBlock)completionBlock{
    NSArray *cells = [UIScrollView cellsWithScrollView:scrollView];
    NSTimeInterval totalTime = 0.7;
    for (int i = 0; i < cells.count; i++) {
        UIView *cell = [UIScrollView cellWithScrollView:scrollView atIndex:i];
        cell.layer.opacity = 0.0;
        cell.layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
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
+(void)toTopAnimationWithCollectionView:(nonnull UIScrollView *)scrollView{
    [self toTopAnim:scrollView
     animationBlock:nil
    completionBlock:nil];
}

+(void)toTopAnim:(nonnull UIScrollView *)scrollView
  animationBlock:(nullable NoResultBlock)animationBlock
 completionBlock:(nullable MKDataBlock)completionBlock{
    NSArray *cells = [UIScrollView cellsWithScrollView:scrollView];
    NSTimeInterval totalTime = 0.8;
    for (int i = 0; i < cells.count; i++) {
        UIView *cell = [UIScrollView cellWithScrollView:scrollView atIndex:i];
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
+(void)springListAnimationWithCollectionView:(nonnull UIScrollView *)scrollView{
    [self springListAnim:scrollView
          animationBlock:nil
         completionBlock:nil];
}

+(void)springListAnim:(nonnull UIScrollView *)scrollView
       animationBlock:(nullable NoResultBlock)animationBlock
      completionBlock:(nullable MKDataBlock)completionBlock{
    NSArray *cells = [UIScrollView cellsWithScrollView:scrollView];
    NSTimeInterval totalTime = 1.0;
    for (int i = 0; i < cells.count; i++) {
        UIView *cell = [UIScrollView cellWithScrollView:scrollView atIndex:i];
        cell.layer.opacity = 0.7;
        cell.layer.transform = CATransform3DMakeTranslation(0, -XS_SCREEN_HEIGHT, 20);
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
+(void)shrinkToTopAnimationWithCollectionView:(nonnull UIScrollView *)scrollView{
    [self shrinkToTopAnim:scrollView
           animationBlock:nil];
}

+(void)shrinkToTopAnim:(nonnull UIScrollView *)scrollView
        animationBlock:(nullable NoResultBlock)animationBlock{
    NSArray *cells = [UIScrollView cellsWithScrollView:scrollView];
    for (int i = 0; i < cells.count; i++) {
        UIView *cell = [UIScrollView cellWithScrollView:scrollView atIndex:i];
        CGRect rect = [cell convertRect:cell.bounds fromView:scrollView];
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
+(void)layDownAnimationWithCollectionView:(nonnull UIScrollView *)scrollView{
    [self layDownAnim:scrollView
       animationBlock:nil
      completionBlock:nil];
}

+(void)layDownAnim:(nonnull UIScrollView *)scrollView
    animationBlock:(nullable NoResultBlock)animationBlock
   completionBlock:(nullable MKDataBlock)completionBlock{
    NSArray *cells = [UIScrollView cellsWithScrollView:scrollView];
    NSMutableArray *rectArr = NSMutableArray.array;
    for (int i = 0; i < cells.count; i++) {
        UIView *cell = [UIScrollView cellWithScrollView:scrollView atIndex:i];
        CGRect rect = cell.frame;
        [rectArr addObject:[NSValue valueWithCGRect:rect]];
        rect.origin.y = i * 10;
        cell.frame = rect;
        cell.layer.transform = CATransform3DMakeTranslation(0, 0, i * 5);
    }
    NSTimeInterval totalTime = 0.8;
    for (int i = 0; i < cells.count; i++) {
        UIView *cell = [UIScrollView cellWithScrollView:scrollView atIndex:i];
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
+(void)roteAnimationWithCollectionView:(nonnull UIScrollView *)scrollView{
    [self roteAnim:scrollView
    animationBlock:nil
   completionBlock:nil];
}

+(void)roteAnim:(nonnull UIScrollView *)scrollView
 animationBlock:(nullable NoResultBlock)animationBlock
    completionBlock:(nullable MKDataBlock)completionBlock{
    NSArray *cells = [UIScrollView cellsWithScrollView:scrollView];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.fromValue = @(-M_PI);
    animation.toValue = 0;
    animation.duration = 0.3;
    animation.removedOnCompletion = NO;
    animation.repeatCount = 3;
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses = NO;
    for (int i = 0; i < cells.count; i++) {
        UIView *cell = [UIScrollView cellWithScrollView:scrollView atIndex:i];
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
