//
//  SetCard.m
//  GraphicalCardGame
//
//  Created by LuQuan Intrepid on 11/4/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (UIColor *)colorForCard
{
    UIColor *colorForCard;
    switch (self.symbolColorOnCard) {
        case SetCardSymbolColor1:
            colorForCard = [UIColor redColor];
            break;
        case SetCardSymbolColor2:
            colorForCard = [UIColor blueColor];
            break;
        case SetCardSymbolColor3:
            colorForCard = [UIColor greenColor];
            break;
        default:
            break;
    }
    return colorForCard;
}
@end
