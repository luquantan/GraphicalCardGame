//
//  PlayingCardDeck.m
//  GraphicalCardGame
//
//  Created by LuQuan Intrepid on 11/5/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

//This should create a full deck of PlayingCards
//The rank and suit are represented by integers that are (mapped) to an enum thing. 
- (instancetype)init
{
    self = [super init];
    if (self) {
        PlayingCard *somePlayingCard = [[PlayingCard alloc]init];
        for (NSInteger i = 0; i <= PlayingCardRanksCount; i++) {
            for (NSInteger j = 0; j <= PlayingCardSuitsCount; j++) {
                somePlayingCard.rank = i;
                somePlayingCard.suit = j;
                [self addCard:somePlayingCard];
            }
        }
    }
    return self;
}
@end
