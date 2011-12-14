//
//  UIView-AlertAnimations.h
//  TruthOrDare
//
//  Created by Administrator on 08/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface UIView(AlertAnimations)

- (void)doPopInAnimationX;
- (void)doPopInAnimationY;
- (void)doPopInAnimationXWithDelegate:(id)animationDelegate;
- (void)doPopInAnimationYWithDelegate:(id)animationDelegate;
- (void)doFadeInAnimation;
- (void)doFadeInAnimationWithDelegate:(id)animationDelegate;

@end
