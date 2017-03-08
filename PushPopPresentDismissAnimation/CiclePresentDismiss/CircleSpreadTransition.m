//
//  CircleSpreadTransition.m
//  PushPopPresentDismissAnimation
//
//  Created by ludashen on 2017/3/8.
//  Copyright © 2017年 lulu. All rights reserved.
//

#import "CircleSpreadTransition.h"
#import "CircleViewController.h"

@implementation CircleSpreadTransition

+ (instancetype)transitionWithTransitionType:(TransitionType)type
{
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(TransitionType)type
{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    switch (_type) {
        case TypePresent:
            [self present:transitionContext];
            break;
        case TypeDismiss:
            [self dismiss:transitionContext];
            break;
        default:
            break;
    }
    
}

- (void)present:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UINavigationController *fromViewController = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CircleViewController *tempVC = fromViewController.viewControllers.lastObject;
    
    UIView *container = [transitionContext containerView];
    [container addSubview:toViewController.view];
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:tempVC.btn.frame];
    
    CGFloat x = MAX(tempVC.btn.frame.origin.x, container.frame.size.width - tempVC.btn.frame.origin.x);
    CGFloat y = MAX(tempVC.btn.frame.origin.y, container.frame.size.height - tempVC.btn.frame.origin.y);
    CGFloat redius = sqrtf(pow(x, 2) + pow(y, 2));
    
    UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:container.center radius:redius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    
    toViewController.view.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.delegate = self;
    animation.fromValue = (__bridge id _Nullable)(startPath.CGPath);
    animation.toValue = (__bridge id _Nullable)(endPath.CGPath);
    
    animation.duration = [self transitionDuration:transitionContext];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [animation setValue:transitionContext forKeyPath:@"transitionContext"];
    [maskLayer addAnimation:animation forKey:@"path"];
}

- (void)dismiss:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UINavigationController *toVC = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CircleViewController *tempVC = toVC.viewControllers.lastObject;
    
    UIView *container = [transitionContext containerView];
    
    CGFloat redius = sqrtf(pow(container.frame.size.width, 2) + pow(container.frame.size.height, 2)) / 2;
    UIBezierPath *startPath = [UIBezierPath bezierPathWithArcCenter:container.center radius:redius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:tempVC.btn.frame];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    fromVC.view.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.delegate = self;
    animation.fromValue = (__bridge id _Nullable)(startPath.CGPath);
    animation.toValue = (__bridge id _Nullable)(endPath.CGPath);
    animation.duration = [self transitionDuration:transitionContext];
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [animation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:animation forKey:@"path"];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    switch (_type) {
        case TypePresent: {
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:YES];
        }
            break;
        case TypeDismiss: {
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
            }
        }
            break;
        default:
            break;
    }
}

@end
