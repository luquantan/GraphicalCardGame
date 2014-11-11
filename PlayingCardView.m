    //
//  PlayingCardView.m
//  GraphicalCardGame
//
//  Created by LuQuan Intrepid on 11/7/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import "PlayingCardView.h"
#import "PlayingCard.h" 

@interface PlayingCardView ()
//For scaling the roundedRect
@property (nonatomic) CGFloat cornerScaleFactor;
@property (nonatomic) CGFloat cornerRadius;
@property (nonatomic) CGFloat cornerOffset;
@property (nonatomic) CGFloat faceCardScaleFactor;

//For drawing scaling the pips on the PlayingCards
@property (nonatomic) NSString *rank; //NSInteger for rank and suit maybe because that is how i defined it in the first place.
@property (nonatomic) NSString *suit;
@end

@implementation PlayingCardView

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame andPlayingCard:(PlayingCard *)playingCard
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.masksToBounds = YES;
        self.playingCard = playingCard;
        self.contents = playingCard.contentsOfCard;
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
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
    
    [self setRoundedRectScalingValues];
}

#pragma mark - Setting Properties
//call setNeedsDisplay for all the setters of the public API
//because if someone changes something, i need to tell the system that i need redrawing
@synthesize faceCardScaleFactor = _faceCardScaleFactor;
- (CGFloat)faceCardScaleFactor
{
    const CGFloat DEFAULT_FACE_CARD_SCALE_FACTOR = 0.90;
    if (!_faceCardScaleFactor) {
        _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
    }
    return _faceCardScaleFactor;
}
- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor
{
    _faceCardScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];
}

- (void)setSuit:(NSString *)suit
{
    _suit = suit;
    [self setNeedsDisplay];
}
- (void)setRank:(NSString *)rank
{
    _rank = rank;
    [self setNeedsDisplay];
}
- (void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

- (void)setContents:(NSString *)contents
{
    _contents = contents;
    [self setRankAndSuitFromContents];
}
- (void)setRankAndSuitFromContents
{
    NSArray *componentArray = [self.contents componentsSeparatedByString:@" "];
    NSString *rankString = [NSString stringWithFormat:@"%@", componentArray[0]];
    NSString *suitString = [NSString stringWithFormat:@"%@", componentArray[1]];
    self.rank = rankString;
    self.suit = suitString;
}

#pragma mark - Drawing
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.cornerRadius];
    
    //This clips our view and all the drawings to the roundedRect
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    if (self.faceUp) {

        UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@", self.contents]];
        
        if (faceImage) {
            CGRect imageRect = CGRectInset(self.bounds, self.bounds.size.width * (1.0 - self.faceCardScaleFactor), self.bounds.size.height * (1.0 - self.faceCardScaleFactor));
            [faceImage drawInRect:imageRect];
        } else {
            [self drawPips];
        }
        
        [self drawCorners];
    } else {
        [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds];
    }

}

- (void)drawPips
{
    const float PIP_HOFFSET_PERCENTAGE = 0.165;
    const float PIP_VOFFSET1_PERCENTAGE = 0.090;
    const float PIP_VOFFSET2_PERCENTAGE = 0.175;
    const float PIP_VOFFSET3_PERCENTAGE = 0.270;
    
    if ([self.rank isEqual: @"A" ] || [self.rank isEqual:@"3" ] || [self.rank isEqual:@"5"] || [self.rank  isEqual: @"9"]) {
        [self drawPipsWithHorizontalOffset:0 verticalOffset:0 mirroredVertically:NO];
    }
    if ([self.rank isEqual: @"6" ] || [self.rank isEqual:@"7" ] || [self.rank isEqual:@"8"] ) {
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE verticalOffset:0 mirroredVertically:NO];
    }
    if ([self.rank isEqual: @"2" ] || [self.rank isEqual:@"3" ] || [self.rank isEqual:@"7"] || [self.rank  isEqual: @"8"] || [self.rank  isEqual: @"10"]) {
        [self drawPipsWithHorizontalOffset:0 verticalOffset:PIP_VOFFSET2_PERCENTAGE mirroredVertically:![self.rank isEqualToString:@"7"]];
    }
    if ([self.rank isEqual: @"4" ] || [self.rank isEqual:@"5" ] || [self.rank isEqual:@"6"] || [self.rank  isEqual: @"7"] || [self.rank  isEqual: @"8"] || [self.rank  isEqual: @"9"] || [self.rank  isEqual: @"10"]) {
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE verticalOffset:PIP_VOFFSET3_PERCENTAGE mirroredVertically:YES];
    }
    if ([self.rank isEqual: @"9" ] || [self.rank isEqual:@"10" ]) {
        [self drawPipsWithHorizontalOffset:PIP_HOFFSET_PERCENTAGE verticalOffset:PIP_VOFFSET1_PERCENTAGE mirroredVertically:YES];
    }
 }

- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset verticalOffset:(CGFloat)voffset upsideDown:(BOOL)upsideDown
{
    const float PIP_FONT_SCALE_FACTOR = 0.012;
    if (upsideDown) {
        [self pushContextAndRotateUpsideDown];
    }
    CGPoint middle = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    UIFont *pipFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    pipFont = [pipFont fontWithSize:[pipFont pointSize] * self.bounds.size.width * PIP_FONT_SCALE_FACTOR];
    NSAttributedString *attributeSuit = [[NSAttributedString alloc] initWithString:self.suit attributes:@{NSFontAttributeName : pipFont}];
    CGSize pipSize = [attributeSuit size];
    CGPoint pipOrigin = CGPointMake(middle.x - pipSize.width/2.0 - hoffset * self.bounds.size.width, middle.y - pipSize.height/2.0 - voffset * self.bounds.size.height);
    [attributeSuit drawAtPoint:pipOrigin];
    if (hoffset) {
        pipOrigin.x += hoffset * 2.0 * self.bounds.size.width;
        [attributeSuit drawAtPoint:pipOrigin];
    }
    if (upsideDown) {
        [self popContext];
    }
}

- (void)drawPipsWithHorizontalOffset:(CGFloat)hoffset verticalOffset:(CGFloat)voffset mirroredVertically:(BOOL)mirroredVertically
{
    [self drawPipsWithHorizontalOffset:hoffset verticalOffset:voffset upsideDown:NO];
    if (mirroredVertically) {
        [self drawPipsWithHorizontalOffset:hoffset verticalOffset:voffset upsideDown:YES];
    }
}
- (void)drawCorners
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
    //But we still need to scale the fonts depending on the size of the card
    cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * self.cornerScaleFactor];
    
    NSMutableAttributedString *cornerText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", self.rank, self.suit]
                                                                                   attributes:@{NSFontAttributeName : cornerFont, NSParagraphStyleAttributeName : paragraphStyle}];

    CGRect textBounds;
    textBounds.origin = CGPointMake(self.cornerOffset, self.cornerOffset);
    textBounds.size = [cornerText size];
    [cornerText drawInRect:textBounds];
    
    [self pushContextAndRotateUpsideDown];
    [cornerText drawInRect:textBounds];
    [self popContext];
}

- (void)pushContextAndRotateUpsideDown
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
}

- (void)popContext
{
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}


#pragma mark - Gestures
- (void)updateCard
{
    self.faceUp = self.playingCard.isCardChosen;
   if (self.playingCard.isCardMatched) {
        self.alpha = 0.5;
    }
}

//- (void)tap:(UITapGestureRecognizer *)gesture
//{
//    if (!self.playingCard.isCardMatched) {
//        if (gesture.state == UIGestureRecognizerStateEnded) {
//            self.faceUp = self.playingCard.isCardChosen;
//        }
//    } else if (self.playingCard.isCardMatched) {
//        self.alpha = 0.5;
////        [self setNeedsDisplay];
//    }
//}


#pragma mark - Method to set the scale of the bounding radius for RoundedRect
//Call this in the view init
- (void)setRoundedRectScalingValues
{
    const CGFloat CORNER_FONT_STANDARD_HEIGHT = 180.0;
    const CGFloat CORNER_RADIUS = 5.0;
    self.cornerScaleFactor = self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT;
    self.cornerRadius = CORNER_RADIUS * self.contentScaleFactor;
    self.cornerOffset = self.cornerRadius / 3.0;
    
}
                                 
@end
