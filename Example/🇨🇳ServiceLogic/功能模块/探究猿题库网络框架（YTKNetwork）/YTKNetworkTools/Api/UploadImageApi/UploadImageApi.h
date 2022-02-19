//
//  UploadImageApi.h
//  Solar
//
//  Created by tangqiao on 8/7/14.
//  Copyright (c) 2014 fenbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTKRequest.h"
#import <AFNetworking/AFURLRequestSerialization.h>

@interface UploadImageApi : YTKRequest

-(id)initWithImage:(UIImage *)image;
-(NSString *)responseImageId;

@end
