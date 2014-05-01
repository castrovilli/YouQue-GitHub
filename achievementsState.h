//
//  achievementsState.h
//  Connect5
//
//  Created by Mohammed Eldehairy on 4/24/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
@interface achievementsState : NSObject <NSCoding,NSCopying>


-(void)reportAchievementWithNumberOfConsecutiveClearedOutMoves:(NSUInteger)NoOfConsecutiveClearedOutMoves NumberOfClearedOutCells:(NSUInteger)NoOfClearedOutCells level:(int)level;
@end
