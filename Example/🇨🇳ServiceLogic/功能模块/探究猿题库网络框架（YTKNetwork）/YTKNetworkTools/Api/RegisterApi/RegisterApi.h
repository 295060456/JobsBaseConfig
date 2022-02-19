//
//  RegisterApi.h
//  Solar
//
//  Created by TangQiao on 11/8/14.
//  Copyright (c) 2014 fenbi. All rights reserved.
//

#import "YTKRequest.h"

@interface RegisterApi : YTKRequest

-(instancetype _Nullable)initWithParameters:(NSDictionary *_Nullable)parameters;
-(NSString *)userId;/// 在链式请求中，下一个请求的参数来源于上一个请求的结果

@end
