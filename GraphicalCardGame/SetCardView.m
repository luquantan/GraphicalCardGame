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

static const CGFloat LQSetCardViewCornerRadius = 5.0;

@interface SetCardView ()
//Properties for setting the coordinates and bounding values for the drawings
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGFloat boundingWidth;
@property (nonatomic) CGFloat boundingHeight;
@property (nonatomic) CGFloat heightY;
@property (nonatomic) CGFloat leftCenterX;
@property (nonatomic) CGFloat rightCenterX;
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
    [self setCardCornerRadius];
    [self settingCoordinatesForDrawingSetCardObjects];
}

- (void)setCardCornerRadius
{
    self.cornerRadius = LQSetCardViewCornerRadius * self.contentScaleFactor;
}

//Change self.center X and Y to be different depending on whether i would like to print the symbols
- (void)settingCoordinatesForDrawingSetCardObjects
{
    //Center X and Y of the view
    self.centerX = CGRectGetMidX(self.bounds);
    self.centerY = CGRectGetMidY(self.bounds);
    
    //Bounding width and height of each element on the card
    self.boundingWidth = self.bounds.size.width / 5;
    self.boundingHeight = self.bounds.size.height / 5 * 3;
    
    self.heightY = self.centerY - (self.boundingHeight / 2);
    
    //X-value of center for drawing element
    self.leftCenterX = self.centerX - self.boundingWidth - (self.boundingWidth / 4);
    self.rightCenterX = self.centerX + (self.boundingWidth * 2) + (self.boundingWidth / 4);
    

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
    
    
    [self drawSquiggleWithColor:self.setCard.symbolColorOnCard withTexture:self.setCard.symbolTextureOnCard withCenterXAt:self.centerX andCenterYAt:self.centerY];
}

- (void)drawSetCardOfType:(SetCardSymbolShape)symbolShape withAmount:(SetCardSymbolAmount)symbolAmount
{
    
}

//These methods will draw the card element in the right position depending on the number of element needed
- (void)drawSquiggleWithAmount:(SetCardSymbolAmount)symbolAmount
{
    
}

- (void)drawDiamondWithAmount:(SetCardSymbolAmount)symbolAmount
{

}

- (void)drawRoundedRectWithAmount:(SetCardSymbolAmount)symbolAmount
{
    
}
//These methods will draw a single element in relation to its own center, not the center of the cardview
- (void)drawSquiggleWithColor:(SetCardSymbolColor)symbolColor withTexture:(SetCardSymbolTexture)symbolTexture withCenterXAt:(CGFloat)centerX andCenterYAt:(CGFloat)centerY
{
    CGFloat cornerX = centerX - (self.boundingWidth / 2);
    UIBezierPath *drawSquiggles = [[UIBezierPath alloc] init];
    [drawSquiggles moveToPoint:CGPointMake(centerX, self.heightY)];
    [drawSquiggles addCurveToPoint:CGPointMake(centerX, self.heightY + self.boundingHeight) controlPoint1:CGPointMake((cornerX - (self.boundingWidth / 2)), (centerY - (self.boundingHeight / 5))) controlPoint2:CGPointMake(cornerX + self.boundingWidth, centerY + (self.boundingHeight / 5))];
    [drawSquiggles addCurveToPoint:CGPointMake(centerX, self.heightY) controlPoint1:CGPointMake(cornerX + self.boundingWidth + (self.boundingWidth /2), centerY + (self.boundingHeight / 5)) controlPoint2:CGPointMake(cornerX, (centerY - (self.boundingHeight / 5)))];
    [drawSquiggles addClip];
    [[self symbolColorForEnum:symbolColor] setStroke];
    drawSquiggles.lineWidth = 5.5;
    [drawSquiggles stroke];
    [self createSymbolWithTexture:symbolTexture andFillColor:[self symbolColorForEnum:symbolColor]];
}

- (void)drawDiamondWithColor:(SetCardSymbolColor)symbolColor withTexture:(SetCardSymbolTexture)symbolTexture withCenterXAt:(CGFloat)centerX andCenterYAt:(CGFloat)centerY
{
    CGFloat cornerX = centerX - (self.boundingWidth / 2);
    UIBezierPath *drawDiamond = [[UIBezierPath alloc] init];
    [drawDiamond moveToPoint:CGPointMake(centerX, (centerY + (self.boundingHeight / 2)))];
    [drawDiamond addLineToPoint:CGPointMake(cornerX + self.boundingWidth, centerY)];
    [drawDiamond addLineToPoint:CGPointMake(centerX, (centerY - (self.boundingHeight / 2)))];
    [drawDiamond addLineToPoint:CGPointMake(cornerX, centerY)];
    [drawDiamond closePath];
    [drawDiamond addClip];
    [[self symbolColorForEnum:symbolColor] setStroke];
    [[self symbolColorForEnum:symbolColor] setFill];
    drawDiamond.lineWidth = 5.5;
    [drawDiamond stroke];
    [self createSymbolWithTexture:symbolTexture andFillColor:[self symbolColorForEnum:symbolColor]];
}

- (void)drawRoundedRectWithColor:(SetCardSymbolColor)symbolColor withTexture:(SetCardSymbolTexture)symbolTexture withCenterXAt:(CGFloat)centerX
{
    CGFloat cornerX = centerX - (self.boundingWidth / 2);
    UIBezierPath *drawRoundRect = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(cornerX, self.heightY, self.boundingWidth, self.boundingHeight) cornerRadius:self.cornerRadius];
    [drawRoundRect addClip];
    [[self symbolColorForEnum:symbolColor] setStroke];
    [[self symbolColorForEnum:symbolColor] setFill];
    drawRoundRect.lineWidth = 5.5;
    [drawRoundRect stroke];
    
    [self createSymbolWithTexture:symbolTexture andFillColor:[self symbolColorForEnum:symbolColor]];
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

- (void)createSymbolWithTexture:(SetCardSymbolTexture)symbolTexture andFillColor:(UIColor *)fillColor
{
    switch (symbolTexture) {
        case SetCardSymbolTexture1:
            //No Fill
            break;
        case SetCardSymbolTexture2:
        {
            UIBezierPath *strippedTexture = [[UIBezierPath alloc] init];
            for (float i = self.heightY; i <= (self.heightY + self.boundingHeight); i+= 5.0) {
                [strippedTexture moveToPoint:CGPointMake(0, i)];
                [strippedTexture addLineToPoint:CGPointMake(self.bounds.size.width, i)];
                strippedTexture.lineWidth = 1.0;
                [strippedTexture stroke];
            }
        }
            break;
        case SetCardSymbolTexture3:
        {
            UIBezierPath *fillRect = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
            
            CGFloat r,g,b, a;
            [fillColor getRed:&r green:&g blue:&b alpha:&a];
            [[UIColor colorWithRed:r green:g blue:b alpha:a / 1.5] setFill];
            [fillRect fill];
        }
            break;
        default:
            break;
    }
}

#pragma mark - Unused Drawing Code

- (void)drawCircle
{
    //    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    //    UIBezierPath *drawCricle = [UIBezierPath bezierPathWithArcCenter:center radius:25.0 startAngle:-M_PI endAngle:M_PI clockwise:YES];
    //    [drawCricle addClip];}
    //    drawCricle.lineWidth = 7.5;
    //    [drawCricle stroke];
}
@end
