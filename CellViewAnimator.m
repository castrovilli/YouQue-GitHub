//
//  CellViewAnimator.m
//  YouQue
//
//  Created by Mohammed Eldehairy on 4/27/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import "CellViewAnimator.h"
#define degreesToRadians(x) (M_PI * (x) / 180.0)
#define kAnimationRotateDeg 12.0
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
        
        
        SKAction *scaleUp = [SKAction scaleTo:2.0 duration:0.2];
        
        SKAction *fadeout = [SKAction fadeOutWithDuration:0.2];
        
        SKAction *remove = [SKAction group:@[scaleUp,fadeout]];
        
        SKAction *reverse = [SKAction group:@[[SKAction scaleTo:1.0 duration:0.0],[SKAction fadeInWithDuration:0.0]]];
        
        _removalAction = [SKAction sequence:@[remove,reverse]];
        
        //******************** cell addition actions *******************************
        
        SKAction *fadeIn = [SKAction fadeInWithDuration:0.2];
        SKAction *scaleAction = [SKAction scaleTo:1.4 duration:0.2];
        
        _fadeInScaleUp = [SKAction group:@[fadeIn,scaleAction]];
        
        _scaleDownAction = [SKAction scaleTo:1.0 duration:0.1];
        
        
        /*SKAction *squeezeAction = [SKAction scaleXTo:1.2 y:0.8 duration:0.3];
        
        SKAction *squeezeReverse = [SKAction scaleXTo:0.8 y:1.2 duration:0.3];
        
        SKAction *squeezeSequense = [SKAction sequence:@[squeezeAction,squeezeReverse]];
        
        SKAction *squeezeRepeat = [SKAction repeatActionForever:squeezeSequense];*/
        
        SKAction *rotateLeftAction = [SKAction rotateByAngle:degreesToRadians( (kAnimationRotateDeg * -1.0)  ) duration:0.075];
        
        SKAction *rotateRightAction = [SKAction rotateByAngle:degreesToRadians( kAnimationRotateDeg  ) duration:0.075];
        SKAction *jiigleAction = [SKAction repeatActionForever:[SKAction sequence:@[rotateLeftAction,rotateRightAction,rotateRightAction,rotateLeftAction]]];
        
        //SKAction *groupAction = [SKAction group:@[jiigleAction,squeezeRepeat]];
        
        _jigglingAction = jiigleAction;
        
        
        SKAction *squeezeReset = [SKAction scaleXTo:1.0 y:1.0 duration:0.05];
        
        _resetJigglingAction = [SKAction group:@[squeezeReset,[SKAction rotateToAngle:0 duration:0.05]]];
        
    }
    
    return self;
}
@end
