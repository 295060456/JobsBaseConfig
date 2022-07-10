//
//  BaseRequest.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/7/10.
//

#import "BaseRequest.h"

@implementation BaseRequest{
    NSDictionary *_Nullable _parameters;
}

-(instancetype _Nullable)initWithParameters:(NSDictionary *_Nullable)parameters{
    if (self = [super init]) {
        _parameters = parameters;
    }return self;
}
/// 请求Api
//-(NSString *)requestUrl{
//    return self.customerContactGET.url;
//}
/// Body 参数
-(id _Nullable)requestArgument{
    return _parameters;
}
/// 请求方式
-(YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}
/// 限定接收到的字段类型，如果不匹配则外层block走Failure
-(id)jsonValidator{
    return nil;
}

-(NSInteger)cacheTimeInSeconds{
    return 60 * 3;
}

@end
