//
//  Card.h
//  GraphicalCardGame
//
//  Created by LuQuan Intrepid on 11/4/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong,nonatomic) NSString *contentsOfCard;
@property (nonatomic) BOOL chosen;
@property (nonatomic) BOOL matched;
@end
