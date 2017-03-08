//
//  InteractiveTransition.m
//  PushPopPresentDismissAnimation
//
//  Created by ludashen on 2017/3/5.
//  Copyright © 2017年 lulu. All rights reserved.
//

#import "InteractiveTransition.h"

@interface InteractiveTransition ()

@property (nonatomic, weak) UIViewController *vc;
@property (nonatomic, assign) InteractiveTransitionGestureDirection direction;
@property (nonatomic, assign) InteractiveTransitionType type;

@end

@implementation InteractiveTransition

+ (instancetype)interactiveTransitionWithTransitionType:(InteractiveTransitionType)type GestureDirection:(InteractiveTransitionGestureDirection)direction
{
    return [[self alloc] initWithTransitionType:type GestureDirection:direction];
}

- (instancetype)initWithTransitionType:(InteractiveTransitionType)type GestureDirection:(InteractiveTransitionGestureDirection)direction
{
    self = [super init];
    if (self) {
        _direction = direction;
        _type = type;
    }
    return self;
}

- (void)addPanGestureForViewController:(UIViewController *)viewController
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    self.vc = viewController;
    [viewController.view addGestureRecognizer:pan];
}

- (void)handleGesture:(UIPanGestureRecognizer *)panGesture
{
    CGFloat percent = 0;
    switch (_direction) {
        case InteractiveTransitionGestureDirectionLeft:{
            CGFloat transitionX = -[panGesture translationInView:panGesture.view].x;
            percent = transitionX / panGesture.view.frame.size.width;
        }
            break;
        case InteractiveTransitionGestureDirectionRight:{
            CGFloat transitionX = [panGesture translationInView:panGesture.view].x;
            percent = transitionX / panGesture.view.frame.size.width;
        }
            break;
        case InteractiveTransitionGestureDirectionUp:{
            CGFloat transitionY = -[panGesture translationInView:panGesture.view].y;
            percent = transitionY / panGesture.view.frame.size.width;
        }
            break;
        case InteractiveTransitionGestureDirectionDown:{
            CGFloat transitionY = [panGesture translationInView:panGesture.view].y;
            percent = transitionY / panGesture.view.frame.size.width;
        }
            break;
        default:
            break;
    }
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.interaction = YES;
            [self startGesture];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self updateInteractiveTransition:percent];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            self.interaction = NO;
            if (percent >= 0.5) {
                [self finishInteractiveTransition];
            } else {
                [self cancelInteractiveTransition];
            }
        }
            break;
        default:
            break;
    }
}


- (void)startGesture
{
    switch (_type) {
        case InteractiveTransitionTypePresent:{
            if (_presentConfig) {
                _presentConfig();
            }
        }
            break;
        case InteractiveTransitionTypeDismiss:{
            [_vc dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case InteractiveTransitionTypePush:{
            if (_pushConfig) {
                _pushConfig();
            }
        }
            break;
        case InteractiveTransitionTypePop:{
            [_vc.navigationController popViewControllerAnimated:YES];
        }
            break;
        default:
            break;
    }
}


















@end
