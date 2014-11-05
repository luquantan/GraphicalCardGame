//
//  Deck.h
//  GraphicalCardGame
//
//  Created by LuQuan Intrepid on 11/4/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
- (Card *)drawRandomCard;
- (void)addCard:(Card *)anyCard; 
@end
