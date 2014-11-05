//
//  ViewController.m
//  GraphicalCardGame
//
//  Created by LuQuan Intrepid on 11/4/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    PlayingCard *somePlayingCard = [[PlayingCard alloc]init];
    
    NSLog(@"The value of rank is %li",somePlayingCard.rank);
    somePlayingCard.rank = 1;
    NSLog(@"The value of rank is %li",somePlayingCard.rank);
    
    somePlayingCard.rank = 55;
    NSLog(@"The value of rank is %ld",somePlayingCard.rank);
    
    somePlayingCard.rank = PlayingCardRanks10;
    NSLog(@"The value of rank is %li",somePlayingCard.rank);
    NSLog(@"Does playingcard rank = 8? %i",somePlayingCard.rank == PlayingCardRanks10);
    BOOL boolOp =1;
    NSLog(@"The value of the boolean is %i",boolOp);
    boolOp  = 0;
    NSLog(@"The value of the boolean is %i",boolOp);
    boolOp = 5;
    NSLog(@"The value of the boolean is %i",boolOp);
    
 
    
    SetCardDeck *someDeckOfSetCards = [[SetCardDeck alloc]init];
    NSInteger countOfSetCard = [someDeckOfSetCards numberOfCardsLeftInDeck];
    
    NSLog(@"The number of cards in the deck is %li",countOfSetCard);
    
    for (int i = 0; i < countOfSetCard; i++) {
        NSLog(@"The number of cards in SetCardDeck is %li",[someDeckOfSetCards numberOfCardsLeftInDeck]);
        Card *card = [someDeckOfSetCards drawRandomCard];
        SetCard *aSetCard = (SetCard *)card;
        NSString *contentString = [NSString stringWithFormat:@"%ld %ld %ld %ld",aSetCard.symbolAmountOnCard,aSetCard.symbolColorOnCard,aSetCard.symbolTextureOnCard,aSetCard.symbolTypeOnCard];
        NSLog(@"The content of this card is %@",contentString);
    }
    
    PlayingCardDeck *someDeckOfPlayingCards = [[PlayingCardDeck alloc]init];
    NSInteger countOfCard = [someDeckOfPlayingCards numberOfCardsLeftInDeck];
    
    NSLog(@"The number of cards in the deck is %li",countOfCard);
    
    for (int i = 0; i < countOfCard; i++) {
        Card *card = [someDeckOfPlayingCards drawRandomCard];
        NSString *contentString = card.contentsOfCard;
        NSLog(@"The content of this card is %@",contentString);
    }
}
@end
