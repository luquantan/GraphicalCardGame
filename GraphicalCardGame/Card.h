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
@property (copy, nonatomic) NSString *contentsOfCard; //Only for PlayingCard.

@property (nonatomic) BOOL isCardChosen;
@property (nonatomic) BOOL isCardMatched;

- (NSInteger)matchCards:(NSArray *)cards;

@end
