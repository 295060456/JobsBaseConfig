//
//  TableViewAnimationKit.h
//  TableViewAnimationKit-OC
//
//  Created by alanwang on 2017/7/11.
//  Copyright © 2017年 com.cn.fql. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "JobsBlock.h"
#import "MacroDef_Strong@Weak.h"

#import "TableViewAnimationKitConfig.h"

@interface TableViewAnimationKit : NSObject<UICollisionBehaviorDelegate>
/**
 class method to show the tableView animation

 @param animationType : animation type
 @param tableView : the tableView to show animation
 */
+(void)showWithAnimationType:(XSTableViewAnimationType)animationType
                   tableView:(nonnull UITableView *)tableView;
#pragma mark —— moveAnimation
+(void)moveAnimWithTableView:(nonnull UITableView *)tableView
              animationBlock:(nullable NoResultBlock)animationBlock
             completionBlock:(nullable MKDataBlock)completionBlock;
#pragma mark —— moveSpringAnimation
+(void)moveSpringAnim:(nonnull UITableView *)tableView
       animationBlock:(nullable NoResultBlock)animationBlock
      completionBlock:(nullable MKDataBlock)completionBlock;
#pragma mark —— alphaAnimation
+(void)alphaAnim:(nonnull UITableView *)tableView
  animationBlock:(nullable NoResultBlock)animationBlock
 completionBlock:(nullable MKDataBlock)completionBlock;
#pragma mark —— fallAnimation
+(void)fallAnim:(nonnull UITableView *)tableView
 animationBlock:(nullable NoResultBlock)animationBlock
completionBlock:(nullable MKDataBlock)completionBlock;
#pragma mark —— shakeAnimation
+(void)shakeAnim:(nonnull UITableView *)tableView
  animationBlock:(nullable NoResultBlock)animationBlock
 completionBlock:(nullable MKDataBlock)completionBlock;
#pragma mark —— overTurnAnimation
+(void)overTurnAnim:(nonnull UITableView *)tableView
     animationBlock:(nullable NoResultBlock)animationBlock
    completionBlock:(nullable MKDataBlock)completionBlock;
#pragma mark —— toTopAnimation
+(void)toTopAnim:(nonnull UITableView *)tableView
  animationBlock:(nullable NoResultBlock)animationBlock
 completionBlock:(nullable MKDataBlock)completionBlock;
#pragma mark —— springListAnimation
+(void)springListAnim:(nonnull UITableView *)tableView
       animationBlock:(nullable NoResultBlock)animationBlock
      completionBlock:(nullable MKDataBlock)completionBlock;
#pragma mark —— shrinkToTopAnimation
+(void)shrinkToTopAnim:(nonnull UITableView *)tableView
        animationBlock:(nullable NoResultBlock)animationBlock;
#pragma mark —— layDownAnimation
+(void)layDownAnim:(nonnull UITableView *)tableView
    animationBlock:(nullable NoResultBlock)animationBlock
   completionBlock:(nullable MKDataBlock)completionBlock;
#pragma mark —— roteAnimation
+(void)roteAnim:(nonnull UITableView *)tableView
 animationBlock:(nullable NoResultBlock)animationBlock
completionBlock:(nullable MKDataBlock)completionBlock;


@end
