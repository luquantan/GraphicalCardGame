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

-(NSInteger)amountForCard
{
    NSInteger amount;
    switch (self.symbolAmountOnCard) {
        case SetCardSymbolAmount1:
            amount = 1;
            break;
        case SetCardSymbolAmount2:
            amount = 2;
            break;
        case SetCardSymbolAmount3:
            amount = 3;
            break;
        default:
            break;
    }
    return amount;
}

- (NSInteger)matchCards:(NSArray *)cards
{
    NSMutableSet *symbolCountSet = [NSMutableSet set];
    NSMutableSet *symbolColorSet = [NSMutableSet set];
    NSMutableSet *symbolTextureSet = [NSMutableSet set];
    NSMutableSet *symbolShapeSet = [NSMutableSet set];
    for (SetCard *card in cards) {
        [symbolCountSet addObject:@(card.symbolAmountOnCard)];
        [symbolColorSet addObject:@(card.symbolColorOnCard)];
        [symbolTextureSet addObject:@(card.symbolTextureOnCard)];
        [symbolShapeSet addObject:@(card.symbolShapeOnCard)];
    }
    if (!(symbolCountSet.count == 1 || symbolCountSet.count == cards.count)) {
        return -5;
    }
    if (!(symbolColorSet.count == 1 || symbolColorSet.count == cards.count)) {
        return -5;
    }
    if (!(symbolTextureSet.count == 1 || symbolTextureSet.count == cards.count)) {
        return -5;
    }
    if (!(symbolShapeSet.count == 1 || symbolShapeSet.count == cards.count)) {
        return -5;
    }
    
    return 10;
}
@end
