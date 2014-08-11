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
@property (nonatomic, strong) UIPushBehavior *pushBehavior;

@end

@implementation GravityViewController

- (void) createSmallSquareView
{
    self.squareView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 80.0f, 80.0f)];
    
    self.squareView.backgroundColor = [UIColor greenColor];
    self.squareView.center = self.view.center;
    
    [self.view addSubview:self.squareView];
}

- (void) createGestureRecognizer
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void) createAnimatorAndBehaviors
{
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.squareView]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    self.pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.squareView] mode:UIPushBehaviorModeContinuous];
    [self.animator addBehavior:collision];
    [self.animator addBehavior:self.pushBehavior];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self createGestureRecognizer];
    [self createSmallSquareView];
    [self createAnimatorAndBehaviors];
}

- (void) handleTap:(UITapGestureRecognizer *)tap
{
    /*
     Get the angle between the center of the square view and the tap point
     */
    CGPoint tapPoint = [tap locationInView:self.view];
    CGPoint squareViewCenterPoint = self.squareView.center;
    
    /*
     calculate the angle between the center point of the square view and
     the tap point to find out the angle of the push
     formula for detecting the angle between two points is:
     arc tangent 2((p1.x - p2.x), (p1.y - p2.y))
     */
    CGFloat deltaX = tapPoint.x - squareViewCenterPoint.x;
    CGFloat deltaY = tapPoint.y - squareViewCenterPoint.y;
    CGFloat angle = atan2(deltaX, deltaY);
    
    [self.pushBehavior setAngle:angle];
    
    /*
     use the distance between the tap point and the center of our square
     view to calculate the magnitude of the push
     distance formula is:
     square root of ((p1.x - p2.x)^2 + (p1.y - p2.y)^2)
     */
    CGFloat distanceBetweenPoints = sqrt(pow(tapPoint.x - squareViewCenterPoint.x, 2.0) + pow(tapPoint.y - squareViewCenterPoint.y, 2.0));
    [self.pushBehavior setMagnitude:distanceBetweenPoints / 200.0f];
}

@end
