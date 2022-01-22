//
//  NSObject+URLManager.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/12/10.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "NSObject+URLManager.h"

NetworkingEnvir networkingEnvir = DevEnviron_Cambodia_Main;/// 柬埔寨（主要）开发环境
//NetworkingEnvir networkingEnvir = DevEnviron_Cambodia_Minor;/// 柬埔寨（次要）开发环境
//NetworkingEnvir networkingEnvir = DevEnviron_China_Mainland;/// 中国大陆开发环境
//NetworkingEnvir networkingEnvir = TestEnviron;/// 测试环境
//NetworkingEnvir networkingEnvir = ProductEnviron;/// 生产环境
//NetworkingEnvir networkingEnvir = UATEnviron;/// UAT环境

@implementation NSObject (URLManager)
 
+(URLManagerModel *)url:(NSString *)url
               funcName:(NSString *)funcName{
    URLManagerModel *managerModel = URLManagerModel.new;
    managerModel.url = url;
    managerModel.funcName = funcName;
    return managerModel;
}
#pragma mark —— BaseURL
+(NSString *)BaseUrl{
    switch (networkingEnvir) {
        case DevEnviron_Cambodia_Main:{
            /// 柬埔寨（主要）开发环境
            return @"http://okeexx.cn:9200";
//            return @"154.204.57.237:9200";
//            return @"192.168.10.77:9200";
        }break;
        case DevEnviron_Cambodia_Minor:{
            /// 柬埔寨的开发环境(次要)，因为某些代码未合并，柬埔寨的开发环境临时用测试环境替代
            return @"";
        }break;
        case DevEnviron_China_Mainland:{
            /// 中国大陆开发环境
            return @"47.243.60.31:9200";
        }break;
        case TestEnviron:{
            /// 测试环境
            return @"";
        }break;
        case ProductEnviron:{
            /// 生产环境
            return @"";
        }break;
        default:
            return @"";
            break;
    }
}

+(NSString *)BaseUrl_H5{
    switch (networkingEnvir) {
        case DevEnviron_Cambodia_Main:{
            /// 柬埔寨（主要）开发环境
            return @"";
        }break;
        case DevEnviron_Cambodia_Minor:{
            /// 柬埔寨的开发环境(次要)，因为某些代码未合并，柬埔寨的开发环境临时用测试环境替代
            return @"";
        }break;
        case DevEnviron_China_Mainland:{
            /// 中国大陆开发环境
            return @"";
        }break;
        case TestEnviron:{
            /// 测试环境
            return @"";
        }break;
        case ProductEnviron:{
            /// 生产环境
            return @"";
        }break;
        default:
            return @"";
            break;
    }
}
#pragma mark —— App接口示例
+(URLManagerModel *)appInterfaceTesting{
    return [NSObject url:@"http://172.24.135.14:8000/Downloads/CommentData.json"//@"http://172.24.135.12/CommentData.json"
                funcName:NSStringFromSelector(_cmd)];
}

@end
