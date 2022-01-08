//
//  SceneDelegate.m
//  Casino
//
//  Created by Jobs on 2021/11/16.
//

#import "SceneDelegate.h"
#import "SceneDelegate+UISceneDelegate.h"

API_AVAILABLE(ios(13.0))
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability-new"

SceneDelegate *sceneDelegate;
@interface SceneDelegate ()

@end

@implementation SceneDelegate

-(instancetype)init{
    if (self = [super init]) {
        sceneDelegate = self;
        @jobs_weakify(self)
        [NSNotificationCenter.defaultCenter addObserver:self
                                               selector:selectorBlocks(^(id  _Nullable weakSelf,
                                                                         id  _Nullable arg) {
            NSNotification *notification = (NSNotification *)arg;
            @jobs_strongify(self)
            self.windowScene = notification.object;
        }, self)
                                                   name:UISceneWillConnectNotification
                                                 object:nil];
        
    }return self;
}
#pragma mark —— lazyLoad
-(UIWindow *)window{
    AppDelegate *appDelegate = getSysAppDelegate();
    [_window setRootViewController:appDelegate.tabBarVC];
    [_window makeKeyAndVisible];
    return _window;
}

@end

#pragma clang diagnostic pop
