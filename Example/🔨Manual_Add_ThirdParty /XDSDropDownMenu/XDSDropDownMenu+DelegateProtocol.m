//
//  XDSDropDownMenu+DelegateProtocol.m
//  ShengAi
//
//  Created by 刘赓 on 2018/12/5.
//  Copyright © 2018 刘赓. All rights reserved.
//

#import "XDSDropDownMenu+DelegateProtocol.h"

@implementation XDSDropDownMenu (DelegateProtocol)

-(void)UITableViewDelegateProtocol{
    
    self.menuTableView.delegate = self;
    
    self.menuTableView.dataSource = self;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.titleList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    if ([self.imageList count] == [self.titleList count]) {
        cell.textLabel.text =[self.titleList objectAtIndex:indexPath.row];
        cell.imageView.image = [self.imageList objectAtIndex:indexPath.row];
    } else if ([self.imageList count] > [self.titleList count]) {
        cell.textLabel.text =[self.titleList objectAtIndex:indexPath.row];
        if (indexPath.row < [self.imageList count]) {
            cell.imageView.image = [self.imageList objectAtIndex:indexPath.row];
        }
    } else if ([self.imageList count] < [self.titleList count]) {
        cell.textLabel.text =[self.titleList objectAtIndex:indexPath.row];
        if (indexPath.row < [self.imageList count]) {
            cell.imageView.image = [self.imageList objectAtIndex:indexPath.row];
        }
    }
    
    cell.textLabel.textColor = [UIColor blackColor];
    UIView * v = [[UIView alloc] init];
    v.backgroundColor = [UIColor grayColor];
    cell.selectedBackgroundView = v;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideDropDownMenuWithBtnFrame:self.buttonFrame];
    
    UITableViewCell *c = [tableView cellForRowAtIndexPath:indexPath];
    [self.btnSender setTitle:c.textLabel.text forState:UIControlStateNormal];
    
    for (UIView *subview in self.btnSender.subviews) {
        if ([subview isKindOfClass:[UIImageView class]]) {
            [subview removeFromSuperview];
        }
    }
    self.imageView.image = c.imageView.image;
    self.imageView = [[UIImageView alloc] initWithImage:c.imageView.image];
    self.imageView.frame = CGRectMake(5, 5, 25, 25);
    [self.btnSender addSubview:self.imageView];
    
    [self myDelegate];
}


@end
