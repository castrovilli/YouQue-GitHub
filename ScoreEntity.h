//
//  ScoreEntity.h
//  Connect5
//
//  Created by Mohammed Eldehairy on 10/20/13.
//  Copyright (c) 2013 Mohammed Eldehairy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICloudManager.h"
@interface ScoreEntity : NSObject<NSCoding,NSCopying>
@property(nonatomic)int score;
@property(nonatomic)int numberOfConsecutiveRowCollection;
-(void)ReportScoreWithNumberOfDetectedCells:(NSUInteger)numberOfDetectedCells;
-(void)ResetScore;
@end
