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
-(void)reportAchievementWithNumberOfClearedOutCells:(NSUInteger)NoOfClearedOutCells Newlevel:(int)Newlevel OldLevel:(int)oldLevel
{
    
    if(NoOfClearedOutCells == 0)
    {
        _numberOfConsecutiveRowCollection = 0;
        
    }else
    {
        _numberOfConsecutiveRowCollection++;
    }
    
    self.numberOfClearedOutCells += NoOfClearedOutCells;
    
    NSMutableArray *achievements = [NSMutableArray array];
    if(NoOfClearedOutCells == 5)
    {
        MDAchievement *acheievement = [[MDAchievement alloc] initWithIdentifier:@"5fruits" title:@"5 fruits" points:10];
        
        GKAchievement *achievement = [self achievementWitjIdentifier:@"5fruits" withPercentage:100.0];
        [achievements addObject:acheievement];
        
        NSLog(@"%@",achievement.identifier);
    }
    if(NoOfClearedOutCells == 6)
    {
        MDAchievement *acheievement = [[MDAchievement alloc] initWithIdentifier:@"6fruits" title:@"6 fruits" points:10];
        
        GKAchievement *achievement = [self achievementWitjIdentifier:@"6fruits" withPercentage:100.0];
        [achievements addObject:acheievement];
        
        NSLog(@"%@",achievement.identifier);
    }
    
    if(NoOfClearedOutCells == 7)
    {
        MDAchievement *acheievement = [[MDAchievement alloc] initWithIdentifier:@"7fruits" title:@"7 fruits" points:10];
        
        [achievements addObject:acheievement];
        
        
        
        NSLog(@"%@",acheievement.identifier);
        ShareEntity *entity = [[ShareEntity alloc] initWithMessage:[NSString stringWithFormat:@"%@ achieved 7 fruits",[[FaceBookManager sharedInstance] FullName]] link:@"https://itunes.apple.com/eg/app/youque/id721318647?mt=8" name:@"YouQue" description:@"New Achievement"];
        [self shareEntity:entity];
    }
    
    if(_numberOfConsecutiveRowCollection == 2)
    {
        MDAchievement *acheievement = [[MDAchievement alloc] initWithIdentifier:@"2xCombo" title:@"2x Combo" points:10];

        [achievements addObject:acheievement];
        
        NSLog(@"%@",acheievement.identifier);
    }
    
    if(_numberOfConsecutiveRowCollection == 4)
    {
        MDAchievement *acheievement = [[MDAchievement alloc] initWithIdentifier:@"4xCombo" title:@"4x Combo" points:40];
        
        [achievements addObject:acheievement];
        
        NSLog(@"%@",acheievement.identifier);
    }
    
    if(_numberOfConsecutiveRowCollection == 6)
    {
        MDAchievement *acheievement = [[MDAchievement alloc] initWithIdentifier:@"6xCombo" title:@"6x Combo" points:60];
        
        [achievements addObject:acheievement];
        
        NSLog(@"%@",acheievement.identifier);
        ShareEntity *entity = [[ShareEntity alloc] initWithMessage:[NSString stringWithFormat:@"%@ achieved 6x Combo",[[FaceBookManager sharedInstance] FullName]] link:@"https://itunes.apple.com/eg/app/youque/id721318647?mt=8" name:@"YouQue" description:@"New Achievement"];
        [self shareEntity:entity];
    }
    
    if(_numberOfConsecutiveRowCollection == 8)
    {
        MDAchievement *acheievement = [[MDAchievement alloc] initWithIdentifier:@"8xCombo" title:@"8x Combo" points:80];
        
        [achievements addObject:acheievement];
        
        NSLog(@"%@",acheievement.identifier);
        
        ShareEntity *entity = [[ShareEntity alloc] initWithMessage:[NSString stringWithFormat:@"%@ achieved 8x Combo",[[FaceBookManager sharedInstance] FullName]] link:@"https://itunes.apple.com/eg/app/youque/id721318647?mt=8" name:@"YouQue" description:@"New Achievement"];
        [self shareEntity:entity];
    }
    
    if(_numberOfConsecutiveRowCollection == 10)
    {
        MDAchievement *acheievement = [[MDAchievement alloc] initWithIdentifier:@"10xCombo" title:@"10x Combo" points:100];
    
        [achievements addObject:acheievement];
        
        NSLog(@"%@",acheievement.identifier);
        
        ShareEntity *entity = [[ShareEntity alloc] initWithMessage:[NSString stringWithFormat:@"%@ achieved 10x Combo",[[FaceBookManager sharedInstance] FullName]] link:@"https://itunes.apple.com/eg/app/youque/id721318647?mt=8" name:@"YouQue" description:@"New Achievement"];
        [self shareEntity:entity];
    }
    
    GKAchievement *newLevelAch = [self newLevelAchievement:Newlevel oldLevel:oldLevel];
    
    if(newLevelAch)
    {
        [achievements addObject:newLevelAch];
        NSLog(@"%@",newLevelAch.identifier);
    }
    
    if(achievements.count > 0)
    {
        [self reportAchievements:achievements];
        [[NSNotificationCenter defaultCenter] postNotificationName:FRUITS5_ACHIEVEMENT object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:achievements,ACHIEVEMENTS_INFO_KEY, nil]];
    }
    
   
}
-(void)shareEntity:(ShareEntity*)entity
{
    //[[FaceBookManager sharedInstance] share:entity];
}
-(void)notifyDelegateWithNewPoints:(int)points
{
    if([_delegate respondsToSelector:@selector(addAchievementsPoints:)])
    {
        [_delegate addAchievementsPoints:points];
    }
}
-(GKAchievement*)newLevelAchievement:(int)Newlevel oldLevel:(int)oldLevel
{
    if(oldLevel == Newlevel)
    {
        return nil;
        
    }
    
    if(Newlevel == 2)
    {
        return [self achievementWitjIdentifier:@"level2" withPercentage:100.0];
    }else if(Newlevel == 3)
    {
        return [self achievementWitjIdentifier:@"level3" withPercentage:100.0];
    }else if(Newlevel == 4)
    {
        return [self achievementWitjIdentifier:@"level4" withPercentage:100.0];
    }else
    {
        return nil;
    }
}

-(GKAchievement*)achievementWitjIdentifier:(NSString*)ID withPercentage:(double)percent
{
    GKAchievement *achievement = [[GKAchievement alloc] initWithIdentifier:ID];
    achievement.percentComplete = percent;
    
    return achievement;
}
- (void) reportAchievements:(NSArray*)achievements
{
    NSMutableArray *GKAchievements = [NSMutableArray array];
    
    for(MDAchievement *ach in achievements)
    {
        GKAchievement *GkAch = [[GKAchievement alloc] initWithIdentifier:ach.identifier];
        GkAch.percentComplete = 100;
        [GKAchievements addObject:GkAch];
    }
    [GKAchievement reportAchievements: GKAchievements withCompletionHandler:^(NSError *error)
     {
         if (error != nil)
         {
             NSLog(@"Error in reporting achievements: %@", error);
         }
     }];
}

-(void)shareAchievements:(NSArray*)achievements
{
    for(GKAchievement *ach in achievements)
    {
        ShareEntity *entity = [[ShareEntity alloc] initWithMessage:[NSString stringWithFormat:@"%@ achieved %@",[[FaceBookManager sharedInstance] FullName],ach.identifier] link:@"https://itunes.apple.com/eg/app/youque/id721318647?mt=8" name:@"YouQue" description:@"New Achievement"];
        [[FaceBookManager sharedInstance] share:entity];
    }
    
}
@end
