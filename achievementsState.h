//
//  achievementsState.h
//  Connect5
//
//  Created by Mohammed Eldehairy on 4/24/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//
#import "FaceBookManager.h"
#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "MDAchievement.h"
#define FRUITS5_ACHIEVEMENT @"5fruitsAchieved"
#define ACHIEVEMENTS_INFO_KEY @"achievements"
@protocol AchievementsStateDelegate;
@interface achievementsState : NSObject <NSCoding,NSCopying>
{
    MDAchievement *fruits5Achievement;
    MDAchievement *fruits6Achievement;
    MDAchievement *fruits7Achievement;
    
    MDAchievement *Combo2xAchievement;
    MDAchievement *Combo4xAchievement;
    MDAchievement *Combo6xAchievement;
    MDAchievement *Combo8xAchievement;
    MDAchievement *Combo10xAchievement;
    
    MDAchievement *level2Achievement;
    MDAchievement *level3Achievement;
    MDAchievement *level4Achievement;
    
    
    
    
    ShareEntity *fruits5ShareEntity;
    ShareEntity *fruits6ShareEntity;
    ShareEntity *fruits7ShareEntity;
    
    ShareEntity *combo2xShareEntity;
    ShareEntity *combo4xShareEntity;
    ShareEntity *combo6xShareEntity;
    ShareEntity *combo8xShareEntity;
    ShareEntity *combo10xShareEntity;
    
}
@property(nonatomic,weak)id<AchievementsStateDelegate> delegate;

-(void)reportAchievementWithNumberOfClearedOutCells:(NSUInteger)NoOfClearedOutCells Newlevel:(int)Newlevel OldLevel:(int)oldLevel;
-(void)resetCounter;
-(void)reportYouQueAchievements;
@end
@protocol AchievementsStateDelegate <NSObject>

-(void)addAchievementsPoints:(int)newPoints;

@end