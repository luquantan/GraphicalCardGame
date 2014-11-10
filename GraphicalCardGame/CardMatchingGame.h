//
//  CardMatchingGame.h
//  GraphicalCardGame
//
//  Created by LuQuan Intrepid on 11/5/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject
@property (nonatomic) NSUInteger numberOfCards;
@property (nonatomic, readonly) NSInteger score;

- (instancetype)initGameWithNumberOfCard:(NSUInteger)numberOfCards usingDeck:(Deck *)someDeck;
- (instancetype)initGameWithFullDeckUsingDeck:(Deck *)someDeck;

- (void)matchCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
//- (void)matchPlayingCardAtIndex:(NSUInteger)index forNumberOfCards:(NSUInteger)numberOfCardsToMatch;
//- (void)matchSetCardAtIndex:(NSUInteger)index;
@end