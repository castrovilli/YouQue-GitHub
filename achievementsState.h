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
#define FRUITS5_ACHIEVEMENT @"5fruitsAchieved"
@protocol AchievementsStateDelegate;
@interface achievementsState : NSObject <NSCoding,NSCopying>
{
    
}
@property(nonatomic,weak)id<AchievementsStateDelegate> delegate;

-(void)reportAchievementWithNumberOfClearedOutCells:(NSUInteger)NoOfClearedOutCells Newlevel:(int)Newlevel OldLevel:(int)oldLevel;
@end
@protocol AchievementsStateDelegate <NSObject>

-(void)addAchievementsPoints:(int)newPoints;

@end