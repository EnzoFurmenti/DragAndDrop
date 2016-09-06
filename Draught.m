//
//  Draught.m
//  DragAndDrop
//
//  Created by EnzoF on 01.09.16.
//  Copyright © 2016 EnzoF. All rights reserved.
//

#import "Draught.h"

@implementation Draught

-(instancetype)initWithFrame:(CGRect)frame withColor:(UIColor*)color{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.layer.cornerRadius = CGRectGetWidth(frame) / 2;
        self.backgroundColor = color;
    }
    return self;
}


@end
