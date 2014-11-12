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

    
    [self drawCircleWithColor:self.setCard.symbolColorOnCard withTexture:self.setCard.symbolTextureOnCard];
}

- (void)drawSetCard
{
    
}

- (void)drawSquiggleWithColor:(SetCardSymbolColor)symbolColor withTexture:(SetCardSymbolTexture)symbolTexture
{
    //Implement UIBezierPath as such to create this
}

- (void)drawDiamondWithColor:(SetCardSymbolColor)symbolColor withTexture:(SetCardSymbolTexture)symbolTexture
{
    //Implement UIBezierPath as such to create this
}

- (void)drawCircleWithColor:(SetCardSymbolColor)symbolColor withTexture:(SetCardSymbolTexture)symbolTexture
{
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    UIBezierPath *drawCricle = [UIBezierPath bezierPathWithArcCenter:center radius:25.0 startAngle:-M_PI endAngle:M_PI clockwise:YES];
    [[self symbolColorForEnum:symbolColor] setStroke];
    drawCricle.lineWidth = 3.5;
    [drawCricle stroke];
}

#pragma mark - Helper Methods to return stuff i need from the ENUMS
//This method will return the color of the card depending on the property of the card as represented by the enum
//Note: the (default: break)is needed because the last countVariable in the enum has to be accounted for.
- (UIColor *)symbolColorForEnum:(enum SetCardSymbolColor)symbolColor                   //Maybe I can move this to the view later
{
    UIColor *colorForCard;
    switch (symbolColor) {
        case SetCardSymbolColor1:
            colorForCard = [UIColor redColor];
            break;
        case SetCardSymbolColor2:
            colorForCard = [UIColor purpleColor];
            break;
        case SetCardSymbolColor3:
            colorForCard = [UIColor greenColor];
            break;
        default:
            break;
    }
    return colorForCard;
}

-(NSInteger)symbolAmountForEnum:(enum SetCardSymbolAmount)symbolAmount
{
    NSInteger amount;
    switch (symbolAmount) {
        case SetCardSymbolAmount1:
            amount = 1;
            break;
        case SetCardSymbolAmount2:
            amount = 2;
            break;
        case SetCardSymbolAmount3:
            amount = 3;
            break;
        default:
            break;
    }
    return amount;
}


@end
