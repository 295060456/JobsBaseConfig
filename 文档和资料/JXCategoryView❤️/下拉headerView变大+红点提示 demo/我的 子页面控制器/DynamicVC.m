//
//  DynamicVC.m
//  UBallLive
//
//  Created by Jobs on 2020/10/25.
//

#import "DynamicVC.h"

@interface DynamicVC ()

@property (nonatomic, copy) void(^listScrollViewScrollBlock)(UIScrollView *scrollView);

@end

@implementation DynamicVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (void)viewDidLoad {
    [super viewDidLoad];

}




@end
