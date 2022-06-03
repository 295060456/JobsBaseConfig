//
//  BaseTableViewCell.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2021/1/20.
//  Copyright © 2021 MonkeyKingVideo. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface BaseTableViewCell ()

@end

@implementation BaseTableViewCell
#pragma mark —— @synthesize UITableViewCellProtocol
UITableViewCellProtocol_synthesize
#pragma mark —— UITableViewCellProtocol
+(instancetype)cellWithTableView:(UITableView *)tableView{
    BaseTableViewCell *cell = (BaseTableViewCell *)[tableView tableViewCellClass:BaseTableViewCell.class];
    if (!cell) {
        cell = [BaseTableViewCell initTableViewCellWithStyle:UITableViewCellStyleValue1];
    }return cell;
}

+(instancetype)cellWithTableView:(UITableView *)tableView
           cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseTableViewCell *cell = [BaseTableViewCell cellWithTableView:tableView];
    cell.indexPath = indexPath;
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
//        [self richElementsInCellWithModel:nil];
        self.selectionStyle = UITableViewCellSelectionStyleNone;// 取消点击效果 【不能在cellWithTableView里面写】
        /// 适配iOS 13夜间模式/深色外观(Dark Mode)
        self.backgroundColor = [UIColor xy_createWithLightColor:UIColor.whiteColor darkColor:UIColor.whiteColor];
        self.detailTextLabel.textColor = UIColor.brownColor;
        self.textLabel.textColor = UIColor.blackColor;
    }return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    /// 修改 UITableViewCell 中默认子控件的frame
    NSLog(@"%f",self.textLabelFrame.size.width);
    NSLog(@"%f",self.textLabelFrame.size.height);
    NSLog(@"%f",self.textLabelFrame.origin.x);
    NSLog(@"%f",self.textLabelFrame.origin.y);
    
    NSLog(@"%f",self.detailTextLabelFrame.size.width);
    NSLog(@"%f",self.detailTextLabelFrame.size.height);
    NSLog(@"%f",self.detailTextLabelFrame.origin.x);
    NSLog(@"%f",self.detailTextLabelFrame.origin.y);
    
    NSLog(@"%f",self.imageViewFrame.size.width);
    NSLog(@"%f",self.imageViewFrame.size.height);
    NSLog(@"%f",self.imageViewFrame.origin.x);
    NSLog(@"%f",self.imageViewFrame.origin.y);
    
    NSLog(@"%f",self.textLabelWidth);
    NSLog(@"%f",self.detailTextLabelWidth);

    NSLog(@"%f",self.textLabelFrameOffsetX);
    NSLog(@"%f",self.textLabelFrameOffsetY);
    NSLog(@"%f",self.textLabelFrameOffsetWidth);
    NSLog(@"%f",self.textLabelFrameOffsetHeight);
    
    NSLog(@"%f",self.detailTextLabelOffsetX);
    NSLog(@"%f",self.detailTextLabelOffsetY);
    NSLog(@"%f",self.detailTextLabelOffsetWidth);
    NSLog(@"%f",self.detailTextLabelOffsetHeight);
    
    NSLog(@"%f",self.imageViewFrameOffsetX);
    NSLog(@"%f",self.imageViewFrameOffsetY);
    NSLog(@"%f",self.imageViewFrameOffsetWidth);
    NSLog(@"%f",self.imageViewFrameOffsetHeight);
    /// 直接设置新的Frame
    if (!zeroRectValue(self.textLabelFrame)) {
        self.textLabel.frame = self.textLabelFrame;
    }
    
    if (!zeroRectValue(self.detailTextLabelFrame)) {
        self.detailTextLabel.frame = self.detailTextLabelFrame;
    }

    if (!zeroRectValue(self.imageViewFrame)) {
        self.imageView.frame = self.imageViewFrame;
    }
    /// UITableViewCell系统自带控件的自定义宽度
    if (self.textLabelWidth) {
        CGRect textLabelFrame = self.textLabel.frame;
        textLabelFrame.size.width = self.textLabelWidth;
        self.textLabel.frame = textLabelFrame;
    }
    
    if (self.detailTextLabelWidth) {
        CGRect detailTextLabelFrame = self.detailTextLabel.frame;
        detailTextLabelFrame.size.width = self.detailTextLabelWidth;
        self.detailTextLabel.frame = detailTextLabelFrame;
    }
    /// 依据偏移量来设置Frame
    {
        UIViewModel *viewModel = UIViewModel.new;
        viewModel.offsetXForEach = self.textLabelFrameOffsetX;
        viewModel.offsetYForEach = self.textLabelFrameOffsetY;
        viewModel.offsetWidth = self.textLabelFrameOffsetWidth;
        viewModel.offsetHeight = self.textLabelFrameOffsetHeight;
        
        [self.textLabel offsetForView:viewModel];
    }
    
    {
        UIViewModel *viewModel = UIViewModel.new;
        viewModel.offsetXForEach = self.detailTextLabelOffsetX;
        viewModel.offsetYForEach = self.detailTextLabelOffsetY;
        viewModel.offsetWidth = self.detailTextLabelOffsetWidth;
        viewModel.offsetHeight = self.detailTextLabelOffsetHeight;
        
        [self.detailTextLabel offsetForView:viewModel];
    }
    {
        UIViewModel *viewModel = UIViewModel.new;
        viewModel.offsetXForEach = self.imageViewFrameOffsetX;
        viewModel.offsetYForEach = self.imageViewFrameOffsetY;
        viewModel.offsetWidth = self.imageViewFrameOffsetWidth;
        viewModel.offsetHeight = self.imageViewFrameOffsetHeight;
        
        [self.imageView offsetForView:viewModel];
    }
}
// 在具体的子类去实现,分类调用异常
-(void)setFrame:(CGRect)frame{
    NSLog(@"self.offsetXForEach = %f",self.offsetXForEach);
    NSLog(@"self.offsetYForEach = %f",self.offsetYForEach);
    frame.origin.x += self.offsetXForEach;
    frame.origin.y += self.offsetYForEach;
    frame.size.height -= self.offsetYForEach * 2;
    frame.size.width -= self.offsetXForEach * 2;
    [super setFrame:frame];
}
#pragma mark —— BaseViewProtocol
/// 具体由子类进行复写【数据定高】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGFloat)heightForFooterInSection:(id _Nullable)model{
    return JobsWidth(10);
}
/// 具体由子类进行复写【数据定高】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGFloat)heightForHeaderInSection:(id _Nullable)model{
    return JobsWidth(10);
}
#pragma mark —— BaseCellProtocol
-(void)richElementsInCellWithModel:(UIViewModel *_Nullable)model{
    if (model) {
        self.viewModel = model;
        
        if (model.textModel.attributedText) {
            self.textLabel.attributedText = model.textModel.attributedText;
        }else{
            self.textLabel.text = [NSString stringWithFormat:@"%@",model.textModel.text];
            self.textLabel.textColor = self.viewModel.textModel.textCor;
            self.textLabel.font = self.viewModel.textModel.font;
        }
        
        if (model.subTextModel.attributedText) {
            self.detailTextLabel.attributedText = model.subTextModel.attributedText;
        }else{
            self.detailTextLabel.text = [NSString stringWithFormat:@"%@",model.subTextModel.text];
            self.detailTextLabel.textColor = self.viewModel.subTextModel.textCor;
            self.detailTextLabel.font = self.viewModel.subTextModel.font;
            [self.detailTextLabel makeLabelByShowingType:UILabelShowingType_05];
        }
    }
}

+(CGFloat)cellHeightWithModel:(UIViewModel *_Nullable)model{
    
    UIViewModel *vm = UIViewModel.new;
    vm.textModel.font = [UIFont systemFontOfSize:JobsWidth(14) weight:UIFontWeightRegular];
    vm.jobsWidth = JobsMainScreen_WIDTH() - JobsWidth(200);
    vm.textModel.text = model.subTextModel.text;
    vm.textModel.textLineSpacing = 0;
    
    return [UIView heightByData:vm] + JobsWidth(20);
}
#pragma mark —— 协议属性合成set & get方法
/// UIViewModelProtocol
UIViewModelProtocol_synthesize
-(void)setindexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}

-(NSIndexPath *)indexPath{
    return _indexPath;
}

@end
