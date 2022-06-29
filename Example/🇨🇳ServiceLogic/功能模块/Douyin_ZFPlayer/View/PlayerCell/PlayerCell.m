//
//  PlayerCell.m
//  DouYin
//
//  Created by Jobs on 2020/9/23.
//

#import "PlayerCell.h"
#import "CustomZFPlayerControlView.h"

@interface PlayerCell ()

/// UI
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong,nullable)CustomZFPlayerControlView *customPlayerControlView;
/// Data
@property(nonatomic,strong,nullable)ZFAVPlayerManager *playerManager;
@property(nonatomic,copy)jobsByTwoIDBlock playerCellBlock;
@property(nonatomic,strong)VideoModel_Core *videoModel_Core;

@end

@implementation PlayerCell

@synthesize index = _index;
-(void)dealloc {
    NSLog(@"%@",JobsLocalFunc);
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    PlayerCell *cell = (PlayerCell *)[tableView tableViewCellClass:PlayerCell.class];
    if (!cell) {
        cell = [PlayerCell initTableViewCellWithStyle:UITableViewCellStyleSubtitle];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = RandomColor;
        [NSNotificationCenter.defaultCenter addObserver:self
                                               selector:@selector(noti1)
                                                   name:@"noti1"
                                                 object:nil];
    }return cell;
}

-(void)noti1{
    NSLog(@"接收 不带参数的消息");
    [self.player.currentPlayerManager stop];
    
    self.player = nil;
    self.playerManager = nil;
    [self.customPlayerControlView removeFromSuperview];
    self.customPlayerControlView = nil;
}
#pragma mark —— BaseCellProtocol
+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return JobsMainScreen_HEIGHT();
}

-(void)richElementsInCellWithModel:(UIViewModel *_Nullable)model{
    if ([model isKindOfClass:UIViewModel.class]) {
        self.viewModel = model;
        self.label.text = [NSString stringWithFormat:@"%ld",(long)self.viewModel.row];
        self.videoModel_Core = (VideoModel_Core *)self.viewModel.data;
    }
}

-(void)actionBlockPlayerCell:(jobsByTwoIDBlock _Nullable)playerCellBlock{
    self.playerCellBlock = playerCellBlock;
}
#pragma mark —— lazyLoad
-(UILabel *)label{
    if (!_label) {
        _label = UILabel.new;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:100
                                        weight:UIFontWeightRegular];
        _label.backgroundColor = self.contentView.backgroundColor;
        [self.contentView addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }return _label;
}

-(ZFAVPlayerManager *)playerManager{
    if (!_playerManager) {
        _playerManager = ZFAVPlayerManager.new;
        _playerManager.shouldAutoPlay = YES;
        NSString *str = self.videoModel_Core.videoIdcUrl;
        _playerManager.assetURL = [NSURL URLWithString:str];
    }return _playerManager;
}

-(CustomZFPlayerControlView *)customPlayerControlView{
    if (!_customPlayerControlView) {
        _customPlayerControlView = CustomZFPlayerControlView.new;
        @jobs_weakify(self)
        [_customPlayerControlView actionCustomZFPlayerControlViewBlock:^(NSString *data, NSNumber *data2) {
            @jobs_strongify(self)
            if ([data isEqualToString:@"gestureEndedPan:panDirection:panLocation:"]) {
                if (data2.intValue == ZFPanMovingDirectionTop) {
                    if (self.playerCellBlock) self.playerCellBlock(@0,@(self.index));
                }else if (data2.intValue == ZFPanMovingDirectionBottom){
                    if (self.playerCellBlock) self.playerCellBlock(@1,@(self.index));
                }else{}
            }
        }];
    }return _customPlayerControlView;
}

-(ZFPlayerController *)player{
    if (!_player) {
        @jobs_weakify(self)
        _player = [ZFPlayerController.alloc initWithPlayerManager:self.playerManager
                                                    containerView:self.contentView];
        _player.controlView = self.customPlayerControlView;
//        ZFPlayer_DoorVC = _player;
        [_player setPlayerDidToEnd:^(id<ZFPlayerMediaPlayback> _Nonnull asset) {
            @jobs_strongify(self)
            [self.playerManager replay];//设置循环播放
        }];
    }return _player;
}

@end
