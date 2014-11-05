//
//  Card.h
//  GraphicalCardGame
//
//  Created by LuQuan Intrepid on 11/4/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
//maybe this is not needed since we are now using ENUMS. And the matching algorithm should stay within the inidividual Cards
@property (strong,nonatomic) NSString *contentsOfCard;

@property (nonatomic) BOOL isCardChosen;
@property (nonatomic) BOOL isCardMatched;

//The match algorithms should return a score.
- (NSInteger)matchPlayingCards:(NSArray *)playingCards forNumberOfCards:(NSInteger)numberOfCardsToMatch;
- (NSInteger)matchSetCards:(NSArray *)setCards;

@end
