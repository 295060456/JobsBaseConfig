//
//  WBTableViewCell.m
//
//  Created by Transuner on 16/3/9.
//  Copyright © 2016年 吴冰. All rights reserved.
//

#import "WBTableViewCell.h"

@implementation WBTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style
               reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }return self;
}

+ (instancetype) cellAllocWithTableView:(UITableView *)tableView {
    WBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (!cell) {
        cell = [[[self class] alloc] initWithStyle:0
                                   reuseIdentifier:NSStringFromClass([self class])];
    }return cell;
}


@end
