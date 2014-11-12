//
//  SetCardView.h
//  GraphicalCardGame
//
//  Created by LuQuan Intrepid on 11/12/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SetCard;

@interface SetCardView : UIView
@property (strong, nonatomic) SetCard *setCard;
@property (nonatomic) BOOL selected;

- (void)updateCard;
- (instancetype)initWithFrame:(CGRect)frame andSetCard:(SetCard *)setCard;
@end
