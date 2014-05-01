//
//  achievementsState.m
//  Connect5
//
//  Created by Mohammed Eldehairy on 4/24/14.
//  Copyright (c) 2014 Mohammed Eldehairy. All rights reserved.
//

#import "achievementsState.h"
@interface achievementsState()

@property(nonatomic,assign)NSUInteger numberOfConsecutiveRowCollection;
@property(nonatomic,assign)NSUInteger numberOfClearedOutCells;

@end
@implementation achievementsState
-(id)init
{
    self = [super init];
    if(self)
    {
        self.numberOfClearedOutCells = 0;
        self.numberOfConsecutiveRowCollection = 0;
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.numberOfClearedOutCells = ((NSNumber*)[aDecoder decodeObjectForKey:@"numberOfClearedOutCells"]).integerValue;
        self.numberOfConsecutiveRowCollection = ((NSNumber*)[aDecoder decodeObjectForKey:@"numberOfConsecutiveRowCollection"]).integerValue;
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[NSNumber numberWithInteger:self.numberOfClearedOutCells] forKey:@"numberOfClearedOutCells"];
    [aCoder encodeObject:[NSNumber numberWithInteger:self.numberOfConsecutiveRowCollection] forKey:@"numberOfConsecutiveRowCollection"];
}
-(id)copyWithZone:(NSZone *)zone
{
    achievementsState *copy = [[achievementsState alloc] init];
    if(copy)
    {
        [copy setNumberOfClearedOutCells:self.numberOfClearedOutCells];
        [copy setNumberOfConsecutiveRowCollection:self.numberOfConsecutiveRowCollection];
        
    }
    return copy;
}
-(void)reportAchievementWithNumberOfConsecutiveClearedOutMoves:(NSUInteger)NoOfConsecutiveClearedOutMoves NumberOfClearedOutCells:(NSUInteger)NoOfClearedOutCells level:(int)level
{
    self.numberOfClearedOutCells += NoOfClearedOutCells;
    self.numberOfConsecutiveRowCollection = NoOfConsecutiveClearedOutMoves;
    
   
}
- (void) reportAchievements:(NSArray*)achievements
{
    
    [GKAchievement reportAchievements: achievements withCompletionHandler:^(NSError *error)
     {
         if (error != nil)
         {
             NSLog(@"Error in reporting achievements: %@", error);
         }
     }];
}
@end
