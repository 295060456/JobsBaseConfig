//
//  ECPrivacyCheckGatherTool.m
//  Pods
//
//  Created by EchoZuo on 2020/4/26.
//

#import "ECPrivacyCheckGatherTool.h"

@interface ECPrivacyCheckGatherTool () 

@property(nonatomic, strong)CLLocationManager *locationManager;
@property(nonatomic,copy)void (^kCLCallBackBlock)(CLAuthorizationStatus status);

@end

@implementation ECPrivacyCheckGatherTool

- (void)callbackOnMainQueue:(dispatch_block_t)block {
    dispatch_async(dispatch_get_main_queue(), block);
}

+ (void)callbackOnMainQueue:(dispatch_block_t)block {
    dispatch_async(dispatch_get_main_queue(), block);
}
#pragma mark —— 定位服务 LocationServices
+ (ECLBSAuthorizationStatus)locationAuthorizationStatus {
    if (![CLLocationManager locationServicesEnabled]) {
        return ECLBSAuthorizationStatusUnable;
    }
    SuppressWdeprecatedDeclarationsWarning(
                                           switch (CLLocationManager.authorizationStatus) {
                                               case kCLAuthorizationStatusNotDetermined: {
                                                   return ECLBSAuthorizationStatusNotDetermined;
                                               }
                                                   break;
                                               case kCLAuthorizationStatusRestricted: {
                                                   return ECLBSAuthorizationStatusRestricted;
                                               }
                                                   break;
                                               case kCLAuthorizationStatusDenied: {
                                                   return ECLBSAuthorizationStatusDenied;
                                               }
                                                   break;
                                               case kCLAuthorizationStatusAuthorizedAlways: {
                                                   return ECLBSAuthorizationStatusAuthorizedAlways;
                                               }
                                                   break;
                                               case kCLAuthorizationStatusAuthorizedWhenInUse: {
                                                   return ECLBSAuthorizationStatusAuthorizedWhenInUse;
                                               }
                                               default:
                                                   break;
                                           });

}

- (ECLBSAuthorizationStatus)locationAuthorizationStatus {
    return [self.class locationAuthorizationStatus];
}

- (void)requestLocationAuthorizationWithCompletionHandler:(void(^)(ECLBSAuthorizationStatus status))completionHandler {
    __block ECLBSAuthorizationStatus lbsStatus = [self.class locationAuthorizationStatus];
    if (lbsStatus == ECLBSAuthorizationStatusNotDetermined) {
        self.locationManager = CLLocationManager.new;
        self.locationManager.delegate = self;
        [self.locationManager requestWhenInUseAuthorization];
        @jobs_weakify(self)
        [self setKCLCallBackBlock:^(CLAuthorizationStatus status) {
            @jobs_strongify(self)
            [self callbackOnMainQueue:^{
                switch (status) {
                    case kCLAuthorizationStatusNotDetermined: {
                        lbsStatus = ECLBSAuthorizationStatusNotDetermined;
                    }break;
                    case kCLAuthorizationStatusRestricted: {
                        lbsStatus = ECLBSAuthorizationStatusRestricted;
                    }break;
                    case kCLAuthorizationStatusDenied: {
                        lbsStatus = ECLBSAuthorizationStatusDenied;
                    }break;
                    case kCLAuthorizationStatusAuthorizedAlways: {
                        lbsStatus = ECLBSAuthorizationStatusAuthorizedAlways;
                    }break;
                    case kCLAuthorizationStatusAuthorizedWhenInUse: {
                        lbsStatus = ECLBSAuthorizationStatusAuthorizedWhenInUse;
                    }default:
                        break;
                }
                if (completionHandler) completionHandler(lbsStatus);
            }];
        }];
    } else {
        [self callbackOnMainQueue:^{
            if (completionHandler) completionHandler(lbsStatus);
        }];
    }
}
#pragma mark —— CLLocationManagerDelegate
_Pragma("clang diagnostic push")
_Pragma("clang diagnostic ignored \"-Wdeprecated-implementations\"")
- (void)locationManager:(CLLocationManager *)manager
    didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
        if (self.kCLCallBackBlock) self.kCLCallBackBlock(status);
}
_Pragma("clang diagnostic pop")
#pragma mark —— 照片 Photos
+ (ECAuthorizationStatus)photosAuthorizationStatus {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        PHAuthorizationStatus status = PHPhotoLibrary.authorizationStatus;
        if (status == PHAuthorizationStatusNotDetermined) {
            return ECAuthorizationStatusNotDetermined;
        } else if (status == PHAuthorizationStatusRestricted) {
            return ECAuthorizationStatusRestricted;
        } else if (status == PHAuthorizationStatusDenied) {
            return ECAuthorizationStatusDenied;
        } else {
            return ECAuthorizationStatusAuthorized;
        }
    } else return ECAuthorizationStatusUnable;
}

- (ECAuthorizationStatus)photosAuthorizationStatus {
    return [self.class photosAuthorizationStatus];
}

+ (void)requestPhotosAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler {
    ECAuthorizationStatus status = [self.class photosAuthorizationStatus];
    if (status == ECAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            [self callbackOnMainQueue:^{
                if (completionHandler) completionHandler(status == PHAuthorizationStatusAuthorized);
            }];
        }];
    } else {
        [self callbackOnMainQueue:^{
            if (completionHandler) completionHandler(status == ECAuthorizationStatusAuthorized);
        }];
    }
}

- (void)requestPhotosAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler {
    [self.class requestPhotosAuthorizationWithCompletionHandler:completionHandler];
}
#pragma mark —— 相机 Camera
+ (ECAuthorizationStatus)cameraAuthorizationStatus {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            return ECAuthorizationStatusNotDetermined;
        } else if (status == AVAuthorizationStatusRestricted){
            return ECAuthorizationStatusRestricted;
        } else if (status == AVAuthorizationStatusDenied) {
            return ECAuthorizationStatusDenied;
        } else return ECAuthorizationStatusAuthorized;
    } else return ECAuthorizationStatusUnable;
}

- (ECAuthorizationStatus)cameraAuthorizationStatus {
    return [self.class cameraAuthorizationStatus];
}

+ (void)requestCameraAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler {
    ECAuthorizationStatus status = [self.class cameraAuthorizationStatus];
    if (status == ECAuthorizationStatusNotDetermined) {
        @jobs_weakify(self)
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo
                                 completionHandler:^(BOOL granted) {
            @jobs_strongify(self)
            [self callbackOnMainQueue:^{
                if (completionHandler) completionHandler(granted);
            }];
        }];
    } else {
        [self callbackOnMainQueue:^{
            if (completionHandler) completionHandler(status == ECAuthorizationStatusAuthorized);
        }];
    }
}
    
- (void)requestCameraAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler {
    [self.class requestCameraAuthorizationWithCompletionHandler:completionHandler];
}
#pragma mark —— 通讯录 Contacts
+ (ECAuthorizationStatus)contactsAuthorizationStatus {
    if (@available(iOS 9.0, *)) {
        switch ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts]) {
            case CNAuthorizationStatusNotDetermined: {
                return ECAuthorizationStatusNotDetermined;
            }break;
            case CNAuthorizationStatusRestricted: {
                return ECAuthorizationStatusRestricted;
            }break;
            case CNAuthorizationStatusDenied: {
                return ECAuthorizationStatusDenied;
            }break;
            case CNAuthorizationStatusAuthorized: {
                return ECAuthorizationStatusAuthorized;
            }
            default:
                break;
        }
    } else {
        SuppressWdeprecatedDeclarationsWarning(
                                               switch (ABAddressBookGetAuthorizationStatus()) {
                                                   case kABAuthorizationStatusNotDetermined: {
                                                       return ECAuthorizationStatusNotDetermined;
                                                   }break;
                                                   case kABAuthorizationStatusRestricted: {
                                                       return ECAuthorizationStatusRestricted;
                                                   }break;
                                                   case kABAuthorizationStatusDenied: {
                                                       return ECAuthorizationStatusDenied;
                                                   }break;
                                                   case kABAuthorizationStatusAuthorized: {
                                                       return ECAuthorizationStatusAuthorized;
                                                   }default:
                                                       break;
                                               });
        
    }
}

- (ECAuthorizationStatus)contactsAuthorizationStatus {
    return [self.class contactsAuthorizationStatus];
}

+ (void)requestContactsAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler {
    ECAuthorizationStatus status = [self.class contactsAuthorizationStatus];
    if (status == ECAuthorizationStatusNotDetermined) {
        if (@available(iOS 9.0, *)) {
            CNContactStore *contactStore = CNContactStore.new;
            [contactStore requestAccessForEntityType:CNEntityTypeContacts
                                   completionHandler:^(BOOL granted,
                                                       NSError * _Nullable error) {
                [self callbackOnMainQueue:^{
                    if (completionHandler) completionHandler(granted);
                }];
            }];
        } else {
            SuppressWdeprecatedDeclarationsWarning(
                                                   ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
                                                   ABAddressBookRequestAccessWithCompletion(addressBook,
                                                                                            ^(bool granted,
                                                                                              CFErrorRef error) {
                                                       @jobs_weakify(self)
                                                       [self callbackOnMainQueue:^{
                                                           @jobs_strongify(self)
                                                           if (completionHandler) completionHandler(granted);
                                                       }];
                                                   });
                                                   );
        }
    } else {
        [self callbackOnMainQueue:^{
            if (completionHandler) completionHandler(status == ECAuthorizationStatusAuthorized);
        }];
    }
}

- (void)requestContactsAuthorizationWithCompletionHandler:(void(^)(BOOL granted))completionHandler {
    [self.class requestContactsAuthorizationWithCompletionHandler:completionHandler];
}

@end
