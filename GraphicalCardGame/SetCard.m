//
//  SetCard.m
//  GraphicalCardGame
//
//  Created by LuQuan Intrepid on 11/5/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard


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
