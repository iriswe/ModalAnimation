//
//  PresentViewController.m
//  PushPopPresentDismissAnimation
//
//  Created by ludashen on 2017/3/7.
//  Copyright © 2017年 lulu. All rights reserved.
//

#import "PresentViewController.h"

@interface PresentViewController () <PresentedOneControllerDelegate>

@property (nonatomic, strong) InteractiveTransition *transition;

@end

@implementation PresentViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hero.png"]];
    imageView.frame = CGRectMake(0, 64, self.view.frame.size.width, 400);
    imageView.layer.cornerRadius = 10;
    imageView.layer.masksToBounds = YES;
    [self.view addSubview:imageView];
    
    _transition = [InteractiveTransition interactiveTransitionWithTransitionType:InteractiveTransitionTypePresent GestureDirection:InteractiveTransitionGestureDirectionUp];
    
    __weak typeof(self)weakSelf = self;
    _transition.presentConfig = ^{
        [weakSelf present];
    };
    
    [_transition addPanGestureForViewController:self.navigationController];

}

- (void)present {
    PresentedViewController *presentedVC = [PresentedViewController new];
    presentedVC.delegate = self;
    [self presentViewController:presentedVC animated:YES completion:nil];
}

- (void)presentedOneControllerPressedDissmiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPresent
{
    return _transition;
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
