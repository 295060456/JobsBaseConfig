//
//  GetCustomerContactApi.h
//  JobsBaseConfig
//
//  Created by Jobs on 2022/2/19.
//
#import "YTKNetworkToolsHeader.h"

#if __has_include(<YTKNetwork/YTKNetwork.h>)
#import <YTKNetwork/YTKNetwork.h>
#else
#import "YTKNetwork.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface GetCustomerContactApi : BaseRequest

-(instancetype _Nullable)initWithParameters:(NSDictionary *_Nullable)parameters;

@end

NS_ASSUME_NONNULL_END
