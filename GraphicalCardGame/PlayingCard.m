//
//  PlayingCard.m
//  GraphicalCardGame
//
//  Created by LuQuan Intrepid on 11/5/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard
//This method returns the score from the match. The arguments are the array of Cards to be match and the number of cards to match.
- (NSInteger)matchPlayingCards:(NSArray *)playingCards
{
    NSInteger scoreFromMatch = 0;
    
    //The brains will be in here.
    
    return scoreFromMatch;
}

//Pull the current value of rank and suit and return both of them as a string
- (NSString *)contentsOfCard
{
    NSString *rank;
    switch (self.rank) {
        case PlayingCardRanks2:
            rank = @"2";
            break;
        case PlayingCardRanks3:
            rank = @"3";
            break;
        case PlayingCardRanks4:
            rank = @"4";
            break;
        case PlayingCardRanks5:
            rank = @"5";
            break;
        case PlayingCardRanks6:
            rank = @"6";
            break;
        case PlayingCardRanks7:
            rank = @"7";
            break;
        case PlayingCardRanks8:
            rank = @"8";
            break;
        case PlayingCardRanks9:
            rank = @"9";
            break;
        case PlayingCardRanks10:
            rank = @"10";
            break;
        case PlayingCardRanksJ:
            rank = @"J";
            break;
        case PlayingCardRanksQ:
            rank = @"Q";
            break;
        case PlayingCardRanksK:
            rank = @"K";
            break;
        case PlayingCardRanksA:
            rank = @"A";
            break;
        default:
            break;
    }
    
    NSString *suit;
    switch (self.suit) {
        case PlayingCardSuitsDiamond:
            suit = @"♦︎";
            break;
        case PlayingCardSuitsClub:
            suit = @"♣︎";
            break;
        case PlayingCardSuitsHeart:
            suit = @"♥︎";
            break;
        case PlayingCardSuitsSpade:
            suit = @"♠︎";
            break;
        default:
            break;
    }
    return [NSString stringWithFormat:@"%@%@", rank, suit];
}
@end
