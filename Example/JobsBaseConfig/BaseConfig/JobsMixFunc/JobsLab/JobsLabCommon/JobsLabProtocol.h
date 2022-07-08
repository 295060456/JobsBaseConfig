//
//  JobsLabProtocol.h
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/7/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JobsLabProtocol <NSObject>

@optional
-(UIButton *)getUpBtn;
-(UIButton *)getDownBtn;

-(UIButton *)getLeftBtn;
-(UIButton *)getRightBtn;

@end

NS_ASSUME_NONNULL_END
