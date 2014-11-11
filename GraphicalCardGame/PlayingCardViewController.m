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
#import "ColorBoxView.h"

@interface PlayingCardViewController ()
@property (weak, nonatomic) IBOutlet UIView *mainViewForPlayingCards;
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;
@property (strong, nonatomic) CardMatchingGame *currentGame;
@property (strong, nonatomic) Grid *grid;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;



@end

@implementation PlayingCardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (CardMatchingGame *)currentGame
{
    if (!_currentGame) {
        _currentGame = [[CardMatchingGame alloc] initGameWithNumberOfCard:self.grid.minimumNumberOfCells usingDeck:[self createDeck]];
    }
    return _currentGame;
}

//The self.grid.minimumNumberOfCells in hardcoded;
- (Grid *)grid
{
    if (!_grid) {
        _grid = [[Grid alloc]init];
        _grid.size = self.mainViewForPlayingCards.bounds.size;
        _grid.cellAspectRatio = 2.0 / 3.0;
        _grid.minimumNumberOfCells = 24;
    }
    return _grid;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self populateGridWithPlayingCardsFromDeck];
}


#pragma mark - PlayingCard Game
- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (void)populateGridWithPlayingCardsFromDeck
{
    NSInteger count = 0;
    for (NSUInteger i = 0; i < self.grid.rowCount; i++) {
        for (NSUInteger j = 0; j < self.grid.columnCount; j++) {
            PlayingCard *playingCard = (PlayingCard *)[self.currentGame drawCardFromCurrentDeckWithIndex:count];
            PlayingCardView *playingCardView = [[PlayingCardView alloc] initWithFrame:[self.grid frameOfCellAtRow:i inColumn:j] andPlayingCard:playingCard];
            UITapGestureRecognizer *tapRecognizer = [UITapGestureRecognizer new];
            [tapRecognizer addTarget:playingCardView action:@selector(tap:)];
            [tapRecognizer addTarget:self action:@selector(whenViewTapIsRecognized:)];
            tapRecognizer.numberOfTapsRequired = 1;
            [playingCardView addGestureRecognizer:tapRecognizer];
            [self.mainViewForPlayingCards addSubview:playingCardView];
            count++;
        }
    }
}

//Remember: need a way to match the index of the view and the index of the card(in currentDeck) being shown.
- (void)whenViewTapIsRecognized:(UITapGestureRecognizer *)tapSender
{
    CGPoint pointAtSubview = [tapSender locationInView:self.mainViewForPlayingCards];
    UIView *tappedSubview = [self.mainViewForPlayingCards hitTest:pointAtSubview withEvent:nil];
    if ([tappedSubview isKindOfClass:[PlayingCardView class]]) {
        PlayingCardView *tappedPlayingCardSubview = (PlayingCardView *)tappedSubview;
        NSUInteger chosenButtonIndex = [self.currentGame indexThatMatchesCard:tappedPlayingCardSubview.playingCard];
        
        NSLog(@"%lu", chosenButtonIndex);
        
        if (self.segmentedControl.selectedSegmentIndex == 0) {
            self.currentGame.numberOfCards = 2;
            [self.currentGame matchCardAtIndex:chosenButtonIndex];
        } else if (self.segmentedControl.selectedSegmentIndex == 1) {
            self.currentGame.numberOfCards = 3;
            [self.currentGame matchCardAtIndex:chosenButtonIndex];
        }
    }
}

- (IBAction)redealButtonPressed:(UIButton *)sender
{
    self.currentGame = nil;
    [self.mainViewForPlayingCards.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self populateGridWithPlayingCardsFromDeck];
}




#pragma mark - Gestures

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Extra Stuff

- (void)fillGridWithColor:(CGRect)frame
{
    ColorBoxView *colorbox = [[ColorBoxView alloc] initWithFrame:frame];
    [self.mainViewForPlayingCards addSubview:colorbox];
    NSLog(@"%@", self.grid.description);
    NSLog(@"Number of rows is %lu", self.grid.rowCount);
    NSLog(@"Number of columns is %lu", self.grid.columnCount);
}
//    [self fillGridWithColor:[self.grid frameOfCellAtRow:0 inColumn:0]];
//    [self fillGridWithColor:[self.grid frameOfCellAtRow:0 inColumn:1]];
//    [self fillGridWithColor:[self.grid frameOfCellAtRow:0 inColumn:2]];
//    [self fillGridWithColor:[self.grid frameOfCellAtRow:1 inColumn:0]];
//    [self fillGridWithColor:[self.grid frameOfCellAtRow:1 inColumn:1]];
//    [self fillGridWithColor:[self.grid frameOfCellAtRow:1 inColumn:2]];
//    [self fillGridWithColor:[self.grid frameOfCellAtRow:2 inColumn:0]];
//    NSLog(@"cell size is %f %f", self.grid.cellSize.width,self.grid.cellSize.height);


#pragma mark - Testing to show card on view
//
//- (void)drawRandomPlayingCard
//{
//    Card *card = [self.currentDeck drawRandomCard];
//    if ([card isKindOfClass:[PlayingCard class]]) {
//        PlayingCard *playingCard = (PlayingCard *)card;
//        self.playingCardView.contents = playingCard.contentsOfCard;
//
//
//        PlayingCardView *another = [[PlayingCardView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) andPlayingCard:playingCard];
//    }
//
//
//}


//- (NSUInteger)numberOfSubviews
//{
//    return self.grid.minimumNumberOfCells;
//}

#pragma mark - Subview Creation
//- (UIView *)createSubview
//{
//    UIView *aView = [[PlayingCardView alloc] init];
//    aView.frame = CGRectMake(0, 0, self.grid.cellSize.width, self.grid.cellSize.height);
//    return aView;
//}

//Added with Xcode
//- (IBAction)swipeCard:(UISwipeGestureRecognizer *)sender
//{
//    if (!self.playingCardView.faceUp) {
//        [self drawRandomPlayingCard];
//    }
//    self.playingCardView.faceUp = !self.playingCardView.faceUp;
//}


@end
