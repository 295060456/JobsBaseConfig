//
//  UIViewController+TZLocationManager.h
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import <UIKit/UIKit.h>

#if __has_include(<TZImagePickerController/TZImagePickerController.h>)
#import <TZImagePickerController/TZImagePickerController.h>
#else
#import "TZImagePickerController.h"
#endif

#import "UIViewController+TZImagePickerController.h"
#import "TZImagePickerControllerDef.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (TZLocationManager)

@property(nonatomic,assign)TZLocationManagerType tzLocationManagerType;

-(void)Location:(TZLocationManagerType)tzLocationManagerType
          block:(MMDataBlock)block;

@end

NS_ASSUME_NONNULL_END
