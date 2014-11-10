//
//  ViewController.h
//  GraphicalCardGame
//
//  Created by LuQuan Intrepid on 11/4/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"
#import "Deck.h"

@interface ViewController : UIViewController
@property (strong, nonatomic) CardMatchingGame *currentGame;

- (Deck *)createDeck;
- (NSUInteger)numberOfSubviews;

@end

