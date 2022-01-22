//
//  MyFansTBVCell.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MyFansTBVCell.h"

@interface MyFansTBVCell ()

@end

@implementation MyFansTBVCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    MyFansTBVCell *cell = (MyFansTBVCell *)[tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[MyFansTBVCell alloc]initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:ReuseIdentifier];
        cell.offsetXForEach = 10;
        cell.offsetYForEach = 20;
        //加阴影立体效果
        [UIView makeTargetShadowview:cell
                           superView:nil
                     shadowDirection:ShadowDirection_rightDown
                   shadowWithOffsetX:5
                             offsetY:5
                        cornerRadius:8
                        shadowOffset:JobsDefaultSize
                       shadowOpacity:1
                    layerShadowColor:JobsDefaultObj
                   layerShadowRadius:JobsDefaultValue];
    }return cell;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}

-(void)setFrame:(CGRect)frame{
    frame.origin.x += self.offsetXForEach;
    frame.origin.y += self.offsetYForEach;
    frame.size.width -= self.offsetXForEach * 2;
    frame.size.height -= self.offsetYForEach;
//    NSLog(@"---- x= %.f, y = %.f, w = %.f, h = %.f ----", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    [super setFrame:frame];
}
#pragma mark —— BaseCellProtocol
+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return 238;
}

- (void)richElementsInCellWithModel:(id _Nullable)model{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:@" "]
                    placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpeg",[model intValue]]]];
}
#pragma mark —— lazyLoad
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = UIImageView.new;
        _imgView.clipsToBounds = YES;
        _imgView.layer.cornerRadius = 20;
        [self.contentView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }return _imgView;
}

@end
