//
//  CellViewAnimator.m
//  YouQue
//
//  Created by Mohammed Eldehairy on 4/27/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import "CellViewAnimator.h"
#define degreesToRadians(x) (M_PI * (x) / 180.0)
#define kAnimationRotateDeg 10.0
@implementation CellViewAnimator
+(CellViewAnimator*)sharedInstance
{
    static dispatch_once_t onceToken;
    static CellViewAnimator *animator=nil;
    dispatch_once( &onceToken, ^{
        animator = [[[self class] alloc] init];
        
        
    });
    return animator;
}
-(id)init
{
    self = [super init];
    if(self)
    {
        //******************** cell removal actions *******************************
        
        SKAction *scaleUp = [SKAction scaleTo:1.8 duration:0.22];
        
        
        SKAction *fadeOutDelay = [SKAction waitForDuration:0.11];
        SKAction *fadeOut = [SKAction fadeOutWithDuration:0.11];
        SKAction *fadeOutSequense = [SKAction sequence:@[fadeOutDelay,fadeOut]];
        
        
        _scaleUpFadeOutGroup = [SKAction group:@[scaleUp,fadeOutSequense]];
        
        
        
        //******************** cell addition actions *******************************
        
        SKAction *fadeIn = [SKAction fadeInWithDuration:0.2];
        SKAction *scaleAction = [SKAction scaleTo:1.4 duration:0.2];
        
        _fadeInScaleUp = [SKAction group:@[fadeIn,scaleAction]];
        
        _scaleDownAction = [SKAction scaleTo:1.0 duration:0.1];
        
        
        
        
        SKAction *rotateLeftAction = [SKAction rotateByAngle:degreesToRadians( (kAnimationRotateDeg * -1.0)  ) duration:0.07];
        
        SKAction *rotateRightAction = [SKAction rotateByAngle:degreesToRadians( kAnimationRotateDeg  ) duration:0.07];
        _jigglingAction = [SKAction repeatActionForever:[SKAction sequence:@[rotateLeftAction,rotateRightAction,rotateRightAction,rotateLeftAction]]];
        
        
        _resetJigglingAction = [SKAction rotateToAngle:0 duration:0.05];
    }
    
    return self;
}
@end
