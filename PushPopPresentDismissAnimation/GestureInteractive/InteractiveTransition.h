//
//  InteractiveTransition.h
//  PushPopPresentDismissAnimation
//
//  Created by ludashen on 2017/3/5.
//  Copyright © 2017年 lulu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^GestureConfig)();

typedef NS_ENUM(NSUInteger, InteractiveTransitionGestureDirection) {
    InteractiveTransitionGestureDirectionLeft = 0,
    InteractiveTransitionGestureDirectionRight,
    InteractiveTransitionGestureDirectionUp,
    InteractiveTransitionGestureDirectionDown
};//GestureDirection

typedef NS_ENUM(NSUInteger, InteractiveTransitionType) {
    InteractiveTransitionTypePresent = 0,
    InteractiveTransitionTypeDismiss,
    InteractiveTransitionTypePush,
    InteractiveTransitionTypePop,
};//GestureType


@interface InteractiveTransition : UIPercentDrivenInteractiveTransition
//
@property (nonatomic, assign) BOOL interaction;
@property (nonatomic, copy) GestureConfig presentConfig;
@property (nonatomic, copy) GestureConfig pushConfig;


+ (instancetype)interactiveTransitionWithTransitionType:(InteractiveTransitionType)type GestureDirection:(InteractiveTransitionGestureDirection)direction;

- (instancetype)initWithTransitionType:(InteractiveTransitionType)type GestureDirection:(InteractiveTransitionGestureDirection)direction;


- (void)addPanGestureForViewController:(UIViewController *)viewController;

@end















