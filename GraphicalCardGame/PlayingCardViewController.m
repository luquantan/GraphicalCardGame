//
//  PlayingCardViewController.m
//  GraphicalCardGame
//
//  Created by LuQuan Intrepid on 11/6/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import "PlayingCardViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "PlayingCardView.h"
#import "Grid.h"


@interface PlayingCardViewController ()
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;
@property (strong, nonatomic) Grid *grid;
@property   (strong, nonatomic) Deck *currentDeck; // remove warning. This functionalities are in the CardMatchingGame
@property (strong,nonatomic) CardMatchingGame *currentGame;
@end

@implementation PlayingCardViewController
#pragma mark - PlayingCard Game
- (CardMatchingGame *)currentGame
{
    if (!_currentGame) {
        _currentGame = [[CardMatchingGame alloc] initGameWithFullDeckUsingDeck:[self createDeck]];
    }
    return _currentGame;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (NSUInteger)numberOfSubviews
{
    return self.grid.minimumNumberOfCells;
}

- (Deck *)currentDeck
{
    if (!_currentDeck) {
        _currentDeck = [[PlayingCardDeck alloc]init];
    }
    return _currentDeck;
}

- (void)drawRandomPlayingCard
{
    Card *card = [self.currentDeck drawRandomCard];
    if ([card isKindOfClass:[PlayingCard class]]) {
        PlayingCard *playingCard = (PlayingCard *)card;
        self.playingCardView.contents = playingCard.contentsOfCard;
        
    }
}

#pragma mark - Grid properties
- (Grid *)grid
{
    if (!_grid) {
        _grid = [[Grid alloc]init];
    }
    return _grid;
}

#pragma mark - Subview Creation
- (UIView *)createSubview
{
    UIView *aView = [[PlayingCardView alloc] init];
    aView.frame = CGRectMake(0, 0, self.grid.cellSize.width, self.grid.cellSize.height);
    return aView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //This is for testing
    [self addPinchGesture];

}


#pragma mark - Gestures
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
