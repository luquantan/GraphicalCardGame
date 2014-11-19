//
//  Deck.m
//  GraphicalCardGame
//
//  Created by LuQuan Intrepid on 11/4/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import "Deck.h"
@interface Deck ()
@property (strong,nonatomic) NSMutableArray *aDeckOfCards;
@end

@implementation Deck
//LazyLoad of aDeckOfCards
- (NSMutableArray *)aDeckOfCards
{
    if (!_aDeckOfCards) {
        _aDeckOfCards = [[NSMutableArray alloc]init];
    }
    return _aDeckOfCards;
}

- (Card *)drawRandomCard
{
    Card *randomCard = nil;
    if ([self.aDeckOfCards count]) {
        NSInteger randomIndex = arc4random_uniform((int)[self.aDeckOfCards count]);
        randomCard = self.aDeckOfCards[randomIndex];
        [self.aDeckOfCards removeObjectAtIndex:randomIndex];
    }
    return randomCard;
}

- (void)addCard:(Card *)anyCard
{
    [self.aDeckOfCards addObject:anyCard];
}

- (NSInteger)numberOfCardsLeftInDeck
{
    return [self.aDeckOfCards count];
}

@end
