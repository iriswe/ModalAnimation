//
//  PresentOneTransition.h
//  PushPopPresentDismissAnimation
//
//  Created by ludashen on 2017/3/5.
//  Copyright © 2017年 lulu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PresentOneTransitionType) {
    TypePresent = 0,
    TypeDismiss
};

@interface PresentOneTransition : NSObject <UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithTransitionType:(PresentOneTransitionType)type;

- (instancetype)initWithTransitionType:(PresentOneTransitionType)type;

@end
