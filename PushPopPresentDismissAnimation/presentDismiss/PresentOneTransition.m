//
//  PresentOneTransition.m
//  PushPopPresentDismissAnimation
//
//  Created by ludashen on 2017/3/5.
//  Copyright © 2017年 lulu. All rights reserved.
//

#import "PresentOneTransition.h"

@interface PresentOneTransition ()

@property (nonatomic, assign) PresentOneTransitionType type;

@end


@implementation PresentOneTransition

+ (instancetype)transitionWithTransitionType:(PresentOneTransitionType)type
{
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(PresentOneTransitionType)type
{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return _type == TypePresent ? 0.5 : 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    switch (_type) {
        case TypePresent:
            [self presentAnimation:transitionContext];
            break;
        case TypeDismiss:
            [self dismissAnimation:transitionContext];
        default:
            break;
    }
    
}

- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)trasitionContext
{
    
    UIViewController *toVC = [trasitionContext viewControllerForKey:UITransitionContextToViewControllerKey];//
    UIViewController *fromVC= [trasitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];//
    
    //截图做动画代替直接对toVC做动画
    UIView *shotView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    shotView.frame = fromVC.view.frame;
    
    fromVC.view.hidden = YES;
    
    //所有的需要转场动画的视图都要加入containView中
    UIView *containerView = [trasitionContext containerView];
    [containerView addSubview:shotView];
    [containerView addSubview:toVC.view];
    
    toVC.view.frame = CGRectMake(0, containerView.frame.size.height, containerView.frame.size.width, 400);
    
    //弹簧动画
    [UIView animateWithDuration:[self transitionDuration:trasitionContext] delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0 / 0.55 options:0 animations:^{
        toVC.view.transform = CGAffineTransformMakeTranslation(0, -400);
        shotView.transform = CGAffineTransformMakeScale(0.85, 0.85);
    } completion:^(BOOL finished) {
        [trasitionContext completeTransition:![trasitionContext transitionWasCancelled]];
        if ([trasitionContext transitionWasCancelled]) {
            fromVC.view.hidden = NO;
            [shotView removeFromSuperview];
        }
    }];
    
}

- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)trasitionContext
{
    UIViewController *toVC = [trasitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [trasitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    NSArray *viewArray = [trasitionContext containerView].subviews;
    UIView *shotView = viewArray[MIN(viewArray.count, MAX(0, viewArray.count - 2))];
    
    
    [UIView animateWithDuration:[self transitionDuration:trasitionContext] animations:^{
        fromVC.view.transform = CGAffineTransformIdentity;
        shotView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if ([trasitionContext transitionWasCancelled]) {
            [trasitionContext completeTransition:NO];
        } else {
            [trasitionContext completeTransition:YES];
            toVC.view.hidden = NO;
            [shotView removeFromSuperview];
        }
    }];
    
}





@end
