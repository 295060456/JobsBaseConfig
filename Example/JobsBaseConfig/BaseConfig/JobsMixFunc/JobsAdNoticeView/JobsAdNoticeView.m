//
//  JobsAdNoticeView.m
//  JobsIM
//
//  Created by Jobs on 2020/11/15.
//

#import "JobsAdNoticeView.h"

@interface JobsAdNoticeView ()

@property(nonatomic,strong)UILabel *adNoticeLab;

@end

@implementation JobsAdNoticeView

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = JobsCyanColor;

    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}
#pragma mark —— BaseViewProtocol
-(void)richElementsInViewWithModel:(id _Nullable)model{
    self.adNoticeLab.alpha = 1;
}

+(CGSize)viewSizeWithModel:(id _Nullable)model{
    return CGSizeMake(JobsMainScreen_WIDTH(), 30);
}
#pragma mark —— lazyLoad
-(UILabel *)adNoticeLab{
    if (!_adNoticeLab) {
        _adNoticeLab = UILabel.new;
        _adNoticeLab.text = @"Jobs安全聊天，为您的聊天加密护航";
        _adNoticeLab.textColor = JobsRedColor;
        _adNoticeLab.textAlignment = NSTextAlignmentCenter;
        _adNoticeLab.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        _adNoticeLab.backgroundColor = JobsClearColor;
        [self addSubview:_adNoticeLab];
        [_adNoticeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }return _adNoticeLab;
}

@end
