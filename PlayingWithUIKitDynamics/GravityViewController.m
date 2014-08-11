//
//  GravityViewController.m
//  PlayingWithUIKitDynamics
//
//  Created by Michael Vilabrera on 8/11/14.
//  Copyright (c) 2014 Giving Tree. All rights reserved.
//

#import "GravityViewController.h"


@interface GravityViewController ()

@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation GravityViewController

- (UIView *) newViewWithCenter:(CGPoint)center backgroundColor:(UIColor *)backgroundColor
{
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 50.0f, 50.0f)];
    aView.backgroundColor = backgroundColor;
    aView.center = center;
    return aView;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UIView *topView = [self newViewWithCenter:CGPointMake(100.0f, 0.0f) backgroundColor:[UIColor greenColor]];
    UIView *bottomView = [self newViewWithCenter:CGPointMake(100.0f, 50.0f) backgroundColor:[UIColor redColor]];
    [self.view addSubview:topView];
    [self.view addSubview:bottomView];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[topView, bottomView]];
    [self.animator addBehavior:gravity];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[topView, bottomView]];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collision];
    
    UIDynamicItemBehavior *moreElasticItem = [[UIDynamicItemBehavior alloc] initWithItems:@[bottomView]];
    moreElasticItem.elasticity = 1.0f;
    UIDynamicItemBehavior *lessElasticItem = [[UIDynamicItemBehavior alloc] initWithItems:@[topView]];
    lessElasticItem.elasticity = 0.5f;
    [self.animator addBehavior:moreElasticItem];
    [self.animator addBehavior:lessElasticItem];
}

@end
