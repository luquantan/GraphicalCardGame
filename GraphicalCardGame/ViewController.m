//
//  ViewController.m
//  GraphicalCardGame
//
//  Created by LuQuan Intrepid on 11/4/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import "ViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "Card.h"

@interface ViewController ()
@property (nonatomic) NSInteger score;
@end

@implementation ViewController

- (CardMatchingGame *)currentGame
{
    if (!_currentGame) {
        _currentGame = [[CardMatchingGame alloc] initGameWithFullDeckUsingDeck:[self createDeck]];
    }
    return _currentGame;
}

//Overwritten in subclass
- (Deck *)createDeck
{
    return nil;
}

- (NSUInteger)numberOfSubviews
{
    return 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

//Everything in here is only for testing purposes.
- (void)viewDidAppear:(BOOL)animated
{
//    PlayingCard *somePlayingCard = [[PlayingCard alloc]init];
//    
//    NSLog(@"The value of rank is %li",somePlayingCard.rank);
//    somePlayingCard.rank = 1;
//    NSLog(@"The value of rank is %li",somePlayingCard.rank);
//    
//    somePlayingCard.rank = 55;
//    NSLog(@"The value of rank is %ld",somePlayingCard.rank);
//    
//    somePlayingCard.rank = PlayingCardRanks10;
//    NSLog(@"The value of rank is %li",somePlayingCard.rank);
//    NSLog(@"Does playingcard rank = 8? %i",somePlayingCard.rank == PlayingCardRanks10);
//    BOOL boolOp =1;
//    NSLog(@"The value of the boolean is %i",boolOp);
//    boolOp  = 0;
//    NSLog(@"The value of the boolean is %i",boolOp);
//    boolOp = 5;
//    NSLog(@"The value of the boolean is %i",boolOp);
//    
// 
//    
//    SetCardDeck *someDeckOfSetCards = [[SetCardDeck alloc]init];
//    NSInteger countOfSetCard = [someDeckOfSetCards numberOfCardsLeftInDeck];
//    
//    Card *oneCard = [someDeckOfSetCards drawRandomCard];
//    Card *twoCard = [someDeckOfSetCards drawRandomCard];
//    Card *threeCard = [someDeckOfSetCards drawRandomCard];
//    
//    SetCard *oneSetCard = (SetCard *)oneCard;
//    SetCard *twoSetCard = (SetCard *)twoCard;
//    SetCard *threeSetCard = (SetCard *)threeCard;
//    
//    NSMutableSet *mSet = [[NSMutableSet alloc]initWithArray:@[@(oneSetCard.symbolShapeOnCard),@(twoSetCard.symbolColorOnCard),@"ssdsd",@(threeSetCard.symbolTextureOnCard)]];
//    NSLog(@"Set : %@",mSet);
//    
//    NSArray *arrayToMatch = @[oneCard, twoCard, threeCard];
//    
//    NSInteger score = [oneCard matchCards:arrayToMatch]; //I need an instance of Card to use matchCards, eventhought Im not using the instance in the method. BAD DESIGN =(
//    
//    NSLog(@"The score is %li",score);
//    
//    NSLog(@"The number of cards in the deck is %li",countOfSetCard);
//    
//    for (int i = 0; i < countOfSetCard; i++) {
//        NSLog(@"The number of cards in SetCardDeck is %li",[someDeckOfSetCards numberOfCardsLeftInDeck]);
//        Card *card = [someDeckOfSetCards drawRandomCard];
//        SetCard *aSetCard = (SetCard *)card;
//        NSString *contentString = [NSString stringWithFormat:@"%ld %ld %ld %ld",aSetCard.symbolAmountOnCard,aSetCard.symbolColorOnCard,aSetCard.symbolTextureOnCard,aSetCard.symbolShapeOnCard];
//        NSLog(@"The content of this card is %@",contentString);
//    }
    
//    PlayingCardDeck *someDeckOfPlayingCards = [[PlayingCardDeck alloc]init];
//    NSInteger countOfCard = [someDeckOfPlayingCards numberOfCardsLeftInDeck];
//    
//    NSLog(@"The number of cards in the deck is %li",countOfCard);
//    
//    for (int i = 0; i < countOfCard; i++) {
//        Card *card = [someDeckOfPlayingCards drawRandomCard];
//        NSString *contentString = card.contentsOfCard;
//        NSLog(@"The content of this card is %@",contentString);
//    }
}
@end
