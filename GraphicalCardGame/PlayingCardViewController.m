//
//  PlayingCardViewController.m
//  GraphicalCardGame
//
//  Created by LuQuan Intrepid on 11/6/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import "PlayingCardViewController.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "PlayingCardView.h"


@interface PlayingCardViewController ()
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;
@property (strong,nonatomic) Deck *deck;
@end

@implementation PlayingCardViewController
//This deck initializes a PlayingCardDeck specifically
- (Deck *)deck
{
    if (!_deck) {
        _deck = [[PlayingCardDeck alloc]init];
    }
    return _deck;
}

- (void)drawRandomPlayingCard
{
    Card *card = [self.deck drawRandomCard];
    if ([card isKindOfClass:[PlayingCard class]]) {
        PlayingCard *playingCard = (PlayingCard *)card;
        self.playingCardView.contents = playingCard.contentsOfCard;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //This is for testing
    [self addPinchGesture];

}

//Added programmatically
- (void)addPinchGesture
{
    UIPinchGestureRecognizer *pinch = [UIPinchGestureRecognizer new];
    [pinch addTarget:self.playingCardView action:@selector(pinch:)];
    [self.playingCardView addGestureRecognizer:pinch];
}

//Added with Xcode
- (IBAction)swipeCard:(UISwipeGestureRecognizer *)sender
{
    if (!self.playingCardView.faceUp) {
        [self drawRandomPlayingCard];
    }
    self.playingCardView.faceUp = !self.playingCardView.faceUp;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
