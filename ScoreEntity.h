//
//  ScoreEntity.h
//  Connect5
//
//  Created by Mohammed Eldehairy on 10/20/13.
//  Copyright (c) 2013 Mohammed Eldehairy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICloudManager.h"
@protocol ScoreEntityDelegate;
@interface ScoreEntity : NSObject<NSCoding,NSCopying>
@property(nonatomic,weak)id<ScoreEntityDelegate> levelDelegate;
@property(nonatomic,readonly)int score;
@property(nonatomic,readonly)int numberOfConsecutiveRowCollection;
-(int)ReportScoreWithNumberOfDetectedCells:(NSUInteger)numberOfDetectedCells;
-(void)ResetScore;
-(void)reportAchievementsPoints:(int)newPoints;
@end
@protocol ScoreEntityDelegate <NSObject>

-(void)newScore:(int)score;

@end