//
//  JXCategoryPopupSubVC.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/5/29.
//

#import "JXCategoryPopupSubVC.h"

@interface JXCategoryPopupSubVC ()

@end

@implementation JXCategoryPopupSubVC

- (void)dealloc{
    NSLog(@"%@",JobsLocalFunc);
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)loadView{
    [super loadView];
    
    if ([self.requestParams isKindOfClass:UIViewModel.class]) {
        self.viewModel = (UIViewModel *)self.requestParams;
    }
    self.setupNavigationBarHidden = YES;
    
    // self.viewModel.textModel.text = Internationalization(@"额度记录");
     self.bgImage = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = JobsRandomColor;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma mark —— lazyLoad

@end
