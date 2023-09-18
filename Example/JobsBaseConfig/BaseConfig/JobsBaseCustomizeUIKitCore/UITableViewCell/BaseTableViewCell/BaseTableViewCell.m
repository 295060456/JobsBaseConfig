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
/// 4种UITableViewCell系统样式类型
/// UITableViewCellStyleDefault ：左边有一个显示图片的imageView和一个标题textLabel。
+(instancetype)cellStyleDefaultWithTableView:(UITableView *)tableView{
    BaseTableViewCell *cell = (BaseTableViewCell *)[tableView tableViewCellClass:BaseTableViewCell.class];
    if (!cell) {
        cell = [self initTableViewCell:self
                             withStyle:UITableViewCellStyleDefault];
        [self settingForTableViewCell:cell];
    }return cell;
}
/// UITableViewCellStyleValue1 ：左边显示图片的imageView和一个主标题textLabel，右边一个副标题detailTextLabel。
+(instancetype)cellStyleValue1WithTableView:(UITableView *)tableView{
    BaseTableViewCell *cell = (BaseTableViewCell *)[tableView tableViewCellClass:BaseTableViewCell.class];
    if (!cell) {
        cell = [self initTableViewCell:self
                             withStyle:UITableViewCellStyleValue1];
        [self settingForTableViewCell:cell];
    }return cell;
}
/// UITableViewCellStyleValue2 ：左边一个主标题textLabel字体偏小，右边一个副标题detailTextLabel。
+(instancetype)cellStyleValue2WithTableView:(UITableView *)tableView{
    BaseTableViewCell *cell = (BaseTableViewCell *)[tableView tableViewCellClass:BaseTableViewCell.class];
    if (!cell) {
        cell = [self initTableViewCell:self
                             withStyle:UITableViewCellStyleValue2];
        [self settingForTableViewCell:cell];
    }return cell;
}
/// UITableViewCellStyleSubtitle ：左边还是一个显示图片的imageView，不同的是上边有一个主标题textLabel和一个副标题detailTextLabel。主标题字体大且加黑，副标题字体小在主标题下边。
+(instancetype)cellStyleSubtitleWithTableView:(UITableView *)tableView{
    BaseTableViewCell *cell = (BaseTableViewCell *)[tableView tableViewCellClass:BaseTableViewCell.class];
    if (!cell) {
        cell = [self initTableViewCell:self
                             withStyle:UITableViewCellStyleSubtitle];
        [self settingForTableViewCell:cell];
    }return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
//        [self richElementsInCellWithModel:nil];
        self.selectionStyle = UITableViewCellSelectionStyleNone;// 取消点击效果 【不能在cellStyleValue1WithTableView里面写】
        /// 适配iOS 13夜间模式/深色外观(Dark Mode)
        self.backgroundColor = JobsWhiteColor;
        self.detailTextLabel.textColor = JobsBrownColor;
        self.textLabel.textColor = JobsBlackColor;
    }return self;
}
#pragma mark —— 一些私有方法
-(void)printValue{
    NSLog(@"self.textLabelFrame = %@",NSStringFromCGRect(self.textLabelFrame));
    NSLog(@"self.detailTextLabelFrame = %@",NSStringFromCGRect(self.detailTextLabelFrame));
    NSLog(@"self.imageViewFrame = %@",NSStringFromCGRect(self.imageViewFrame));
    
    NSLog(@"self.textLabelSize = %@",NSStringFromCGSize(self.textLabelSize));
    NSLog(@"self.detailTextLabelSize = %@",NSStringFromCGSize(self.detailTextLabelSize));
    NSLog(@"self.imageViewSize = %@",NSStringFromCGSize(self.imageViewSize));
    
    NSLog(@"self.textLabelWidth = %f",self.textLabelWidth);
    NSLog(@"self.textLabelHeight = %f",self.textLabelHeight);
    NSLog(@"self.detailTextLabelWidth = %f",self.detailTextLabelWidth);
    NSLog(@"elf.detailTextLabelHeight = %f",self.detailTextLabelHeight);
    NSLog(@"self.imageViewWidth = %f",self.imageViewWidth);
    NSLog(@"self.imageViewHeight = %f",self.imageViewHeight);
    
    NSLog(@"self.textLabelFrameOffsetX = %f",self.textLabelFrameOffsetX);
    NSLog(@"self.textLabelFrameOffsetY = %f",self.textLabelFrameOffsetY);
    NSLog(@"self.textLabelFrameOffsetWidth = %f",self.textLabelFrameOffsetWidth);
    NSLog(@"self.textLabelFrameOffsetHeight = %f",self.textLabelFrameOffsetHeight);
    
    NSLog(@"self.detailTextLabelOffsetX = %f",self.detailTextLabelOffsetX);
    NSLog(@"self.detailTextLabelOffsetY = %f",self.detailTextLabelOffsetY);
    NSLog(@"self.detailTextLabelOffsetWidth = %f",self.detailTextLabelOffsetWidth);
    NSLog(@"self.detailTextLabelOffsetHeight = %f",self.detailTextLabelOffsetHeight);
    
    NSLog(@"self.imageViewFrameOffsetX = %f",self.imageViewFrameOffsetX);
    NSLog(@"self.imageViewFrameOffsetY = %f",self.imageViewFrameOffsetY);
    NSLog(@"self.imageViewFrameOffsetWidth = %f",self.imageViewFrameOffsetWidth);
    NSLog(@"self.imageViewFrameOffsetHeight = %f",self.imageViewFrameOffsetHeight);
}
#pragma mark —— 子类重写父类方法
- (void)setSelected:(BOOL)selected
           animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
/// 程肖斌所言 全局只有在cellForRowAtIndexPath里面才能设置真正的selected值。而didSelectRowAtIndexPath不行
-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    NSLog(@"%d",self.selected);
}
//@synthesize selected = _selected;
//-(void)setSelected:(BOOL)selected{
//    selected = _selected;
//}

-(void)setEditing:(BOOL)editing
         animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
}
 
-(void)layoutSubviews{
    [super layoutSubviews];
    [self printValue];
    /// 取内部类UITableViewCellEditControl,对编辑状态的Cell的点击按钮进行替换成自定义的
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *view in control.subviews){
                if ([view isKindOfClass:UIImageView.class]) {
                    UIImageView *img = (UIImageView *)view;
                    if (JobsIMG(@"按钮已选中") && JobsIMG(@"按钮未选中")) {
                        img.image = self.selected ? JobsIMG(@"按钮已选中") : JobsIMG(@"按钮未选中");
                    }
                }
            }
        }
    }
    /// 修改 UITableViewCell 中默认子控件的frame
    {///【组 1】 UITableViewCell单独自定义设置系统自带控件的Frame 【形成Frame后直接return，避免被其他中间过程修改】❤️与组2、3属性互斥❤️
        if (!zeroRectValue(self.textLabelFrame)) {
            self.textLabel.frame = self.textLabelFrame;
        }
        
        if (!zeroRectValue(self.detailTextLabelFrame)) {
            self.detailTextLabel.frame = self.detailTextLabelFrame;
        }

        if (!zeroRectValue(self.imageViewFrame)) {
            self.imageView.frame = self.imageViewFrame;
        }
        
        if (!zeroRectValue(self.textLabelFrame) ||
            !zeroRectValue(self.detailTextLabelFrame) ||
            !zeroRectValue(self.imageViewFrame)) return;
    }
    
    {///【组 2】UITableViewCell单独自定义设置系统自带控件的Size【形成Frame后直接return，避免被其他中间过程修改】❤️与组1、3属性互斥❤️
        if (!zeroSizeValue(self.textLabelSize)) {
            CGRect textLabelFrame = self.textLabel.frame;
            textLabelFrame.size = self.textLabelSize;
            textLabelFrame.origin.x += self.textLabelFrameOffsetX;
            textLabelFrame.origin.y += self.textLabelFrameOffsetY;
            self.textLabel.frame = textLabelFrame;
        }
        
        if (!zeroSizeValue(self.detailTextLabelSize)) {
            CGRect detailTextLabelFrame = self.detailTextLabel.frame;
            detailTextLabelFrame.size = self.detailTextLabelSize;
            detailTextLabelFrame.origin.x += self.detailTextLabelOffsetX;
            detailTextLabelFrame.origin.y += self.detailTextLabelOffsetY;
            self.detailTextLabel.frame = detailTextLabelFrame;
        }
        
        if (!zeroSizeValue(self.imageViewSize)) {
            CGRect imageViewFrame = self.imageView.frame;
            imageViewFrame.size = self.imageViewSize;
            imageViewFrame.origin.x += self.imageViewFrameOffsetX;
            imageViewFrame.origin.y += self.imageViewFrameOffsetY;
            self.imageView.frame = imageViewFrame;
        }
        
        if (!zeroSizeValue(self.textLabelSize) ||
            !zeroSizeValue(self.detailTextLabelSize) ||
            !zeroSizeValue(self.imageViewSize)) return;
    }
    
    {///【组 3】UITableViewCell单独自定义设置系统自带控件的宽高【形成Frame后直接return，避免被其他中间过程修改】❤️与组1、2属性互斥❤️
        if (self.textLabelWidth) {
            CGRect textLabelFrame = self.textLabel.frame;
            textLabelFrame.size.width = self.textLabelWidth;
            textLabelFrame.origin.x += self.textLabelFrameOffsetX;
            textLabelFrame.origin.y += self.textLabelFrameOffsetY;
            self.textLabel.frame = textLabelFrame;
        }
        
        if (self.textLabelHeight) {
            CGRect textLabelFrame = self.textLabel.frame;
            textLabelFrame.size.height = self.textLabelHeight;
            textLabelFrame.origin.x += self.textLabelFrameOffsetX;
            textLabelFrame.origin.y += self.textLabelFrameOffsetY;
            self.detailTextLabel.frame = textLabelFrame;
        }
        
        if (self.detailTextLabelWidth) {
            CGRect detailTextLabelFrame = self.detailTextLabel.frame;
            detailTextLabelFrame.size.width = self.detailTextLabelWidth;
            detailTextLabelFrame.origin.x += self.detailTextLabelOffsetX;
            detailTextLabelFrame.origin.y += self.detailTextLabelOffsetY;
            self.detailTextLabel.frame = detailTextLabelFrame;
        }
        
        if (self.detailTextLabelHeight) {
            CGRect detailTextLabelFrame = self.detailTextLabel.frame;
            detailTextLabelFrame.size.height = self.detailTextLabelHeight;
            detailTextLabelFrame.origin.x += self.detailTextLabelOffsetX;
            detailTextLabelFrame.origin.y += self.detailTextLabelOffsetY;
            self.detailTextLabel.frame = detailTextLabelFrame;
        }
        
        if (self.imageViewWidth) {
            CGRect imageViewFrame = self.imageView.frame;
            imageViewFrame.size.width = self.imageViewWidth;
            imageViewFrame.origin.x += self.imageViewFrameOffsetX;
            imageViewFrame.origin.y += self.imageViewFrameOffsetY;
            self.imageView.frame = imageViewFrame;
        }
        
        if (self.imageViewHeight) {
            CGRect imageViewFrame = self.imageView.frame;
            imageViewFrame.size.height = self.imageViewHeight;
            imageViewFrame.origin.x += self.imageViewFrameOffsetX;
            imageViewFrame.origin.y += self.imageViewFrameOffsetY;
            self.imageView.frame = imageViewFrame;
        }
        
        if (self.textLabelWidth ||
            self.textLabelHeight ||
            self.detailTextLabelWidth ||
            self.detailTextLabelHeight ||
            self.imageViewWidth ||
            self.imageViewHeight)  return;
    }
    
    {/// 【组 4】UITableViewCell单独自定义设置系统自带控件的偏移量
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
}
/**
 1、-(void)setFrame:(CGRect)frame 此方法仅限于具体的 UITableViewCell子类使用
 2、如果在 BaseTableViewCell 实现此方法，那么一单相关子类集成 BaseTableViewCell 则会对-(void)setFrame:(CGRect)frame进行反复调用，因为[super setFrame:frame];
 3、禁止分类去调用，否则引起异常
 */
-(void)setFrame:(CGRect)frame{
    if (self.class == BaseTableViewCell.class) {
        NSLog(@"self.offsetXForEach = %f",self.offsetXForEach);
        NSLog(@"self.offsetYForEach = %f",self.offsetYForEach);
        frame.origin.x += self.offsetXForEach;
        frame.origin.y += self.offsetYForEach;
        frame.size.height -= self.offsetYForEach * 2;
        frame.size.width -= self.offsetXForEach * 2;
    }
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
/// 获取绑定的数据源
-(UIViewModel *)getViewModel{
    return _viewModel;
}
#pragma mark —— BaseCellProtocol
-(void)richElementsInCellWithModel:(UIViewModel *_Nullable)model{
    if (model) {
        self.viewModel = model;
        
        /**
         - NSString -
         -(NSString *)omitByReplaceStr:(NSString *_Nullable)replaceStr
                       replaceStrLenth:(NSInteger)replaceStrLenth
                         lineBreakMode:(NSLineBreakMode)lineBreakMode
                                 limit:(NSInteger)limit;
         */
        
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
        
        self.imageView.image = self.viewModel.image;
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
-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}

-(NSIndexPath *)indexPath{
    return _indexPath;
}

@end
