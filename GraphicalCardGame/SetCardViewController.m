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
#import "SetCard.h"

@interface SetCardViewController ()
//Views
@property (weak, nonatomic) IBOutlet UIView *mainViewForSetCard;
@property (strong, nonatomic) Grid *grid;
@property (nonatomic) NSInteger numberOfSetCardViews;

//Game
@property (strong, nonatomic) CardMatchingGame *currentGame;
@property (nonatomic) NSInteger score;

//View outlets/actions
@property (weak, nonatomic) IBOutlet UIButton *addCardsButton;
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
        _grid = [[Grid alloc] initWithMinimumNumberOfCells:self.numberOfSetCardViews];
        _grid.size = self.mainViewForSetCard.bounds.size;
        _grid.cellAspectRatio = 3.0 / 2.0;
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
    self.numberOfSetCardViews = 12;

    if (!_grid) [self populateGridWithSetCardsFromDeck];
}


- (void)populateGridWithSetCardsFromDeck
{
    [self.mainViewForSetCard.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSInteger count = 0;
    for (NSUInteger i = 0; i < self.grid.rowCount; i++) {
        BOOL shouldBreak = NO;
        for (NSUInteger j = 0; j < self.grid.columnCount; j++) {
            SetCard *setCard = (SetCard *)[self.currentGame drawCardFromCurrentDeckWithIndex:count];
            if (setCard == nil) {
                shouldBreak = YES;
                break;
            }
            SetCardView *setCardView = [[SetCardView alloc] initWithFrame:[self.grid frameOfCellAtRow:i inColumn:j] andSetCard:setCard];
            UITapGestureRecognizer *tapRecognizer = [UITapGestureRecognizer new];
            [tapRecognizer addTarget:self action:@selector(handleTap:)];
            tapRecognizer.numberOfTapsRequired = 1;
            [setCardView addGestureRecognizer:tapRecognizer];
            [self.mainViewForSetCard addSubview:setCardView];
            count++;
            if (count >= self.numberOfSetCardViews) {
                shouldBreak = YES;
                break;
            }
        }
        if (shouldBreak) {
            break;
        }
    }
}

//- (void)populateGridWithSetCardsFromDeck
//{
//    NSInteger count = 0;
//    while (!(count >= self.numberOfSetCardViews)) {
//        for (NSUInteger i = 0; i < self.grid.rowCount; i++) {
//            for (NSUInteger j = 0; j < self.grid.columnCount; j++) {
//                SetCard *setCard = (SetCard *)[self.currentGame drawCardFromCurrentDeckWithIndex:count];
//                if (setCard == nil) {
//                    break;
//                }
//                SetCardView *setCardView = [[SetCardView alloc] initWithFrame:[self.grid frameOfCellAtRow:i inColumn:j] andSetCard:setCard];
//                UITapGestureRecognizer *tapRecognizer = [UITapGestureRecognizer new];
//                [tapRecognizer addTarget:self action:@selector(handleTap:)];
//                tapRecognizer.numberOfTapsRequired = 1;
//                [setCardView addGestureRecognizer:tapRecognizer];
//                [self.mainViewForSetCard addSubview:setCardView];
//                count++;
//            }
//
//        }
//
//    }
//}

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

    
    NSMutableArray *matched = [NSMutableArray array];
    for (SetCardView *setCardView in self.mainViewForSetCard.subviews) {
        if (setCardView.setCard.isCardMatched) {
            [matched addObject:setCardView];
        }
    }
    
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        for (UIView *v in matched) {
            v.alpha = 0.0;
        }
    } completion:^(BOOL finished){
        if (finished) {
            [matched makeObjectsPerformSelector:@selector(removeFromSuperview)];
            NSLog(@"Remove From SuperView");
            if (self.currentGame.score > 0) {
                [self updateSetCardViewsWhenMatchIsFound]; // Fills the Deck back to 12 cards
            }
        }
    }];

}

#pragma mark - SetCard Game
- (IBAction)redealButtonPressed:(UIButton *)sender
{
    //Reset the Game and any previous cards/score
    self.currentGame = nil;
    self.grid = nil;
    self.score = 0;
    self.scoreLabel.text = @"Score: 0";
    self.addCardsButton.enabled = YES;
    [self.mainViewForSetCard.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.numberOfSetCardViews = 12;
    [self populateGridWithSetCardsFromDeck];
}

- (IBAction)addCardsButton:(UIButton *)sender
{
    if (self.numberOfSetCardViews >= 78) {
        self.addCardsButton.enabled = NO;
    }
        self.grid = nil;
    self.numberOfSetCardViews += 3;
    [self populateGridWithSetCardsFromDeck];
    
}

- (void)updateSetCardViewsWhenMatchIsFound
{
    NSLog(@"Update current state: repopulate GRiD");
    [self populateGridWithSetCardsFromDeck];

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
