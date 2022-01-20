//
//  JobsLaunchVC.h
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/19.
//

#import "BaseViewController.h"
#import "JobsLaunchDef.h"
#import "JobsLaunchConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobsLaunchVC : BaseViewController

+(void)destroyAppDoorSingleton;
+(instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
