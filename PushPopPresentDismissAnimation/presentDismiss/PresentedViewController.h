//
//  PresentedViewController.h
//  PushPopPresentDismissAnimation
//
//  Created by ludashen on 2017/3/5.
//  Copyright © 2017年 lulu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PresentedOneControllerDelegate <NSObject>

- (void)presentedOneControllerPressedDissmiss;
- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPresent;

@end


@interface PresentedViewController : UIViewController
@property (nonatomic, assign) id<PresentedOneControllerDelegate> delegate;
@end
