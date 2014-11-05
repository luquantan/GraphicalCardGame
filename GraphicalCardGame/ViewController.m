//
//  ViewController.m
//  GraphicalCardGame
//
//  Created by LuQuan Intrepid on 11/4/14.
//  Copyright (c) 2014 LuQuan Intrepid. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCard.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    PlayingCard *somePlayingCard = [[PlayingCard alloc]init];
    
    NSLog(@"The value of rank is %li",somePlayingCard.rank);
    somePlayingCard.rank = 1;
    NSLog(@"The value of rank is %li",somePlayingCard.rank);
    
    somePlayingCard.rank = 55;
    NSLog(@"The value of rank is %ld",somePlayingCard.rank);
    
    somePlayingCard.rank = PlayingCard10;
    NSLog(@"The value of rank is %li",somePlayingCard.rank);
    NSLog(@"Does playingcard rank = 8? %i",somePlayingCard.rank == PlayingCard10);
    BOOL boolOp =1;
    NSLog(@"The value of the boolean is %i",boolOp);
    boolOp  = 0;
    NSLog(@"The value of the boolean is %i",boolOp);
    boolOp = 5;
    NSLog(@"The value of the boolean is %i",boolOp);

}
@end
