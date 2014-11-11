//
//  ColorBoxView.m
//  GraphicalCardGame
//
//  Created by LuQuan Intrepid on 11/10/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import "ColorBoxView.h"

@implementation ColorBoxView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.layer.borderWidth = 2;
        self.layer.borderColor = [UIColor grayColor].CGColor;
    }
    return self;
}

- (UIColor *)randomColor
{
    float red = arc4random() % 255 /255.0;
    float green = arc4random() % 255 / 255.0;
    float blue = arc4random() % 255 / 255.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    return color;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
