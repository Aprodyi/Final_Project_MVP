//
//  TransitionAnimation.m
//  Final_project
//
//  Created by Вова on 01.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "TransitionAnimation.h"

@implementation TransitionAnimation

+ (CATransition *)transitionAnimationWithType: (CATransitionType)type andSubtype: (CATransitionSubtype)subtype andDuration: (CFTimeInterval)duration
{
    CATransition* transition = [CATransition animation];
    transition.duration = duration;
    transition.type = type;
    transition.subtype = subtype;
    
    return transition;
}

@end
