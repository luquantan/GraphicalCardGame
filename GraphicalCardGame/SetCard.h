//
//  SetCard.h
//  GraphicalCardGame
//
//  Created by LuQuan Intrepid on 11/5/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import "Card.h"
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SetCardSymbolAmount)
{
    SetCardSymbolAmount1,
    SetCardSymbolAmount2,
    SetCardSymbolAmount3,
    SetCardSymbolAmountCount
};

typedef NS_ENUM(NSInteger, SetCardSymbolColor)
{
    SetCardSymbolColor1,
    SetCardSymbolColor2,
    SetCardSymbolColor3,
    SetCardSymbolColorCount
};

typedef NS_ENUM(NSInteger, SetCardSymbolTexture)
{
    SetCardSymbolTexture1,
    SetCardSymbolTexture2,
    SetCardSymbolTexture3,
    SetCardSymbolTextureCount
};

typedef NS_ENUM(NSInteger, SetCardSymbolShape)
{
    SetCardSymbolShape1,
    SetCardSymbolShape2,
    SetCardSymbolShape3,
    SetCardSymbolShapeCount
};

@interface SetCard : Card
//I need to find a way to properly decide on the public interface for SetCard
//It need to encapsulate the match logic but hardwire the UI into the model
@property (nonatomic) SetCardSymbolAmount symbolAmountOnCard;
@property (nonatomic) SetCardSymbolColor symbolColorOnCard;
@property (nonatomic) SetCardSymbolTexture symbolTextureOnCard;
@property (nonatomic) SetCardSymbolShape symbolShapeOnCard;
@end
