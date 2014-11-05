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

- (NSInteger)matchSetCards:(NSArray *)setCards
{
    NSInteger scoreFromMatch = 0;
    
    //The brains in here
    
    return scoreFromMatch;
}
@end
