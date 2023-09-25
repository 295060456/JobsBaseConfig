//
//  JobsPresentedVC.m
//  JobsBaseConfig
//
//  Created by Jobs Hi on 9/25/23.
//

#import "JobsPresentedVC.h"

@interface JobsPresentedVC ()

@end

@implementation JobsPresentedVC
UIMarkProtocol_synthesize



-(void)viewDidLoad{
    [super viewDidLoad];
    
    NSLog(@"%f",self.presentUpHeight);
    
    [self updatePreferredContentSizeWithTraitCollection:self.traitCollection];
    
    /**
     NOTE: 
     View controllers presented with custom presentation controllers
     do not assume control of the status bar appearance by default
     (their -preferredStatusBarStyle and -prefersStatusBarHidden
     methods are not called).  You can override this behavior by
     setting the value of the presented view controller's
     modalPresentationCapturesStatusBarAppearance property to YES.
     
     self.modalPresentationCapturesStatusBarAppearance = YES;
     */
}

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection 
              withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    // When the current trait collection changes (e.g. the device rotates),
    // update the preferredContentSize.
    [self updatePreferredContentSizeWithTraitCollection:newCollection];
}

- (void)updatePreferredContentSizeWithTraitCollection:(UITraitCollection *)traitCollection{
    self.preferredContentSize = CGSizeMake(self.view.bounds.size.width,
                                           traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact ? 270 : self.presentUpHeight);/// 上升的高度
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
