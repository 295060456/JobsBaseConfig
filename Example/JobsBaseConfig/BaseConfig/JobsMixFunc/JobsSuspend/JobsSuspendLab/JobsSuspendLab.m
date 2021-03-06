//
//  JobsSuspendLab.m
//  Search
//
//  Created by Jobs on 2020/8/13.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JobsSuspendLab.h"

@interface JobsSuspendLab ()

@end

@implementation JobsSuspendLab

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = self.backgroundColor ? :JobsBlackColor;
        self.text = [NSString ensureNonnullString:self.text
                                       replaceStr:Internationalization(@"No Data")];
        self.internationalizationKEY = @"No Data";
        self.textAlignment = NSTextAlignmentCenter;
        [self cornerCutToCircleWithCornerRadius:8];
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.panRcognize.enabled = self.isAllowDrag;
    self.userInteractionEnabled = self.isAllowDrag;
}

-(void)actionSuspendViewBlock:(jobsByIDBlock _Nullable)suspendLabBlock{
    self.suspendLabBlock = suspendLabBlock;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    if (self.suspendLabBlock) {
        self.suspendLabBlock(@1);
    }
}

@end
