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
    PlayingCardRanks2,
    PlayingCardRanks3,
    PlayingCardRanks4,
    PlayingCardRanks5,
    PlayingCardRanks6,
    PlayingCardRanks7,
    PlayingCardRanks8,
    PlayingCardRanks9,
    PlayingCardRanks10,
    PlayingCardRanksJ,
    PlayingCardRanksQ,
    PlayingCardRanksK,
    PlayingCardRanksA,
    PlayingCardRanksCount
};

typedef NS_ENUM(NSInteger, PlayingCardSuits)
{
    PlayingCardSuitsDiamond,
    PlayingCardSuitsClub,
    PlayingCardSuitsHeart,
    PlayingCardSuitsSpade,
    PlayingCardSuitsCount
};

@interface PlayingCard : Card

@property (nonatomic) PlayingCardRanks rank;
@property (nonatomic) PlayingCardSuits suit;

@end
