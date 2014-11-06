//
//  SetCard.m
//  GraphicalCardGame
//
//  Created by LuQuan Intrepid on 11/5/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard
//This method will return the color of the card depending on the property of the card as represented by the enum
//Note: the (default: break)is needed because the last countVariable in the enum has to be accounted for.
- (UIColor *)colorForCard                   //Maybe I can move this to the view later
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

- (NSInteger)matchCards:(NSArray *)cards
{
    NSInteger scoreFromMatch = 0;

    SetCard *zero = cards[0]; //Force cast it like this, because if I am calling this method, i can be confident that it is a SetCard

    NSLog(@"%li",[cards[1] symbolAmountOnCard]);
    
    return scoreFromMatch;
}

//They all have the same number, or they have three different numbers.
//They all have the same symbol, or they have three different symbols.
//They all have the same shading, or they have three different shadings.
//They all have the same color, or they have three different colors.
@end
