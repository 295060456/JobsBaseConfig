//
//  MKRightBtnView.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/9/19.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "MKRightBtnView.h"

@interface MKRightBtnView ()

@property(nonatomic,strong)UIButton *mkZanView;
@property(nonatomic,strong)UIButton *mkCommentView;
@property(nonatomic,strong)UIButton *mkShareView;

@property(nonatomic,copy)jobsByIDBlock MKRightBtnViewBlock;
@property(nonatomic,strong)NSMutableArray <UIButton *>*mutArr;

@end

@implementation MKRightBtnView

-(instancetype)init{
    if (self = [super init]) {

    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.mkZanView.alpha = 1;
    self.mkCommentView.alpha = 1;
    self.mkShareView.alpha = 1;
}
//点击的是哪一个按钮
-(void)actionBlockMKRightBtnView:(jobsByIDBlock _Nullable)MKRightBtnViewBlock{
    _MKRightBtnViewBlock = MKRightBtnViewBlock;
}

-(void)setZanNumStr:(NSString *)ZanNumStr{
    _ZanNumStr = ZanNumStr;
}

-(void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    self.mkZanView.selected = _isSelected;
    if (self.mkZanView.selected) {
        //特别重要，花了老子半个小时，mmp.只要改变选择状态都要进行刷新 走这一句
        [self.mkZanView setTitle:[NSString ensureNonnullString:self.ZanNumStr replaceStr:@"点赞"]
                        forState:UIControlStateSelected];
    }else{
        [self.mkZanView setTitle:[NSString ensureNonnullString:self.ZanNumStr replaceStr:@"点赞"]
                        forState:UIControlStateNormal];
    }
    [self.mkZanView layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                       imageTitleSpace:5];
}

-(void)setCommentNumStr:(NSString *)CommentNumStr{
    _CommentNumStr = CommentNumStr;
    if (!_CommentNumStr.nullString) {
        [self.mkCommentView setTitle:_CommentNumStr forState:UIControlStateNormal];
        [self.mkCommentView layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                        imageTitleSpace:5];
    }
}
#pragma mark —— lazyLoad
-(UIButton *)mkZanView{
    if (!_mkZanView) {
        _mkZanView = UIButton.new;
        [_mkZanView setTitle:[NSString ensureNonnullString:self.ZanNumStr replaceStr:@"点赞"]
                    forState:UIControlStateNormal];
        [_mkZanView setImage:JobsBuddleIMG(@"bundle",@"Others", nil,@"喜欢-未点击")
                    forState:UIControlStateNormal];
        [_mkZanView setImage:JobsBuddleIMG(@"bundle",@"Others", nil,@"喜欢-点击")
                    forState:UIControlStateSelected];
        _mkZanView.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        @jobs_weakify(self)
        [[_mkZanView rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            NSLog(@"我是点赞");
            [x.imageView addViewAnimationWithCompletionBlock:^(id data) {
                @jobs_strongify(self)
                self->_mkZanView.tag = MKRightBtnViewBtnType_mkZanView;//写在block外部，此值异常
                if (self.MKRightBtnViewBlock) {
                    self.MKRightBtnViewBlock(self->_mkZanView);
                }
            }];
        }];
        [self addSubview:_mkZanView];
        [_mkZanView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.mas_equalTo(self.MKRightBtnViewSize.width);
        }];
        [self.mutArr addObject:_mkZanView];
//        [self layoutIfNeeded];
        [_mkZanView layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                    imageTitleSpace:5];
    }return _mkZanView;
}

-(UIButton *)mkCommentView{
    if (!_mkCommentView) {
        _mkCommentView = UIButton.new;
        [_mkCommentView setTitle:@"评论" forState:UIControlStateNormal];
        [_mkCommentView setImage:JobsBuddleIMG(@"bundle",@"Others",nil,@"信息")
                        forState:UIControlStateNormal];
        _mkCommentView.titleLabel.font = [UIFont systemFontOfSize:12
                                                           weight:UIFontWeightRegular];
        @jobs_weakify(self)
        [[_mkCommentView rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            NSLog(@"我是评论");
            [x.imageView addViewAnimationWithCompletionBlock:^(id data) {
                @jobs_strongify(self)
                self->_mkCommentView.tag = MKRightBtnViewBtnType_mkCommentView;//写在block外部，此值异常
                if (self.MKRightBtnViewBlock) self.MKRightBtnViewBlock(self->_mkCommentView);
            }];
        }];
        [self addSubview:_mkCommentView];
        [_mkCommentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.mas_equalTo(self.MKRightBtnViewSize.width);
            make.top.equalTo(self.mutArr.lastObject.mas_bottom).offset(self.offset);
        }];
        [self.mutArr addObject:_mkCommentView];
        [self layoutIfNeeded];
        [_mkCommentView layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                            imageTitleSpace:5];
    }return _mkCommentView;
}

-(UIButton *)mkShareView{
    if (!_mkShareView) {
        _mkShareView = UIButton.new;

        [_mkShareView setImage:JobsBuddleIMG(@"bundle", @"Others",nil,@"分享")
                      forState:UIControlStateNormal];
        _mkShareView.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        @jobs_weakify(self)
        [[_mkShareView rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            NSLog(@"我是分享");
            [x.imageView addViewAnimationWithCompletionBlock:^(id data) {
                @jobs_strongify(self)
                self->_mkShareView.tag = MKRightBtnViewBtnType_mkShareView;//写在block外部，此值异常
                if (self.MKRightBtnViewBlock) self.MKRightBtnViewBlock(self->_mkShareView);
            }];
        }];
        [self addSubview:_mkShareView];
        [_mkShareView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.mas_equalTo(self.MKRightBtnViewSize.width);
            make.top.equalTo(self.mutArr.lastObject.mas_bottom).offset(self.offset);
        }];
        [self.mutArr addObject:_mkShareView];
        [self layoutIfNeeded];
        [_mkShareView setTitle:@"分享" forState:UIControlStateNormal];
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
        _offset = (self.MKRightBtnViewSize.height - self.MKRightBtnViewSize.width * 3) / 2;
    }return _offset;
}

@end
