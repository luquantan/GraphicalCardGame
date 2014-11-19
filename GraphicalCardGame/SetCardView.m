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
@property (nonatomic) CGFloat boundingWidth;
@property (nonatomic) CGFloat boundingHeight;
@property (nonatomic) CGFloat heightY;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGFloat centerCornerX;

@property (nonatomic) CGFloat leftCenterX;
@property (nonatomic) CGFloat leftCornerX;

@property (nonatomic) CGFloat rightCenterX;
@property (nonatomic) CGFloat rightCornerX;
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
    self.opaque = NO;
    self.backgroundColor = nil;
    [self setCardCornerRadius];
    [self settingCoordinatesForDrawingSetCardObjects];
    [self xyCenterBasedOnSymbolAmount:self.setCard.symbolAmountOnCard];
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
    self.centerCornerX = self.centerX - (self.boundingWidth / 2);
}

//Finding the top left corner and center in X of the side elements based on symbolAmount
- (void)xyCenterBasedOnSymbolAmount:(SetCardSymbolAmount)symbolAmount
{
    if (symbolAmount == SetCardSymbolAmount2)
    {
        self.leftCenterX = self.centerX - self.boundingWidth / 1.5;
        self.leftCornerX = self.leftCenterX - (self.boundingWidth / 2);
        self.rightCenterX = self.centerX + self.boundingWidth / 1.5;
        self.rightCornerX = self.rightCenterX - (self.boundingWidth / 2);
    }
    
    if (symbolAmount == SetCardSymbolAmount3)
    {
        self.leftCenterX = self.centerX - (self.boundingWidth) - (self.boundingWidth / 4);
        self.leftCornerX = self.leftCenterX - (self.boundingWidth / 2);
        self.rightCenterX = self.centerX + (self.boundingWidth) + (self.boundingWidth / 4);
        self.rightCornerX = self.rightCenterX - (self.boundingWidth / 2);
    }
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    [self setNeedsDisplay];
}
#pragma mark - UpdateUI
- (void)updateCard
{
    self.selected = self.setCard.isCardChosen;
    if (self.setCard.isCardMatched) {
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.alpha = 0.0;
        } completion:^(BOOL finished){
            if (finished) {
                [self removeFromSuperview];
                
            }
        }];
    }
}

#pragma mark - Drawing SetCard
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.cornerRadius];
    
    //This clips our view and all the drawings to the roundedRect
    [roundedRect addClip];
    
    //Fill the view with white and and black border
    if (self.selected) {
        [[UIColor lightGrayColor] setFill];
        [roundedRect fill];
        [[UIColor blackColor] setStroke];
        [roundedRect stroke];
    } else if (!self.selected) {
        [[UIColor whiteColor] setFill];
        [roundedRect fill];
        [[UIColor blackColor] setStroke];
        [roundedRect stroke];
    }
    [self drawSetCardOfType:self.setCard.symbolShapeOnCard withAmount:self.setCard.symbolAmountOnCard];
}

#pragma mark - Drawing individual elements with symbol amount
//These methods will draw the card element in the right position depending on the number of element needed
- (void)drawSetCardOfType:(SetCardSymbolShape)symbolShape withAmount:(SetCardSymbolAmount)symbolAmount
{
    if (symbolShape == SetCardSymbolShape1) {
        [self drawSquiggleWithColor:self.setCard.symbolColorOnCard withTexture:self.setCard.symbolTextureOnCard];
    }
    if (symbolShape == SetCardSymbolShape2) {
        [self drawDiamondWithColor:self.setCard.symbolColorOnCard withTexture:self.setCard.symbolTextureOnCard];
    }
    if (symbolShape == SetCardSymbolShape3) {
        [self drawRoundedRectWithColor:self.setCard.symbolColorOnCard withSymbolTexture:self.setCard.symbolTextureOnCard];
    }
}

- (void)drawSquiggleWithColor:(SetCardSymbolColor)symbolColor withTexture:(SetCardSymbolTexture)symbolTexture
{
    UIBezierPath *drawSquiggles = [[UIBezierPath alloc] init];
    [self drawPathForSquiggle:drawSquiggles withSymbolAmount:self.setCard.symbolAmountOnCard];
    [[self symbolColorForEnum:symbolColor] setStroke];
    drawSquiggles.lineWidth = 5.5;
    [drawSquiggles stroke];
    [drawSquiggles addClip];
    [self createSymbolWithTexture:symbolTexture andFillColor:[self symbolColorForEnum:symbolColor]];
}

- (void)drawPathForSquiggle:(UIBezierPath *)path withSymbolAmount:(SetCardSymbolAmount)symbolAmount
{
    if (symbolAmount == SetCardSymbolAmount1) {
        
        [path moveToPoint:CGPointMake(self.centerX, self.heightY)];
        [path addCurveToPoint:CGPointMake(self.centerX, self.heightY + self.boundingHeight) controlPoint1:CGPointMake((self.centerCornerX - (self.boundingWidth / 2)), (self.centerY - (self.boundingHeight / 5))) controlPoint2:CGPointMake(self.centerCornerX + self.boundingWidth, self.centerY + (self.boundingHeight / 5))];
        [path addCurveToPoint:CGPointMake(self.centerX, self.heightY) controlPoint1:CGPointMake(self.centerCornerX + self.boundingWidth + (self.boundingWidth /2), self.centerY + (self.boundingHeight / 5)) controlPoint2:CGPointMake(self.centerCornerX, (self.centerY - (self.boundingHeight / 5)))];
        
    }
    if (symbolAmount == SetCardSymbolAmount2) {
        [path moveToPoint:CGPointMake(self.leftCenterX, self.heightY)];
        [path addCurveToPoint:CGPointMake(self.leftCenterX, self.heightY + self.boundingHeight) controlPoint1:CGPointMake((self.leftCornerX - (self.boundingWidth / 2)), (self.centerY - (self.boundingHeight / 5))) controlPoint2:CGPointMake(self.leftCornerX + self.boundingWidth, self.centerY + (self.boundingHeight / 5))];
        [path addCurveToPoint:CGPointMake(self.leftCenterX, self.heightY) controlPoint1:CGPointMake(self.leftCornerX + self.boundingWidth + (self.boundingWidth /2), self.centerY + (self.boundingHeight / 5)) controlPoint2:CGPointMake(self.leftCornerX, (self.centerY - (self.boundingHeight / 5)))];

        [path moveToPoint:CGPointMake(self.rightCenterX, self.heightY)];
        [path addCurveToPoint:CGPointMake(self.rightCenterX, self.heightY + self.boundingHeight) controlPoint1:CGPointMake((self.rightCornerX - (self.boundingWidth / 2)), (self.centerY - (self.boundingHeight / 5))) controlPoint2:CGPointMake(self.rightCornerX + self.boundingWidth, self.centerY + (self.boundingHeight / 5))];
        [path addCurveToPoint:CGPointMake(self.rightCenterX, self.heightY) controlPoint1:CGPointMake(self.rightCornerX + self.boundingWidth + (self.boundingWidth /2), self.centerY + (self.boundingHeight / 5)) controlPoint2:CGPointMake(self.rightCornerX, (self.centerY - (self.boundingHeight / 5)))];
    }
    if (symbolAmount == SetCardSymbolAmount3) {

        [path moveToPoint:CGPointMake(self.leftCenterX, self.heightY)];
        [path addCurveToPoint:CGPointMake(self.leftCenterX, self.heightY + self.boundingHeight) controlPoint1:CGPointMake((self.leftCornerX - (self.boundingWidth / 2)), (self.centerY - (self.boundingHeight / 5))) controlPoint2:CGPointMake(self.leftCornerX + self.boundingWidth, self.centerY + (self.boundingHeight / 5))];
        [path addCurveToPoint:CGPointMake(self.leftCenterX, self.heightY) controlPoint1:CGPointMake(self.leftCornerX + self.boundingWidth + (self.boundingWidth /2), self.centerY + (self.boundingHeight / 5)) controlPoint2:CGPointMake(self.leftCornerX, (self.centerY - (self.boundingHeight / 5)))];
        
        [path moveToPoint:CGPointMake(self.centerX, self.heightY)];
        [path addCurveToPoint:CGPointMake(self.centerX, self.heightY + self.boundingHeight) controlPoint1:CGPointMake((self.centerCornerX - (self.boundingWidth / 2)), (self.centerY - (self.boundingHeight / 5))) controlPoint2:CGPointMake(self.centerCornerX + self.boundingWidth, self.centerY + (self.boundingHeight / 5))];
        [path addCurveToPoint:CGPointMake(self.centerX, self.heightY) controlPoint1:CGPointMake(self.centerCornerX + self.boundingWidth + (self.boundingWidth /2), self.centerY + (self.boundingHeight / 5)) controlPoint2:CGPointMake(self.centerCornerX, (self.centerY - (self.boundingHeight / 5)))];

        
        [path moveToPoint:CGPointMake(self.rightCenterX, self.heightY)];
        [path addCurveToPoint:CGPointMake(self.rightCenterX, self.heightY + self.boundingHeight) controlPoint1:CGPointMake((self.rightCornerX - (self.boundingWidth / 2)), (self.centerY - (self.boundingHeight / 5))) controlPoint2:CGPointMake(self.rightCornerX + self.boundingWidth, self.centerY + (self.boundingHeight / 5))];
        [path addCurveToPoint:CGPointMake(self.rightCenterX, self.heightY) controlPoint1:CGPointMake(self.rightCornerX + self.boundingWidth + (self.boundingWidth /2), self.centerY + (self.boundingHeight / 5)) controlPoint2:CGPointMake(self.rightCornerX, (self.centerY - (self.boundingHeight / 5)))];
    }
}

- (void)drawDiamondWithColor:(SetCardSymbolColor)symbolColor withTexture:(SetCardSymbolTexture)symbolTexture
{
    UIBezierPath *drawDiamond = [[UIBezierPath alloc] init];
    [self drawPathForDiamond:drawDiamond withSymbolAmount:self.setCard.symbolAmountOnCard];
    [[self symbolColorForEnum:symbolColor] setStroke];
    drawDiamond.lineWidth = 5.5;
    [drawDiamond stroke];
    [drawDiamond addClip];
    [self createSymbolWithTexture:symbolTexture andFillColor:[self symbolColorForEnum:symbolColor]];
}

- (void)drawPathForDiamond:(UIBezierPath *)path withSymbolAmount:(SetCardSymbolAmount)symbolAmount
{
    if (symbolAmount == SetCardSymbolAmount1) {
        [path moveToPoint:CGPointMake(self.centerX, self.heightY)];
        [path addLineToPoint:CGPointMake(self.centerCornerX + self.boundingWidth, self.centerY)];
        [path addLineToPoint:CGPointMake(self.centerX, self.heightY + self.boundingHeight)];
        [path addLineToPoint:CGPointMake(self.centerCornerX, self.centerY)];
        [path closePath];
    }
    if (symbolAmount == SetCardSymbolAmount2) {
        [path moveToPoint:CGPointMake(self.leftCenterX, self.heightY)];
        [path addLineToPoint:CGPointMake(self.leftCornerX + self.boundingWidth, self.centerY)];
        [path addLineToPoint:CGPointMake(self.leftCenterX, self.heightY + self.boundingHeight)];
        [path addLineToPoint:CGPointMake(self.leftCornerX, self.centerY)];
        [path closePath];
        
        [path moveToPoint:CGPointMake(self.rightCenterX, self.heightY)];
        [path addLineToPoint:CGPointMake(self.rightCornerX + self.boundingWidth, self.centerY)];
        [path addLineToPoint:CGPointMake(self.rightCenterX, self.heightY + self.boundingHeight)];
        [path addLineToPoint:CGPointMake(self.rightCornerX, self.centerY)];
        [path closePath];
        
    }
    if (symbolAmount == SetCardSymbolAmount3) {
        [path moveToPoint:CGPointMake(self.centerX, self.heightY)];
        [path addLineToPoint:CGPointMake(self.centerCornerX + self.boundingWidth, self.centerY)];
        [path addLineToPoint:CGPointMake(self.centerX, self.heightY + self.boundingHeight)];
        [path addLineToPoint:CGPointMake(self.centerCornerX, self.centerY)];
        [path closePath];
        
        [path moveToPoint:CGPointMake(self.leftCenterX, self.heightY)];
        [path addLineToPoint:CGPointMake(self.leftCornerX + self.boundingWidth, self.centerY)];
        [path addLineToPoint:CGPointMake(self.leftCenterX, self.heightY + self.boundingHeight)];
        [path addLineToPoint:CGPointMake(self.leftCornerX, self.centerY)];
        [path closePath];
        
        [path moveToPoint:CGPointMake(self.rightCenterX, self.heightY)];
        [path addLineToPoint:CGPointMake(self.rightCornerX + self.boundingWidth, self.centerY)];
        [path addLineToPoint:CGPointMake(self.rightCenterX, self.heightY + self.boundingHeight)];
        [path addLineToPoint:CGPointMake(self.rightCornerX, self.centerY)];
        [path closePath];
    }
}

- (void)drawRoundedRectWithColor:(SetCardSymbolColor)symbolColor withSymbolTexture:(SetCardSymbolTexture)symbolTexture
{
    UIBezierPath *drawRoundRect = [[UIBezierPath alloc] init];
    drawRoundRect = [self drawPathForRoundedRectWithSymbolAmount:self.setCard.symbolAmountOnCard];
    [[self symbolColorForEnum:symbolColor] setStroke];
    drawRoundRect.lineWidth = 5.5;
    [drawRoundRect stroke];
    [drawRoundRect addClip];
    [self createSymbolWithTexture:symbolTexture andFillColor:[self symbolColorForEnum:symbolColor]];
}

- (UIBezierPath *)drawPathForRoundedRectWithSymbolAmount:(SetCardSymbolAmount)symbolAmount
{
    if (symbolAmount == SetCardSymbolAmount1) {
        UIBezierPath *path = [[UIBezierPath alloc] init];
        path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.centerCornerX, self.heightY, self.boundingWidth, self.boundingHeight) cornerRadius:self.cornerRadius];
        return path;
    }
    if (symbolAmount == SetCardSymbolAmount2) {
        UIBezierPath *path = [[UIBezierPath alloc] init];
        UIBezierPath *path2 = [[UIBezierPath alloc] init];
        path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.leftCornerX, self.heightY, self.boundingWidth, self.boundingHeight) cornerRadius:self.cornerRadius];
        path2 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.rightCornerX, self.heightY, self.boundingWidth, self.boundingHeight) cornerRadius:self.cornerRadius];

        [path appendPath:path2];

        return path;
    }
    if (symbolAmount ==  SetCardSymbolAmount3) {
        UIBezierPath *path = [[UIBezierPath alloc] init];
        UIBezierPath *path2 = [[UIBezierPath alloc] init];
        UIBezierPath *path3 = [[UIBezierPath alloc] init];
        path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.centerCornerX, self.heightY, self.boundingWidth, self.boundingHeight) cornerRadius:self.cornerRadius];
        path2 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.leftCornerX, self.heightY, self.boundingWidth, self.boundingHeight) cornerRadius:self.cornerRadius];
        path3 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.rightCornerX, self.heightY, self.boundingWidth, self.boundingHeight) cornerRadius:self.cornerRadius];
        [path appendPath:path2];
        [path appendPath:path3];
        return path;
    }
    return nil;
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

@end
