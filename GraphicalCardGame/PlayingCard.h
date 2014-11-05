//
//  PlayingCard.h
//  GraphicalCardGame
//
//  Created by LuQuan Intrepid on 11/5/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import "Card.h"

typedef NS_ENUM(NSInteger, PlayingCardRanks)
{
    PLayingCard2,
    PlayingCard3,
    PlayingCard4,
    PlayingCard5,
    PlayingCard6,
    PlayingCard7,
    PlayingCard8,
    PlayingCard9,
    PlayingCard10,
    PlayingCardJ,
    PlayingCardQ,
    PlayingCardK,
    PlayingCardA,
    PlayingCardRanksCount
};

typedef NS_ENUM(NSInteger, PlayingCardSuits)
{
    PlayingCardDiamond,
    PlayingCardClub,
    PlayingCardHeart,
    PlayingCardSpade
};

@interface PlayingCard : Card

@property (nonatomic) PlayingCardRanks rank;
@property (nonatomic) PlayingCardSuits suit;

@end
