//
//  CircleSpreadTransition.h
//  PushPopPresentDismissAnimation
//
//  Created by ludashen on 2017/3/8.
//  Copyright © 2017年 lulu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TransitionType) {
    TypePresent,
    TypeDismiss
};

@interface CircleSpreadTransition : NSObject <UIViewControllerAnimatedTransitioning, CAAnimationDelegate>

@property (nonatomic, assign)TransitionType type;

+ (instancetype)transitionWithTransitionType:(TransitionType)type;
- (instancetype)initWithTransitionType:(TransitionType)type;

@end
