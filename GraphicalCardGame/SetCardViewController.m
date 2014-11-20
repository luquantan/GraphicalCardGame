 //
//  SetCardViewController.m
//  GraphicalCardGame
//
//  Created by LuQuan Intrepid on 11/6/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import "SetCardViewController.h"
#import "CardMatchingGame.h"
#import "SetCardDeck.h"
#import "SetCardView.h"
#import "Grid.h"

@interface SetCardViewController ()
//Views
@property (weak, nonatomic) IBOutlet UIView *mainViewForSetCard;
@property (strong, nonatomic) Grid *grid;

//Game
@property (strong, nonatomic) CardMatchingGame *currentGame;
@property (nonatomic) NSInteger score;

//View outlets/actions
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation SetCardViewController
#pragma mark - Initialization
- (CardMatchingGame *)currentGame
{
    if (!_currentGame) {
        _currentGame = [[CardMatchingGame alloc] initGameWithFullDeckUsingDeck:[self createDeck]];
    }
    return _currentGame;
}

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (Grid *)grid
{
    if (!_grid) {
        _grid = [[Grid alloc] init];
        _grid.size = self.mainViewForSetCard.bounds.size;
        _grid.cellAspectRatio = 3.0 / 2.0;
        _grid.minimumNumberOfCells = 12;
    }
    return _grid;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!_grid) [self populateGridWithSetCardsFromDeck];
}


- (void)populateGridWithSetCardsFromDeck
{
    NSInteger count = 0;
    for (NSUInteger i = 0; i < self.grid.rowCount; i++) {
        BOOL shouldBreak = NO;
        for (NSUInteger j = 0; j < self.grid.columnCount; j++) {
            SetCard *setCard = (SetCard *)[self.currentGame drawCardFromCurrentDeckWithIndex:count];
            SetCardView *setCardView = [[SetCardView alloc] initWithFrame:[self.grid frameOfCellAtRow:i inColumn:j] andSetCard:setCard];
            UITapGestureRecognizer *tapRecognizer = [UITapGestureRecognizer new];
            [tapRecognizer addTarget:self action:@selector(handleTap:)];
            tapRecognizer.numberOfTapsRequired = 1;
            [setCardView addGestureRecognizer:tapRecognizer];
            [self.mainViewForSetCard addSubview:setCardView];
            count++;
            if (count >= (self.grid.rowCount * self.grid.columnCount)) {
                shouldBreak = YES;
                break;
            }
        }
        if (shouldBreak) {
            break;
        }
    }
}

- (void)handleTap:(UITapGestureRecognizer *)tap
{
    UIView *tappedSubview = tap.view;
    if ([tappedSubview isKindOfClass:[SetCardView class]]) {
        SetCardView *tappedSetCardView = (SetCardView *)tappedSubview;
        NSUInteger chosenButtonIndex = [self.currentGame indexThatMatchesCard:(Card *)tappedSetCardView.setCard];
        self.currentGame.numberOfCards = 3;
        [self.currentGame matchCardAtIndex:chosenButtonIndex];
    }
    self.score += self.currentGame.score;
    [self.currentGame clearMatchedCards];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %li", self.score];
    [self.mainViewForSetCard.subviews makeObjectsPerformSelector:@selector(updateCard)];
}

#pragma mark - SetCard Game
- (IBAction)redealButtonPressed:(UIButton *)sender
{
    //Reset the Game and any previous cards/score
    self.currentGame = nil;
    self.score = 0;
    self.scoreLabel.text = @"Score: 0";
    [self.mainViewForSetCard.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self populateGridWithSetCardsFromDeck];
}

- (IBAction)addCardsButton:(UIButton *)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
