//
//  GravityViewController.m
//  PlayingWithUIKitDynamics
//
//  Created by Michael Vilabrera on 8/11/14.
//  Copyright (c) 2014 Giving Tree. All rights reserved.
//

#import "GravityViewController.h"

NSString *const kBottomBoundary = @"bottomBoundary";

@interface GravityViewController () <UICollisionBehaviorDelegate>

@property (nonatomic, strong) NSMutableArray *squareViews;
@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation GravityViewController

// UICollisionBehaviorDelegate method
- (void) collisionBehavior:(UICollisionBehavior *)behavior
       beganContactForItem:(id<UIDynamicItem>)item
    withBoundaryIdentifier:(id<NSCopying>)identifier
                   atPoint:(CGPoint)p
{
    NSString *theIdentifier = (NSString *)identifier;
    if ([theIdentifier isEqualToString:kBottomBoundary]) {
        
        [UIView animateWithDuration:1.0f animations:^{
            UIView *view = (UIView *)item;
            view.backgroundColor = [UIColor redColor];
            view.alpha = 0.0f;
            view.transform = CGAffineTransformMakeScale(2.0f, 2.0f);
        } completion:^(BOOL finished) {
            UIView *view = (UIView *)item;
            [behavior removeItem:item];
            [view removeFromSuperview];
        }];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSUInteger const NumberOfViews = 2;
    
    self.squareViews = [[NSMutableArray alloc] initWithCapacity:NumberOfViews];
    NSArray *colors = @[[UIColor redColor], [UIColor greenColor]];
    
    CGPoint currentCenterPoint = CGPointMake(50.0f, 50.0f);
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
    [collision addBoundaryWithIdentifier:kBottomBoundary fromPoint:CGPointMake(0.0f, self.view.bounds.size.height - 100.0f) toPoint:CGPointMake(self.view.bounds.size.width, self.view.bounds.size.height - 100.0f)];
    collision.collisionDelegate = self;
    [self.animator addBehavior:collision];
}

@end
