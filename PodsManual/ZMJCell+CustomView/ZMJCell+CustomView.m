//
//  ZMJCell+CustomView.m
//  Casino
//
//  Created by Jobs on 2021/12/8.
//

#import "ZMJCell+CustomView.h"

@implementation ZMJCell (CustomView)

static char *ZMJCell_CustomView_label = "ZMJCell_CustomView_label";
static char *ZMJCell_CustomView_colorBarView = "ZMJCell_CustomView_colorBarView";
static char *ZMJCell_CustomView_color = "ZMJCell_CustomView_color";

@dynamic label;
@dynamic colorBarView;
@dynamic color;

#pragma mark —— @property(nonatomic,strong)UILabel *label;
-(UILabel *)label{
    UILabel *Label = objc_getAssociatedObject(self, ZMJCell_CustomView_label);
    if (!Label) {
        Label = UILabel.new;
        Label.frame = self.bounds;
        Label.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        Label.font = [UIFont boldSystemFontOfSize:10.f];
        Label.textAlignment = NSTextAlignmentCenter;
        Label.numberOfLines = 0;
        [self.contentView addSubview:Label];
        
        objc_setAssociatedObject(self,
                                 ZMJCell_CustomView_label,
                                 Label,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return Label;
}

-(void)setLabel:(UILabel *)label{
    objc_setAssociatedObject(self,
                             ZMJCell_CustomView_label,
                             label,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UIView  *colorBarView;
-(UIView *)colorBarView{
    UIView *ColorBarView = objc_getAssociatedObject(self, ZMJCell_CustomView_colorBarView);
    if (!ColorBarView) {
        ColorBarView = UIView.new;
        ColorBarView.backgroundColor = self.color;
        ColorBarView.frame = CGRectInset(self.bounds, 2, 2);
        [self.contentView addSubview:ColorBarView];
        objc_setAssociatedObject(self,
                                 ZMJCell_CustomView_colorBarView,
                                 ColorBarView,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return ColorBarView;
}

-(void)setColorBarView:(UIView *)colorBarView{
    objc_setAssociatedObject(self,
                             ZMJCell_CustomView_colorBarView,
                             colorBarView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UIColor *color;
-(UIColor *)color{
    UIColor *Color = objc_getAssociatedObject(self, ZMJCell_CustomView_color);
    if (!Color) {
        Color = UIColor.blueColor;
        objc_setAssociatedObject(self,
                                 ZMJCell_CustomView_color,
                                 Color,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return Color;
}

-(void)setColor:(UIColor *)color{
    objc_setAssociatedObject(self,
                             ZMJCell_CustomView_color,
                             color,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

