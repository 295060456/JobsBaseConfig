//
//  JobsRightBtnsView.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/9/19.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "JobsRightBtnsView.h"

@interface JobsRightBtnsView ()
/// UI
@property(nonatomic,strong)UIButton *mkZanView;
@property(nonatomic,strong)UIButton *mkCommentView;
@property(nonatomic,strong)UIButton *mkShareView;
/// Data
@property(nonatomic,strong)NSMutableArray <UIButton *>*mutArr;
@property(nonatomic,assign)BOOL isSelected;

@end

@implementation JobsRightBtnsView
@synthesize viewModel = _viewModel;
#pragma mark —— BaseProtocol
/// 单例化和销毁
+(void)destroySingleton{
    static_rightBtnsViewOnceToken = 0;
    static_rightBtnsView = nil;
}

static JobsRightBtnsView *static_rightBtnsView = nil;
static dispatch_once_t static_rightBtnsViewOnceToken;
+(instancetype)sharedInstance{
    dispatch_once(&static_rightBtnsViewOnceToken, ^{
        static_rightBtnsView = JobsRightBtnsView.new;
    });return static_rightBtnsView;
}
#pragma mark —— SysMethod
-(instancetype)init{
    if (self = [super init]) {

    }return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        NotificationAdd(self,
                        @selector(languageSwitchNotification:),
                        LanguageSwitchNotification,
                        nil);
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}

-(void)layoutSubviews{
    [super layoutSubviews];
}
#pragma mark —— BaseViewProtocol
- (instancetype)initWithSize:(CGSize)thisViewSize{
    if (self = [super init]) {
        
    }return self;
}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(UIViewModel *_Nullable)model{
    return CGSizeMake(JobsWidth(50), JobsMainScreen_HEIGHT()/ 4);
}
#pragma mark —— BaseViewProtocol
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInViewWithModel:(UIViewModel *_Nullable)model{
    self.viewModel = model;
    self.mkZanView.alpha = 1;
    self.mkCommentView.alpha = 1;
    self.mkShareView.alpha = 1;
}
#pragma mark —— Set方法
-(void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    self.mkZanView.selected = _isSelected;
    if (self.mkZanView.selected) {
        //特别重要，花了老子半个小时，mmp.只要改变选择状态都要进行刷新 走这一句
        self.mkZanView.selectedTitle = JobsNonnullString(self.viewModel.textModel.text, Internationalization(@"点赞"));
    }else{
        self.mkZanView.normalTitle = JobsNonnullString(self.viewModel.textModel.text, Internationalization(@"点赞"));;
    }
    [self.mkZanView layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                    imageTitleSpace:JobsWidth(5)];
}
#pragma mark —— lazyLoad
-(UIButton *)mkZanView{
    if (!_mkZanView) {
        _mkZanView = UIButton.new;
        
        _mkZanView.normalImage = JobsIMG(@"视频未点赞");
        _mkZanView.selectedImage = JobsIMG(@"视频未点赞");
        _mkZanView.titleFont = UIFontWeightRegularSize(JobsWidth(12));
        
        @jobs_weakify(self)
        [_mkZanView jobsBtnClickEventBlock:^(__kindof UIButton * _Nullable x) {
            NSLog(@"我是点赞");
            [x.imageView addViewAnimationWithCompletionBlock:^(id data) {
                @jobs_strongify(self)
                self->_mkZanView.tag = MKRightBtnViewBtnType_mkZanView;//写在block外部，此值异常
                if (self.objectBlock) self.objectBlock(self->_mkZanView);
            }];
        }];
        [self addSubview:_mkZanView];
        [_mkZanView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.mas_equalTo([JobsRightBtnsView viewSizeWithModel:nil].width);
        }];
        [self.mutArr addObject:_mkZanView];
        [self layoutIfNeeded];
    }
    _mkZanView.normalTitle = JobsNonnullString(self.viewModel.textModel.text, Internationalization(@"点赞"));
    [_mkZanView layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                imageTitleSpace:JobsWidth(5)];
    return _mkZanView;
}

-(UIButton *)mkCommentView{
    if (!_mkCommentView) {
        _mkCommentView = UIButton.new;
        _mkCommentView.normalImage = JobsIMG(@"视频评论");
        _mkCommentView.titleFont = UIFontWeightRegularSize(JobsWidth(12));
        @jobs_weakify(self)
        [_mkCommentView jobsBtnClickEventBlock:^(__kindof UIButton * _Nullable x) {
            NSLog(@"我是评论");
            [x.imageView addViewAnimationWithCompletionBlock:^(id data) {
                @jobs_strongify(self)
                self->_mkCommentView.tag = MKRightBtnViewBtnType_mkCommentView;//写在block外部，此值异常
                if (self.objectBlock) self.objectBlock(self->_mkCommentView);
            }];
        }];
        [self addSubview:_mkCommentView];
        [_mkCommentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.mas_equalTo([JobsRightBtnsView viewSizeWithModel:nil].width);
            make.top.equalTo(self.mutArr.lastObject.mas_bottom).offset(self.offset);
        }];
        [self.mutArr addObject:_mkCommentView];
        [self layoutIfNeeded];
    }
    _mkCommentView.normalTitle = JobsNonnullString(self.viewModel.subTextModel.text, Internationalization(@"评论"));
    [_mkCommentView layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                    imageTitleSpace:JobsWidth(5)];
    return _mkCommentView;
}

-(UIButton *)mkShareView{
    if (!_mkShareView) {
        _mkShareView = UIButton.new;
        _mkShareView.normalTitle = Internationalization(@"分享");
        _mkShareView.normalImage = JobsIMG(@"分享");
        _mkShareView.titleFont = UIFontWeightRegularSize(JobsWidth(12));
        @jobs_weakify(self)
        [_mkShareView jobsBtnClickEventBlock:^(__kindof UIButton * _Nullable x) {
            NSLog(@"我是分享");
            [x.imageView addViewAnimationWithCompletionBlock:^(id data) {
                @jobs_strongify(self)
                self->_mkShareView.tag = MKRightBtnViewBtnType_mkShareView;//写在block外部，此值异常
                if (self.objectBlock) self.objectBlock(self->_mkShareView);
            }];
        }];
        [self addSubview:_mkShareView];
        [_mkShareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.mas_equalTo([JobsRightBtnsView viewSizeWithModel:nil].width);
            make.top.equalTo(self.mutArr.lastObject.mas_bottom).offset(self.offset);
        }];
        [self.mutArr addObject:_mkShareView];
        [self layoutIfNeeded];
        [_mkShareView layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                      imageTitleSpace:5];
    }return _mkShareView;
}

-(NSMutableArray<UIButton *> *)mutArr{
    if (!_mutArr) {
        _mutArr = NSMutableArray.array;
    }return _mutArr;
}

-(CGFloat)offset{
    if (_offset == 0) {
        _offset = ([JobsRightBtnsView viewSizeWithModel:nil].height - [JobsRightBtnsView viewSizeWithModel:nil].width * 3) / 2;
    }return _offset;
}

@end
