//
//  Card.m
//  GraphicalCardGame
//
//  Created by LuQuan Intrepid on 11/4/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import "Card.h"

@implementation Card
//These methods are abstract. Their implememtations are located within PlayingCard and SetCard
- (NSInteger)matchPlayingCards:(NSArray *)playingCards forNumberOfCards:(NSInteger)numberOfCardsToMatch
{
    return 0;
}
- (NSInteger)matchSetCards:(NSArray *)setCards
{
    return 0;
}

@end
