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
//Properties for setting the coordinates and bounding values for the drawings
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGFloat boundingWidth;
@property (nonatomic) CGFloat boundingHeight;
@property (nonatomic) CGFloat middleX;
@property (nonatomic) CGFloat middleY;
@property (nonatomic) CGFloat leftX;
@property (nonatomic) CGFloat leftY;
@property (nonatomic) CGFloat rightX;
@property (nonatomic) CGFloat rightY;
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
    [self settingCoordinatesForDrawingSetCardObjects];
}

- (void)setCardCornerRadius
{
    const CGFloat CORNER_RADIUS = 5.0;
    self.cornerRadius = CORNER_RADIUS * self.contentScaleFactor;
}

- (void)settingCoordinatesForDrawingSetCardObjects
{
    //Center X and Y of the view
    self.centerX = CGRectGetMidX(self.bounds);
    self.centerY = CGRectGetMidY(self.bounds);
    
    
    //Bounding width and height of each element on the card
    self.boundingWidth = self.bounds.size.width / 5;
    self.boundingHeight = self.bounds.size.height / 5 * 3;
    
    //Top left corner for drawing middle element
    self.middleX = self.centerX - (self.boundingWidth / 2);
    self.middleY = self.centerY - (self.boundingHeight / 2);
    
    //Top left corner of the leftmost element
    self.leftX = self.middleX - self.boundingWidth - (self.boundingWidth / 4);
    self.leftY = self.middleY;
    
    //Top left corner of the rightmost element
    self.rightX = self.middleX + (self.boundingWidth * 2) + (self.boundingWidth / 4);
    self.rightY = self.middleY;
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
    
    
    [self drawDiamondWithColor:self.setCard.symbolColorOnCard withTexture:self.setCard.symbolTextureOnCard];
}

- (void)drawSetCard
{
    
}

- (void)drawSquiggleWithColor:(SetCardSymbolColor)symbolColor withTexture:(SetCardSymbolTexture)symbolTexture
{
    //Implement UIBezierPath as such to create this
    [self createSymbolWithTexture:symbolTexture];
}

- (void)drawDiamondWithColor:(SetCardSymbolColor)symbolColor withTexture:(SetCardSymbolTexture)symbolTexture
{
    UIBezierPath *drawDiamond = [[UIBezierPath alloc] init];
    [drawDiamond moveToPoint:CGPointMake(self.centerX, (self.centerY + (self.boundingHeight / 2)))];
    [drawDiamond addLineToPoint:CGPointMake((self.centerX + (self.boundingWidth / 2)), self.centerY)];
    [drawDiamond addLineToPoint:CGPointMake(self.centerX, (self.centerY - (self.boundingHeight / 2)))];
    [drawDiamond addLineToPoint:CGPointMake((self.centerX - (self.boundingWidth / 2)), self.centerY)];
    [drawDiamond closePath];
    [drawDiamond addClip];
    [[self symbolColorForEnum:symbolColor] setStroke];
    [[self symbolColorForEnum:symbolColor] setFill];
    drawDiamond.lineWidth = 5.5;
    [drawDiamond stroke];
    [self createSymbolWithTexture:symbolTexture];
}

- (void)drawRoundedRectWithColor:(SetCardSymbolColor)symbolColor withTexture:(SetCardSymbolTexture)symbolTexture
{
    UIBezierPath *drawRoundRect = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.middleX, self.middleY, self.boundingWidth, self.boundingHeight) cornerRadius:self.cornerRadius];
    [drawRoundRect addClip];
    [[self symbolColorForEnum:symbolColor] setStroke];
    [[self symbolColorForEnum:symbolColor] setFill];
    drawRoundRect.lineWidth = 5.5;
    [drawRoundRect stroke];
    
    [self createSymbolWithTexture:symbolTexture];

    
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

- (void)createSymbolWithTexture:(SetCardSymbolTexture)symbolTexture
{
    switch (symbolTexture) {
        case SetCardSymbolTexture1:
            //No Fill
            break;
        case SetCardSymbolTexture2:
        {
            UIBezierPath *strippedTexture = [[UIBezierPath alloc] init];
            for (float i = self.middleY; i <= (self.middleY + self.boundingHeight); i+= 5.0) {
                [strippedTexture moveToPoint:CGPointMake(0, i)];
                [strippedTexture addLineToPoint:CGPointMake(self.bounds.size.width, i)];
                strippedTexture.lineWidth = 1.0;
                [strippedTexture stroke];
            }
        }
            break;
        case SetCardSymbolTexture3:
        {
            UIBezierPath *fillRect = [UIBezierPath bezierPathWithRect:CGRectMake(self.leftX, self.leftY, self.bounds.size.width, self.bounds.size.height)];
            [fillRect fillWithBlendMode:kCGBlendModeColor alpha:5.0];
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
