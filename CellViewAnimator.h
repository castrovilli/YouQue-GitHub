//
//  CellViewAnimator.h
//  YouQue
//
//  Created by Mohammed Eldehairy on 4/27/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface CellViewAnimator : NSObject
{
    
    
    
    
    
    
    
    
    
    
    
}
+(CellViewAnimator*)sharedInstance;

//******************** cell removal actions *******************************
@property(nonatomic,retain,readonly)SKAction *removalAction;


//******************** cell addition actions *******************************
@property(nonatomic,retain,readonly)SKAction *fadeInScaleUp ;
@property(nonatomic,retain,readonly)SKAction *scaleDownAction ;

//******************** cell jiggling actions *******************************
@property(nonatomic,retain,readonly)SKAction *jigglingAction ;
@property(nonatomic,retain,readonly)SKAction *resetJigglingAction;
@end
