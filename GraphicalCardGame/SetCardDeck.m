//
//  SetCardDeck.m
//  GraphicalCardGame
//
//  Created by LuQuan Intrepid on 11/5/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init
{
    self = [super init];
    if (self) {
        for (NSInteger i = 0; i < 3; i++) {
            for (NSInteger j = 0; j < 3; j++) {
                for (NSInteger k = 0; k < 3; k++) {
                    for (NSInteger l = 0 ; l < 3; l++) {
                        SetCard *someSetCard = [[SetCard alloc]init];
                        someSetCard.symbolAmountOnCard = i;
                        someSetCard.symbolColorOnCard = j;
                        someSetCard.symbolTextureOnCard = k;
                        someSetCard.symbolShapeOnCard = l;
                        [self addCard:someSetCard];
                    }
                }
            }
        }
    }
    return self;
}
@end
