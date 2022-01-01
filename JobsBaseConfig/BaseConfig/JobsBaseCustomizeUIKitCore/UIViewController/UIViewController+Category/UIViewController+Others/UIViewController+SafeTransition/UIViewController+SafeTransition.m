//
//  UIViewController+SafeTransition.m
//  Casino
//
//  Created by Jobs on 2022/1/1.
//

#import "UIViewController+SafeTransition.h"

@implementation JobsRecordPresentedViewController

static JobsRecordPresentedViewController *static_JobsRecordPresentedVC = nil;
+(instancetype)sharedInstance{
    @synchronized(self){
        if (!static_JobsRecordPresentedVC) {
            static_JobsRecordPresentedVC = JobsRecordPresentedViewController.new;
        }
    }return static_JobsRecordPresentedVC;
}
#pragma mark —— lazyLoad
-(NSMutableArray<UIViewController *> *)presentedVCMutArr{
    if (!_presentedVCMutArr) {
        _presentedVCMutArr = NSMutableArray.array;
    }return _presentedVCMutArr;
}

@end

@implementation UIViewController (SafeTransition)

+(void)load{
    SEL orig_present = @selector(presentViewController:animated:completion:);
    SEL swiz_present = @selector(swiz_presentViewController:animated:completion:);
    
    SEL orig_dismiss = @selector(dismissViewControllerAnimated:completion:);
    SEL swiz_dismiss = @selector(swiz_dismissViewControllerAnimated:completion:);
    
    [UIViewController swizzleMethods:self.class
                    originalSelector:orig_present
                    swizzledSelector:swiz_present];
    
    [UIViewController swizzleMethods:self.class
                    originalSelector:orig_dismiss
                    swizzledSelector:swiz_dismiss];
}

+(void)swizzleMethods:(Class)class
     originalSelector:(SEL)origSel
     swizzledSelector:(SEL)swizSel{
    
    Method origMethod = class_getInstanceMethod(class, origSel);
    Method swizMethod = class_getInstanceMethod(class, swizSel);
    
    BOOL didAddMethod = class_addMethod(class, origSel,
                                        method_getImplementation(swizMethod),
                                        method_getTypeEncoding(swizMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizSel,
                            method_getImplementation(origMethod),
                            method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, swizMethod);
    }
}

-(void)swiz_dismissViewControllerAnimated:(BOOL)animated
                               completion:(void(^)(void))completion{
    [JobsRecordPresentedViewController.sharedInstance.presentedVCMutArr removeAllObjects];
    [self swiz_dismissViewControllerAnimated:animated completion:completion];
}

-(void)swiz_presentViewController:(UIViewController *)vc
                         animated:(BOOL)animated
                       completion:(void(^)(void))completion {
    if ([vc isKindOfClass:UIImagePickerController.class]) {
        /// 在使用UIImagePickerController进行拍照时，如果没有相机权限，则需要弹出提示框提醒用户
        UIImagePickerController *imgPicker = (UIImagePickerController *)vc;
        if (imgPicker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            completion = ^{
                completion();
                AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                if (status == AVAuthorizationStatusDenied ||
                    status == AVAuthorizationStatusRestricted) {
                    [WHToast toastErrMsg:@"请在iPhone的“设置-隐私-相机”选项中，允许App访问您的相机。"];
                }
            };
        }
    }
    
    if ([self checkPresented:vc]) {
        [self swiz_presentViewController:vc
                                animated:animated
                              completion:completion];
    }
}
/**
 presented 模态推出的ViewController和用NavigationViewController推出的差异在于：
 presented并没有一个数组进行记录
 那么在某些情况下就很有可能一次性多次presented相同的ViewController
 
 于是我们全局一个单例类用一个数组进行记录presented的ViewController
 【因为OC的数组、字典、集合是类簇，并不希望我们对此进行继承】
 如果下一次presented和数组里面进行记录的ViewController是同一个类型，那么不允许presented
 */
-(BOOL)checkPresented:(UIViewController *)viewController{
    if (JobsRecordPresentedViewController.sharedInstance.presentedVCMutArr.count) {
        for (UIViewController *vc in JobsRecordPresentedViewController.sharedInstance.presentedVCMutArr) {
            if ([viewController isKindOfClass:vc.class]) {
                return NO;
            }
        }return YES;
    }else{
        [JobsRecordPresentedViewController.sharedInstance.presentedVCMutArr addObject:viewController];
        return YES;
    }
}

@end

