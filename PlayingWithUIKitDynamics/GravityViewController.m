//
//  GravityViewController.m
//  PlayingWithUIKitDynamics
//
//  Created by Michael Vilabrera on 8/11/14.
//  Copyright (c) 2014 Giving Tree. All rights reserved.
//

#import "GravityViewController.h"

@interface GravityViewController ()

@property (nonatomic, strong) UIView *squareView;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravity;

@end

@implementation GravityViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // create the view and add it to self.view
    
    self.squareView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 100.0f)];
    self.squareView.backgroundColor = [UIColor greenColor];
    self.squareView.center = self.view.center;
    [self.view addSubview:self.squareView];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    self.gravity = [[UIGravityBehavior alloc] initWithItems:@[self.squareView]];
    [self.animator addBehavior:self.gravity];
}

@end
