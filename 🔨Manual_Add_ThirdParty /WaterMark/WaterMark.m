//
//  WaterMark.m
//  My_BaseProj
//
//  Created by Administrator on 07/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import "WaterMark.h"

@interface WaterMark (){
}

@property(nonatomic,assign)CGFloat lableWidth;
@property(nonatomic,assign)CGFloat lableHeight;
@property(nonatomic,assign)CGFloat lableOffset_level;//lable之间的水平间距
@property(nonatomic,assign)CGFloat lableOffset_vertical;//lable之间的垂直间距
//用数组嵌套进行记录
@property(nonatomic,strong)NSMutableArray *listLab;//列

@end

@implementation WaterMark

-(instancetype)initWithLableWidth:(CGFloat)lableWidth
                      LableHeight:(CGFloat)lableHeight
                LableOffset_level:(CGFloat)lableOffset_level
             LableOffset_vertical:(CGFloat)lableOffset_vertical{
    
    if (self = [super init]) {
        
        self.clipsToBounds = YES;//子视图超出父视图，超出部分裁剪掉
        
        self.lableWidth = lableWidth;
        
        self.lableHeight = lableHeight;
        
        self.lableOffset_level = lableOffset_level;
        
        self.lableOffset_vertical = lableOffset_vertical;
        
        [self makeLabel];
        
    }return self;
}

-(void)makeLabel{
    
    int intNumRow =  SCREEN_WIDTH / (self.lableWidth + self.lableOffset_level);

    float floatNumRow = SCREEN_WIDTH / (self.lableWidth + self.lableOffset_level);
    
    int intNumList = SCREEN_HEIGHT / (self.lableHeight + self.lableOffset_vertical);
    
    float floatNumList = SCREEN_HEIGHT / (self.lableHeight + self.lableOffset_vertical);
    
    //定义一行有多少个
    intNumRow = (floatNumRow - intNumRow >= 0.5)?++intNumRow:intNumRow;
    
    //定义一列有多少个
    intNumList = (floatNumList - intNumList >= 0.5)?++intNumList:intNumList;

    //先行走完再按列走
    for (int list = 0; list < intNumList; list++) {//21

        int row;
        
        NSMutableArray *rowLab = NSMutableArray.array;
        
        NSMutableArray *copyRowLab = NSMutableArray.array;
        
        for (row = 0; row < intNumRow; row++) {//7
            
            UILabel *lab  = UILabel.new;
            
            lab.text = @"💰";
            
//            lab.backgroundColor = RANDOMRGBCOLOR;
            
            [self addSubview:lab];
            
            if (copyRowLab.lastObject) {
                
                UILabel *label = copyRowLab.lastObject;
                
                lab.frame = CGRectMake(label.mj_x + label.mj_w + self.lableOffset_level, label.mj_y, self.lableWidth, self.lableHeight);
            }else{
                
                lab.frame = CGRectMake(0, (self.lableHeight + self.lableOffset_vertical) * list, self.lableWidth, self.lableHeight);
            }
            
            lab.transform = CGAffineTransformMakeRotation(M_PI * -40/180);

            [rowLab addObject:lab];
            
            [copyRowLab addObject:lab];
        }
        
        [self.listLab addObject:rowLab];
        
        [copyRowLab removeAllObjects];
    }   
}

//获取一个随机整数，范围在[from,to]，包括from，包括to
-(int)getRandomNumber:(int)from
                   to:(int)to{
    
    return (int)(from + (arc4random() % (to - from + 1)));
}

-(NSMutableArray *)listLab{
    
    if (!_listLab) {
        
        _listLab = NSMutableArray.array;
    }
    
    return _listLab;
}


@end
