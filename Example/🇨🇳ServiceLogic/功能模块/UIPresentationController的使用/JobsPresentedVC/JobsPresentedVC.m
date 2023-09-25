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

-(void)viewDidLoad{
    [super viewDidLoad];
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
    self.preferredContentSize = CGSizeMake(self.view.bounds.size.width, traitCollection.verticalSizeClass == UIUserInterfaceSizeClassCompact ? 270 : 420);
    /**
     
     To demonstrate how a presentation controller can dynamically respond
     to changes to its presented view controller's preferredContentSize,
     this view controller exposes a slider.  Dragging this slider updates
     the preferredContentSize of this view controller in real time.
    
     Update the slider with appropriate min/max values and reset the
     current value to reflect the changed preferredContentSize.
     */
    
//    self.slider.maximumValue = self.preferredContentSize.height;
//    self.slider.minimumValue = 220.f;
//    self.slider.value = self.slider.maximumValue;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
