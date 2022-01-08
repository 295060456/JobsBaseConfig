//
//  WBTableViewDelegate.h
//
//  Created by Transuner on 16/3/9.
//  Copyright © 2016年 吴冰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * 点击cell事件回调
 */
typedef void(^TableViewDidSelectRowAtIndexPath)(NSInteger indexRow);


@interface WBTableViewDelegate : NSObject <UITableViewDelegate>


/**
 * 对 cell 代理初始化
 */
- (instancetype) initWithDidSelectRowAtIndexPath:(TableViewDidSelectRowAtIndexPath)tableViewDidSelectRowAtIndexPath;



@end
