//
//  NSObject+URLManager.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLManagerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (URLManager)

#pragma mark —— BaseURL
-(NSString *)BaseUrl;

-(NSString *)BaseUrl_H5;
#pragma mark —— 测试
/// 批量发送分润MQ
-(URLManagerModel *)testSendMqGET;
/// 发送消息到TG机器人
-(URLManagerModel *)testSendMsgToTelegramBotGET;

@end

NS_ASSUME_NONNULL_END

