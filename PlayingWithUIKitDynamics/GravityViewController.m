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
@property (nonatomic, strong) UIView *squareViewAnchorView;
@property (nonatomic, strong) UIView *anchorView;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIAttachmentBehavior *attachmentBehavior;

@end

@implementation GravityViewController

- (void) createSmallSquareView
{
    self.squareView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 80.0f, 80.0f)];
    
    self.squareView.backgroundColor = [UIColor greenColor];
    self.squareView.center = self.view.center;
    
    self.squareViewAnchorView = [[UIView alloc] initWithFrame:CGRectMake(60.0f, 0.0f, 20.0f, 20.0f)];
    self.squareViewAnchorView.backgroundColor = [UIColor blackColor];
    
    [self.squareView addSubview:self.squareViewAnchorView];
    [self.view addSubview:self.squareView];
}

- (void) createAnchorView
{
    self.anchorView = [[UIView alloc] initWithFrame:CGRectMake(120.0f, 120.0f, 20.0f, 20.0f)];
    self.anchorView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.anchorView];
}

- (void) createGestureRecognizer
{
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
}

- (void) createAnimatorAndBehaviors
{
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    // create collision detection
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.squareView]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    
#warning init method in book was not available- initWithItem:point:attachedToAnchor: method missing
    self.attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.squareView attachedToAnchor:self.anchorView.center];
    [self.animator addBehavior:collision];
    [self.animator addBehavior:self.attachmentBehavior];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self createGestureRecognizer];
    [self createSmallSquareView];
    [self createAnchorView];
    [self createAnimatorAndBehaviors];
}

- (void) handlePan:(UIPanGestureRecognizer *)pan
{
    CGPoint tapPoint = [pan locationInView:self.view];
    [self.attachmentBehavior setAnchorPoint:tapPoint];
    self.anchorView.center = tapPoint;
}

@end
