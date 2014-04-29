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
        
        
        //SKAction *scaleUp = [SKAction scaleTo:1.8 duration:0.22];
        
        CGFloat removalDuration = 0.17;
       // SKAction *fadeOutDelay = [SKAction waitForDuration:0.09];
        SKAction *fadeOut = [SKAction fadeOutWithDuration:removalDuration];
        //SKAction *fadeOutSequense = [SKAction sequence:@[fadeOutDelay,fadeOut]];
        
        
        
        SKAction *squeezeAction = [SKAction scaleXTo:4.0 y:0.2 duration:removalDuration];
        
        
        _removalHorizontal = [SKAction group:@[squeezeAction,fadeOut]];
        
        
        
        SKAction *squeezeVertical = [SKAction scaleXTo:0.2 y:4.0 duration:removalDuration];
        
        _removalVertical = [SKAction group:@[squeezeVertical,fadeOut]];
        
        
        
        SKAction *squeezeDiagonalToTheRight = [SKAction scaleXTo:4.0 y:0.2 duration:removalDuration];
        
        SKAction *rotateToTheRight = [SKAction rotateByAngle:degreesToRadians( 45.0  ) duration:0.0];
        
        _removalDiagonalToTheRight = [SKAction group:@[rotateToTheRight,squeezeDiagonalToTheRight,fadeOut]];
        
        
        
        SKAction *rotateToTheLeft = [SKAction rotateByAngle:degreesToRadians( -45.0  ) duration:0.0];
        
        _removalDiagonalToTheLeft = [SKAction group:@[rotateToTheLeft,squeezeDiagonalToTheRight,fadeOut]];
        
        
        SKAction *rotateReset = [SKAction rotateToAngle:degreesToRadians( 0.0  ) duration:0.0];
        
        SKAction *scaleReset = [SKAction scaleXTo:1.0 y:1.0 duration:0.0];
        
        _removalReset = [SKAction group:@[rotateReset,scaleReset]];
        
        //******************** cell addition actions *******************************
        
        SKAction *fadeIn = [SKAction fadeInWithDuration:0.2];
        SKAction *scaleAction = [SKAction scaleTo:1.4 duration:0.2];
        
        _fadeInScaleUp = [SKAction group:@[fadeIn,scaleAction]];
        
        _scaleDownAction = [SKAction scaleTo:1.0 duration:0.1];
        
        
        /*SKAction *squeezeAction = [SKAction scaleXTo:1.2 y:0.8 duration:0.3];
        
        SKAction *squeezeReverse = [SKAction scaleXTo:0.8 y:1.2 duration:0.3];
        
        SKAction *squeezeSequense = [SKAction sequence:@[squeezeAction,squeezeReverse]];
        
        SKAction *squeezeRepeat = [SKAction repeatActionForever:squeezeSequense];*/
        
        SKAction *rotateLeftAction = [SKAction rotateByAngle:degreesToRadians( (kAnimationRotateDeg * -1.0)  ) duration:0.07];
        
        SKAction *rotateRightAction = [SKAction rotateByAngle:degreesToRadians( kAnimationRotateDeg  ) duration:0.07];
        SKAction *jiigleAction = [SKAction repeatActionForever:[SKAction sequence:@[rotateLeftAction,rotateRightAction,rotateRightAction,rotateLeftAction]]];
        
        //SKAction *groupAction = [SKAction group:@[jiigleAction,squeezeRepeat]];
        
        _jigglingAction = jiigleAction;
        
        
        SKAction *squeezeReset = [SKAction scaleXTo:1.0 y:1.0 duration:0.05];
        
        _resetJigglingAction = [SKAction group:@[squeezeReset,[SKAction rotateToAngle:0 duration:0.05]]];
        
    }
    
    return self;
}
@end
