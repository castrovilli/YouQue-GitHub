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
#define ACHIEVEMENTS_LAST_SHARE_DATE_KEY @"lastAchievementShareDate"
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
    
    
    
    MDAchievement *YouQueBeginner;
    
    MDAchievement *YouQueIntermediate;
    
    MDAchievement *YouQueMaster;
    
    MDAchievement *YouQueHardcore;
   
    
    
    NSMutableSet *entitiesToBeShared;
    
}
@property(nonatomic,weak)id<AchievementsStateDelegate> delegate;

-(void)reportAchievementWithNumberOfClearedOutCells:(NSUInteger)NoOfClearedOutCells Newlevel:(int)Newlevel OldLevel:(int)oldLevel;
-(void)resetCounter;
-(void)postAchievements;
@end
@protocol AchievementsStateDelegate <NSObject>

-(void)addAchievementsPoints:(int)newPoints;

@end