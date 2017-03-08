//
//  CircledViewController.m
//  PushPopPresentDismissAnimation
//
//  Created by ludashen on 2017/3/8.
//  Copyright © 2017年 lulu. All rights reserved.
//

#import "CircledViewController.h"
#import "CircleSpreadTransition.h"
#import "InteractiveTransition.h"

@interface CircledViewController () <UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) InteractiveTransition *transition;
@end

@implementation CircledViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timg3.jpg"]];
    [self.view addSubview:imageView];
    imageView.frame = self.view.frame;
    
    self.transition = [InteractiveTransition interactiveTransitionWithTransitionType:InteractiveTransitionTypeDismiss GestureDirection:InteractiveTransitionGestureDirectionDown];
    
    [self.transition addPanGestureForViewController:self];
    
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [CircleSpreadTransition transitionWithTransitionType:TypePresent];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [CircleSpreadTransition transitionWithTransitionType:TypeDismiss];
}


- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _transition.interaction ? _transition : nil;
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
