//
//  DynamicViewTestVC.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/8.
//

#import "DynamicViewTestVC.h"

@interface DynamicViewTestVC ()

@property(nonatomic,strong)UIImageView *gifImageView;
@property(nonatomic,strong)NSString *path;

@end

@implementation DynamicViewTestVC

- (void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)loadView{
    [super loadView];
    
    if ([self.requestParams isKindOfClass:UIViewModel.class]) {
        self.viewModel = (UIViewModel *)self.requestParams;
    }
    
    self.setupNavigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = JobsYellowColor;
    [self setGKNav];
    [self setGKNavBackBtn];
    self.gifImageView.alpha = 1;
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
-(UIImageView *)gifImageView{
    if (!_gifImageView) {
        _gifImageView = UIImageView.new;
        _gifImageView.image = self.image;
        [self.view addSubview:_gifImageView];
        [_gifImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }return _gifImageView;
}

-(NSString *)path{
    if (!_path) {
        _path = [[NSBundle mainBundle] pathForResource:@"GIF大图"
                                                ofType:@"gif"];
    }return _path;
}
@synthesize data = _data;
-(NSData *)data{
    if (!_data) {
        _data = [NSData dataWithContentsOfFile:self.path];
    }return _data;
}
@synthesize image = _image;
-(UIImage *)image{
    if (!_image) {
        _image = [UIImage sd_imageWithGIFData:self.data];
    }return _image;
}


@end
