//
//  LevelProvider.h
//  Connect5
//
//  Created by Mohammed Eldehairy on 11/6/13.
//  Copyright (c) 2013 Mohammed Eldehairy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LevelEntity.h"
#import "ScoreEntity.h"
#define LEVEL_RANGE 10.0f
@protocol LevelProviderDelegate;
@interface LevelProvider : NSObject<ScoreEntityDelegate>


@property(nonatomic,weak)id<LevelProviderDelegate> delegate;


-(id)initWithNumberOfLevels:(int)noOfLevels;


-(LevelEntity*)GetCurrentLevel;
-(void)ResetLevel;
-(BOOL)isFinalLevel;
@end


@protocol LevelProviderDelegate <NSObject>
-(void)levelProvider:(LevelProvider*)levelProvider LevelChanged:(LevelEntity*)newLevel;
@end