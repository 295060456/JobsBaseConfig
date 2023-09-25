//
//  JobsPresentingVC.m
//  JobsBaseConfig
//
//  Created by Jobs Hi on 9/26/23.
//

#import "JobsPresentingVC.h"

@interface JobsPresentingVC ()

@end

@implementation JobsPresentingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.yellowColor;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches 
          withEvent:(UIEvent *)event{
    JobsPresentedVC *vc = JobsPresentedVC.new;
    AAPLCustomPresentationController *presentationController NS_VALID_UNTIL_END_OF_SCOPE;
    presentationController = [AAPLCustomPresentationController.alloc initWithPresentedViewController:vc presentingViewController:self];
    vc.view.backgroundColor = JobsRedColor;
    vc.transitioningDelegate = presentationController;
    
    [self presentViewController:vc animated:YES completion:NULL];
}

@end
