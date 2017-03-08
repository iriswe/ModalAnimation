//
//  PresentedViewController.m
//  PushPopPresentDismissAnimation
//
//  Created by ludashen on 2017/3/5.
//  Copyright © 2017年 lulu. All rights reserved.
//

#import "PresentedViewController.h"
#import "PresentOneTransition.h"
#import "InteractiveTransition.h"

@interface PresentedViewController () <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) InteractiveTransition *interactiveDismiss;

@end

@implementation PresentedViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
       return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [PresentOneTransition transitionWithTransitionType:TypePresent];
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [PresentOneTransition transitionWithTransitionType:TypeDismiss];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    return _interactiveDismiss.interaction ? _interactiveDismiss : nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator
{
    InteractiveTransition *interantivepresent = [_delegate interactiveTransitionForPresent];
    return interantivepresent.interaction ? interantivepresent : nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    self.interactiveDismiss = [InteractiveTransition interactiveTransitionWithTransitionType:InteractiveTransitionTypeDismiss GestureDirection:InteractiveTransitionGestureDirectionDown];
    [self.interactiveDismiss addPanGestureForViewController:self];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
