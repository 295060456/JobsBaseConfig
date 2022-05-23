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

#pragma mark —— UIViewModelProtocol
UIViewModelProtocol_synthesize

+(instancetype)cellWithTableView:(UITableView *)tableView{
    BaseTableViewCell *cell = (BaseTableViewCell *)[tableView tableViewCellClass:BaseTableViewCell.class];
    if (!cell) {
        cell = [BaseTableViewCell initTableViewCellWithStyle:UITableViewCellStyleValue1];
    }return cell;
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
-(void)setindexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}

-(NSIndexPath *)indexPath{
    return _indexPath;
}

@end
