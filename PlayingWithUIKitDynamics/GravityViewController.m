//
//  GravityViewController.m
//  PlayingWithUIKitDynamics
//
//  Created by Michael Vilabrera on 8/11/14.
//  Copyright (c) 2014 Giving Tree. All rights reserved.
//

#import "GravityViewController.h"

@interface GravityViewController ()

@property (nonatomic, strong) NSMutableArray *squareViews;
@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation GravityViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSUInteger const NumberOfViews = 2;
    
    self.squareViews = [[NSMutableArray alloc] initWithCapacity:NumberOfViews];
    NSArray *colors = @[[UIColor redColor], [UIColor greenColor]];
    
    CGPoint currentCenterPoint = self.view.center;
    CGSize eachViewSize = CGSizeMake(50.0f, 50.0f);
    for (NSUInteger counter = 0; counter < NumberOfViews; counter++) {
        UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, eachViewSize.width, eachViewSize.height)];
        aView.backgroundColor = colors[counter];
        aView.center = currentCenterPoint;
        
        currentCenterPoint.y += eachViewSize.height + 10.0f;
        
        [self.view addSubview:aView];
        [self.squareViews addObject:aView];
    }
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:self.squareViews];
    [self.animator addBehavior:gravity];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:self.squareViews];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collision];
}

@end
