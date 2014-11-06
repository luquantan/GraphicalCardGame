//
//  CardMatchingGame.m
//  GraphicalCardGame
//
//  Created by LuQuan Intrepid on 11/5/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()
@property (strong,nonatomic) NSMutableArray *currentDeck;
@property (strong,nonatomic) NSMutableArray *chosenPlayingCards;
@property (strong,nonatomic) NSMutableArray *chosenSetCards;
@property (nonatomic,readwrite) NSInteger score;
@end

@implementation CardMatchingGame
- (NSMutableArray *)currentDeck
{
    if (!_currentDeck) {
        _currentDeck = [[NSMutableArray alloc]init];
    }
    return _currentDeck;
}

//Disable the default init
- (instancetype)init
{
    return nil;
}

- (instancetype)initGameWithNumberOfCard:(NSUInteger)numberOfCards usingDeck:(Deck *)someDeck
{
    self = [super init];
    if (self) {
        for (NSUInteger i = 0; i < numberOfCards; i++) {
            Card *someCard = [someDeck drawRandomCard];
            if (someCard) {
                [self.currentDeck addObject:someCard];
            } else {
                self = nil;
                NSLog(@"initGameWithNumberOfCards is returning nil - CardMatchingGame.m");
                break;
            }
        }
    }
    return self;
}

- (void)matchPlayingCardAtIndex:(NSUInteger)index forNumberOfCards:(NSUInteger)numberOfCardsToMatch
{
    Card *somePlayingCard = [self cardAtIndex:index];
    if (somePlayingCard.isCardMatched == NO) {
        if (somePlayingCard.isCardChosen == YES) {
            somePlayingCard.isCardChosen = NO;
        } else {
            NSMutableArray *chosenCards = [NSMutableArray array];
            for (Card *otherPlayingCard in self.currentDeck) {
                if (otherPlayingCard.isCardChosen && !otherPlayingCard.isCardMatched) {
                    [chosenCards addObject:otherPlayingCard];
                }
            }
            somePlayingCard.isCardChosen = YES;
            // -1 for currently chosen card
            if (chosenCards.count == numberOfCardsToMatch - 1) {
                NSInteger scoreFromMatch = [somePlayingCard matchCards:chosenCards];
                if (scoreFromMatch > 0) {
                    for (Card *card in chosenCards) {
                        card.isCardMatched = YES;
                    }
                    somePlayingCard.isCardMatched = YES;
                } else if (scoreFromMatch < 0) {
                    for (Card *card in chosenCards) {
                        card.isCardChosen = NO;
                    }
                }
            }
        }
    }
}

- (void)matchSetCardAtIndex:(NSUInteger)index
{
    Card *someSetCard = [self cardAtIndex:index];
    if (someSetCard.isCardMatched == NO) {
        if (someSetCard.isCardChosen == YES) {
            someSetCard.isCardChosen = NO;
        } else {
            NSMutableArray *chosenCards = [NSMutableArray array];
            for (Card *otherSetCard in self.currentDeck) {
                if (otherSetCard.isCardChosen && !otherSetCard.isCardMatched) {
                    [chosenCards addObject:otherSetCard];
                }
            }
            someSetCard.isCardChosen = YES;
            if ([chosenCards count] == 2) {
                NSInteger scoreFromMatch = [someSetCard matchCards:chosenCards];
                if (scoreFromMatch > 0) {
                    for (Card *card in chosenCards) {
                        card.isCardMatched = YES;
                    }
                    someSetCard.isCardMatched = YES;
                } else if (scoreFromMatch < 0) {
                    for (Card *card in chosenCards) {
                        card.isCardChosen = NO;
                    }
                }
            }
        }
    }
}


- (Card *)cardAtIndex:(NSUInteger)index
{
    if (index < [self.currentDeck count]) {
        return self.currentDeck[index];
    } else {
        NSLog(@"The index of chosen card is out of range of the deck - CardMatchingGame.m");
        return nil;
    }
}
@end
