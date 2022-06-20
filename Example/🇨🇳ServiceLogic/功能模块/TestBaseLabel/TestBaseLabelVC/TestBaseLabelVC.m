//
//  TestBaseLabelVC.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/6/20.
//

#import "TestBaseLabelVC.h"

@interface TestBaseLabelVC ()

@property(nonatomic,strong)JobsBaseLabel *titleLab;
@property(nonatomic,strong)BaseLabel *baseLabel;

@end

@implementation TestBaseLabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLab.alpha = 1;
    self.baseLabel.alpha = 1;
}

-(JobsBaseLabel *)titleLab{
    if (!_titleLab) {
        _titleLab = JobsBaseLabel.new;
        [_titleLab richElementsInViewWithModel:nil];
        _titleLab.getLabel.offsetY = JobsWidth(-2);
        _titleLab.getLabel.textColor = UIColor.whiteColor;
        _titleLab.getLabel.font = notoSansRegular(12);
        _titleLab.getLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(JobsWidth(100));
            make.left.equalTo(self.view).offset(JobsWidth(100));
            make.height.mas_equalTo(JobsWidth(26));
        }];
        
        [_titleLab.getLabel actionTapGRBlock:^id(UIGestureRecognizer *data) {
            NSLog(@"JobsBaseLabel的Tap手势");
            return @1;
        }];
        
        [_titleLab.getLabel actionLongPressGRBlock:^id(UIGestureRecognizer *data) {
            NSLog(@"JobsBaseLabel的LongPress手势");
            return @1;
        }];
    }
    _titleLab.getLabel.text = Internationalization(@" 真人           ");
    _titleLab.getBgImageView.image = KIMG(@"优惠活动背景图_真人");
    
    [_titleLab.getLabel makeLabelByShowingType:UILabelShowingType_03];
    [_titleLab.getLabel appointCornerCutToCircleByRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(JobsWidth(8), JobsWidth(8))];
    return _titleLab;
}

-(BaseLabel *)baseLabel{
    if (!_baseLabel) {
        _baseLabel = BaseLabel.new;
        _baseLabel.offsetX = JobsWidth(10);
        _baseLabel.text = Internationalization(@"测试 -BaseLabel-");
        _baseLabel.backgroundColor = JobsCyanColor;
        [self.view addSubview:_baseLabel];
        [_baseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLab.mas_bottom).offset(JobsWidth(20));
            make.left.equalTo(self.view).offset(JobsWidth(100));
            make.height.mas_equalTo(JobsWidth(26));
        }];
        
        [_baseLabel actionTapGRBlock:^id(UIGestureRecognizer *data) {
            NSLog(@"BaseLabel的Tap手势");
            return @1;
        }];
        
        [_baseLabel actionLongPressGRBlock:^id(UIGestureRecognizer *data) {
            NSLog(@"BaseLabel的LongPress手势");
            return @1;
        }];
        
    }return _baseLabel;
}


@end
