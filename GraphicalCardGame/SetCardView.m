//
//  SetCardView.m
//  GraphicalCardGame
//
//  Created by LuQuan Intrepid on 11/12/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import "SetCardView.h"
#import "SetCard.h"
//@property (strong, nonatomic) SetCard *setCard;
//@property (nonatomic) BOOL selected;
//
//- (void)updateCard;
//- (instancetype)initWithFrame:(CGRect)frame andSetCard:(SetCard *)setCard;
@interface SetCardView ()
@property (nonatomic) CGFloat cornerRadius;
@end

@implementation SetCardView
#pragma mark - Initialization
- (instancetype)initWithFrame:(CGRect)frame andSetCard:(SetCard *)setCard
{
    self = [super initWithFrame:frame];
    if (self) {
        self.setCard = setCard;
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (void)setup
{
//    self.backgroundColor = nil;
//    self.opaque = NO;
    [self setCardCornerRadius];
}

- (void)setCardCornerRadius
{
    const CGFloat CORNER_RADIUS = 5.0;
    self.cornerRadius = CORNER_RADIUS * self.contentScaleFactor;
}
#pragma mark - UpdateUI
- (void)updateCard
{
    //Update card here
}

#pragma mark - Drawing

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.cornerRadius];
    
    //This clips our view and all the drawings to the roundedRect
    [roundedRect addClip];
    
    //Fill the view with white and and black border
    [[UIColor whiteColor] setFill];
    [roundedRect fill];
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
}


@end
