//
//  AutoScrollLabel.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/18.
//

#import "BaseLabel.h"

@interface BaseLabel ()

@end

@implementation BaseLabel

-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

- (void)drawRect:(CGRect)rect{
    if (self.labelShowingType == UILabelShowingType_02) {
        self.layer.masksToBounds = true;
        if (!self.shouldAutoScroll){
            [super drawRect:rect];
        }
        [self setTextLayerScroll];
    }else{
        [super drawRect:rect];
    }
}

-(void)setFrame:(CGRect)frame{
    if (self.labelShowingType == UILabelShowingType_02) {
        [self setTextLayerScroll];
    }else{
        [super setFrame:frame];
    }
}

@end
