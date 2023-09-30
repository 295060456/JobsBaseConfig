//
//  NSNotificationCenter+JobsBlock.h
//  JobsBaseConfig
//
//  Created by Jobs Hi on 9/24/23.
//

#import <Foundation/Foundation.h>

/// 定义通知
#define JobsNotificationCenter NSNotificationCenter.defaultCenter
/// 发送通知
#define JobsPostNotification(NotificationName,Obj) [JobsNotificationCenter postNotificationName:NotificationName object:Obj]
/// 销毁通知
#define JobsRemoveNotification(Object) [JobsNotificationCenter removeObserver:Object]

NS_ASSUME_NONNULL_BEGIN

@interface NSNotificationCenter (JobsBlock)

@property(nonatomic,copy)void (^jobsNotificationBlock)(NSNotification *notification);

@end

NS_ASSUME_NONNULL_END
/**
 使用方法 1：
 [NSNotificationCenter.defaultCenter addObserverForName:GSUploadAndDownloadNetworkSpeedNotificationKey
                                                 object:nil
                                                  queue:nil
                                             usingBlock:^(NSNotification * _Nonnull notification) {
     NSString *d = notification.name;
     NSLog(@"");
 }];
 =================================================================================================
 或者，使用方法 2：
 NSNotificationCenter.defaultCenter.jobsNotificationBlock = ^(NSNotification * _Nonnull notification) {
     NSString *d = notification.name;
     NSLog(@"");
 };

 // 添加观察者监听通知
 [NSNotificationCenter.defaultCenter addObserverForName:GSUploadAndDownloadNetworkSpeedNotificationKey
                                                 object:nil
                                                  queue:nil
                                             usingBlock:NSNotificationCenter.defaultCenter.jobsNotificationBlock];
 =================================================================================================
 或者，使用方法 3：
 [NSNotificationCenter.defaultCenter addObserver:self
                                        selector:selectorBlocks(^(JobsBitsMonitorSuspendLab *_Nullable weakSelf,
                                                                  NSNotification *_Nullable arg) {
     /// upload
     NSLog(@"");
 }, self)
                                            name:GSUploadNetworkSpeedNotificationKey
                                          object:nil];
 
 */
