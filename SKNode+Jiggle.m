//
//  SKNode+Jiggle.m
//  YouQue
//
//  Created by Mohammed Eldehairy on 4/26/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import "SKNode+Jiggle.h"

@implementation SKNode (Jiggle)
#define degreesToRadians(x) (M_PI * (x) / 180.0)
#define kAnimationRotateDeg 10.0

- (void)startJiggling {
    NSInteger randomInt = arc4random_uniform(500);
    float r = (randomInt/500.0)+0.5;
    
    SKAction *rotateLeftAction = [SKAction rotateByAngle:degreesToRadians( (kAnimationRotateDeg * -1.0) - r ) duration:0.07];
    
    SKAction *rotateRightAction = [SKAction rotateByAngle:degreesToRadians( kAnimationRotateDeg + r ) duration:0.07];
    SKAction *repeatAction = [SKAction repeatActionForever:[SKAction sequence:@[rotateLeftAction,rotateRightAction,rotateRightAction,rotateLeftAction]]];
    [self runAction:repeatAction withKey:@"jiggle"];
}
- (void)stopJiggling {
    
    [self removeActionForKey:@"jiggle"];
    SKAction *resetAction = [SKAction rotateToAngle:0 duration:0.05];
    [self runAction:resetAction];
}

@end
