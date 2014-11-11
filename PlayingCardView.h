//
//  PlayingCardView.h
//  GraphicalCardGame
//
//  Created by LuQuan Intrepid on 11/7/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlayingCard;

@interface PlayingCardView : UIView
@property (strong, nonatomic) PlayingCard *playingCard;
@property (strong,nonatomic) NSString *contents;
@property (nonatomic) BOOL faceUp;

- (void)tap:(UITapGestureRecognizer *)gesture;
- (instancetype)initWithFrame:(CGRect)frame andPlayingCard:(PlayingCard *)playingCard;

@end
