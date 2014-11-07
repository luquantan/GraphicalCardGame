//
//  PlayingCardView.h
//  GraphicalCardGame
//
//  Created by LuQuan Intrepid on 11/7/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (strong,nonatomic) NSString *contents;
@property (nonatomic) BOOL faceUp;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;
@end
